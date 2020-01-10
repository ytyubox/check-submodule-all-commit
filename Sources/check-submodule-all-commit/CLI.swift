import Foundation
import Files
import ShellOut

public struct CLI {
	public init() {
	}
	
	public func run(in folder: Folder = .current) throws {
		let info = try shellOut(to: "git submodule foreach 'git status -s'")
		print(info)
		try info
			.split(separator: "\n")
			.map(String.init)
			.allSatisfy({$0.hasPrefix("En")})
			.catch { throw "commit fail, please check submodules" }
	}
}

extension String:Error {
	
}

extension Bool {
	var not:Self{!self}
	@discardableResult
	func then(_ handler: () throws -> Void ) rethrows -> Self {
		if self { try handler()}
		return self
	}
	@discardableResult
	func `catch`(_ handler: ()throws -> Void ) rethrows -> Self {
		if !self { try handler()}
		return self
	}
}
