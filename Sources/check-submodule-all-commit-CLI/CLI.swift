import Foundation
import Files
import ShellOut

public struct CLI {
	public init() {
	}
	
	public func run(in folder: Folder = .current) throws {
		let folder = Folder.current
		print(try shellOut(to: .pwd))
		try shellOut(to:
			.getSubmodule,
					 at: folder.path
		)
	}
}

extension ShellOutCommand {
	static var getSubmodule:Self {
		.init(string: "git rev-parse --show-cdup")
	}
	static var pwd:Self {
		.init(string: "pwd")
	}
}
