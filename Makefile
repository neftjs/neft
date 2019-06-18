SOURCES = packages __tests__

bootstrap:
	yarn lerna bootstrap

test:
	yarn test

test-watch:
	yarn test --watch --notify

lint:
	yarn lint

lint-fix:
	yarn lint --fix

publish-to-verdaccio:
	npx lerna exec -- npm unpublish --registry http://localhost:4873 -f
	npx lerna exec -- npm publish --registry http://localhost:4873

generate-docs:
	(cd ./packages/docs/editor && yarn bundle)
	(cd ./packages/docs/editor-view-app && yarn neft build html)
	node ./packages/docs/generator
