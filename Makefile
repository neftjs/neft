SOURCES = packages __tests__

test:
	npm test

test-watch:
	npm test -- --watch --notify

lint:
	npm run lint

fix:
	npm run lint -- --fix
