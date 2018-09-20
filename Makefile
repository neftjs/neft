SOURCES = packages

test:
	npx jest

lint:
	npx eslint $(SOURCES)

fix:
	npx eslint $(SOURCES) --fix
