.PHONY: build
build:
	go generate ./...
	env GOOS=linux go build -ldflags="-s -w" -o bin/hello hello/*.go

.PHONY: clean
clean:
	rm -rf ./bin

.PHONY: deploy
deploy: clean build
	sls deploy --verbose
