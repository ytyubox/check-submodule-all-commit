install:
	swift build -c release
	install .build/release/check-submodule-all-commit .git/hooks/pre-commit
