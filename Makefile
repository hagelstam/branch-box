GOFILES = $(shell find . -name \*.go)

build: # Build the application
	@go build -o bin/main src/main.go

run: # Run the application
	@go run src/main.go

test: # Run tests
	@go vet ./...
	@go test ./... -v -cover

fmt: # Verify gofmt and goimports
	@echo "Verifying gofmt..."
	@!(gofmt -l -s -d ${GOFILES} | grep '[a-z]')

	@echo "Verifying goimports..."
	@!(go run golang.org/x/tools/cmd/goimports@latest -l -d ${GOFILES} | grep '[a-z]')

lint: # Lint
	@if command -v golangci-lint > /dev/null; then \
		golangci-lint run ./...; \
	else \
		echo "installing golangci-lint..."; \
		go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest; \
		golangci-lint run ./...; \
	fi

help: # Print help
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

.PHONY: build run test fmt lint help