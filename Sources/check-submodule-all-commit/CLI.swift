import Foundation
import Files
import ShellOut

public struct CLI {
	public init() {
	}
	
	public func run(in folder: Folder = .current) throws {
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
//		try s.forEach{try shellOut(to: "git fsck", at: $0)}
		let r =
			try s.map{try shellOut(to: "git status", at: $0)}
		
		r.forEach{print($0)}
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
