SOURCES = packages __tests__

test:
	npm test

test-watch:
	npm test -- --watch --notify

lint:
	npm run lint

fix:
	npm run lint -- --fix

link-packages-to-local-npm:
	npx lerna exec --concurrency 1 --stream --no-bail -- npm link