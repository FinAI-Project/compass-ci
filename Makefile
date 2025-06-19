all: fmt

.PHONY: fmt
fmt:
	@sort -o runtime/requirements.txt runtime/requirements.txt
	@echo "The requirements.txt file has been sorted alphabetically."
