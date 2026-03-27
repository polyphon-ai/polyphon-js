.PHONY: build test lint clean

build:
	npm run build

test:
	npm test

lint:
	npm run lint

clean:
	rm -rf dist
