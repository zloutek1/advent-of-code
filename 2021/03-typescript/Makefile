all: compile run

install:
	npm i @types/node typescript
	npx tsc --init

compile:
	npx tsc main.ts

run:
	node main.js

clean:
	rm -f main.js
	rm -rf node_modules package-lock.json package.json tsconfig.json
