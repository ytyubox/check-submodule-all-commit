import Foundation
let cli = CLI()


do {
	try cli.run()
} catch {
	fputs("❌ \(error)\n", stderr)
	exit(1)
}
