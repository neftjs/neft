SOURCES = packages __tests__

test:
	npx jest

test-watch:
	npx jest --watch --notify

lint:
	npx eslint $(SOURCES)

fix:
	npx eslint $(SOURCES) --fix
