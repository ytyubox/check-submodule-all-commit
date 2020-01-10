install:
	swift build -c release
	install .build/release/check-submodule-all-commit-CLI .git/hooks/pre-commit
