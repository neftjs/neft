test:
	yarn test

test-watch:
	yarn test --watch --notify

lint:
	yarn lint

lint-fix:
	yarn lint --fix

publish-to-verdaccio:
	yarn lerna exec -- npm unpublish --registry http://localhost:4873 -f
	yarn lerna exec -- npm publish --registry http://localhost:4873

generate-docs:
	(cd ./packages/docs/editor && yarn bundle)
	(cd ./packages/docs/editor-view-app && yarn neft build html)
	node ./packages/docs/generator

build-packages:
	yarn lerna run build --stream --no-sort
