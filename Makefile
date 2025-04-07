all: fmt

.PHONY: fmt
fmt:
	@sort -o scripts/requirements.txt scripts/requirements.txt
	@echo "The requirements.txt file has been sorted alphabetically."
