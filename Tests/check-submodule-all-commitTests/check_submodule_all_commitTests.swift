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
		let repo = try container.createSubfolder(named: "Repo")
		try shellOut(to: .gitInit(), at: remote1.path)
		try shellOut(to: .gitInit(), at: remote2.path)
		try remote1.createFileIfNeeded(withName: "file")
		try remote2.createFileIfNeeded(withName: "file")
		try shellOut(to: .gitCommit(message: "add file"), at: remote1.path)
		try shellOut(to: .gitCommit(message: "add file"), at: remote2.path)
		try shellOut(to: .gitInit(), at: repo.path)
		try shellOut(to: "git submodule add \(remote1.path) remote1", at: repo.path)
		try shellOut(to: "git submodule add \(remote2.path) remote2", at: repo.path)
		//		print(try shellOut(to: "git rev-parse --show-cdup", at: repo.path))
		let cli = CLI()
		do {
			try	cli.run(in: repo)
		}catch {
			print(error)
		}
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
