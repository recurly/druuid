
test:
	@node_modules/.bin/mocha --require should spec/druuid_spec

.PHONY: test
