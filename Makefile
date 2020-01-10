NO_COLOR=\x1b[0m
OK_COLOR=\033[0;32m
PRE_STRING=$(OK_COLOR)pre-commit$(NO_COLOR)
COMMAND_STRING=$(OK_COLOR)cp pre-commit .git/hooks/pre-commit$(NO_COLOR)


WARN_STRING=$(WARN_COLOR)[WARNINGS]$(NO_COLOR)

install:
	@echo "making $(PRE_STRING)"
	@swift build -c release
	@install .build/release/check-submodule-all-commit pre-commit
	@echo "🍺 successfully gen $(PRE_STRING)"
	@echo "please do $(COMMAND_STRING) to work"
