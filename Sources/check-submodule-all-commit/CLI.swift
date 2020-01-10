import Foundation
import Files
import ShellOut

public struct CLI {
	public init() {
	}
	
	public func run(in folder: Folder = .current) throws {
		let info = try folder.file(named: ".gitmodules").readAsString()
		let s = try
			info
				.split(separator: "\n")
				.filter{$0.contains("path")}
				.map{ $0.suffix(of: " ")}
				.map(String.init)
				.map{$0}
				.map(folder.subfolder(at:))
				.map{$0.path}
				.map{try shellOut(to: "pwd", at: $0)}
		dump(s)
		//			.map{"git --git-dir \($0)/.git --work-tree=\($0) status -s"}
		//		print(r)
	}
}

extension ShellOutCommand {
	static var getSubmodule: ShellOutCommand {
		.init(string: "git rev-parse --show-cdup")
	}
	static var pwd:Self {
		.init(string: "pwd")
	}
}


extension Substring {
	
	func suffix(of text:Character) -> Substring {
		
		let index = self.lastIndex(of: text) ?? endIndex
		let next = self.index(after: index)
		return self[next...]
	}
}
