SOURCES = packages __tests__

test:
	npm test

test-watch:
	npm test -- --watch --notify

lint:
	npm run lint

fix:
	npm run lint -- --fix

publish-to-verdaccio:
	npx lerna exec -- npm unpublish --registry http://localhost:4873 -f
	npx lerna exec -- npm publish --registry http://localhost:4873