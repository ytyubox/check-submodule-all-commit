import XCTest
import Files
import Foundation
import ShellOut
@testable import check_submodule_all_commit

final class check_submodule_all_commitTests: XCTestCase {
	func testGitDeploymentMethod() throws {
		let container = try Folder.createTemporary()
		let remote1 = try container.createSubfolder(named: "Remote")
		let remote2 = try container.createSubfolder(named: "Remote2")
		let folder = try container.createSubfolder(named: "Repo")
		try shellOut(to: .gitInit(), at: remote1.path)
		try shellOut(to: .gitInit(), at: remote2.path)
		try remote1.createFileIfNeeded(withName: "file")
		try remote2.createFileIfNeeded(withName: "file")
		try shellOut(to: .gitCommit(message: "add file"), at: remote1.path)
		try shellOut(to: .gitCommit(message: "add file"), at: remote2.path)
		try shellOut(to: .gitInit(), at: folder.path)
		try shellOut(to: "git submodule add \(remote1.path) remote1", at: folder.path)
		try shellOut(to: "git submodule add \(remote2.path) remote2", at: folder.path)
		//		print(try shellOut(to: "git rev-parse --show-cdup", at: repo.path))
		let info = try folder.file(named: ".gitmodules").readAsString()
		print(try shellOut(to: "whoami"))
		let s = try
			info
				.split(separator: "\n")
				.filter{$0.contains("path")}
				.map{ $0.suffix(of: " ")}
				.map(String.init)
				.map{$0}
				.map(folder.subfolder(at:))
				.map{$0.path}
		//				.map{try shellOut(to: "git --version", at: $0)}
		//.map{"git  \($0)/.git --work-tree=\($0) status -s"}
		try s.forEach{try shellOut(to: "git fsck", at: $0)}
		let r =
			try s.map{try shellOut(to: "git status", at: $0)}
		
		r.forEach{print($0)}
	}
}



extension Folder {
	static func createTemporary() throws -> Self {
		let parent = try createTestsFolder()
		return try parent.createSubfolder(named: .unique())
	}
}

private extension Folder {
	static func createTestsFolder() throws -> Self {
		try Folder.temporary.createSubfolderIfNeeded(at: "PublishTests")
	}
}

extension String {
	static func unique() -> String {
		UUID().uuidString
	}
}

extension Substring {
	public
	func suffix(of text:Character) -> Substring {
		
		let index = self.lastIndex(of: text) ?? endIndex
		let next = self.index(after: index)
		return self[next...]
	}
}
