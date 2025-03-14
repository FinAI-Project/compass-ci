all: fmt

.PHONY: fmt
fmt:
	@sort -o requirements.txt requirements.txt
	@echo "The requirements.txt file has been sorted alphabetically."
