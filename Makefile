elm: format
	elm make ProductList.elm --output public/product-list.js --debug
	elm make CategoryFilters.elm --output public/category-filters.js --debug

format:
	elm-format *.elm --yes

prettier:
	npx prettier -w .
