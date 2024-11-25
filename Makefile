elm: format
	elm make Main.elm --output elm.js

format:
	elm-format Main.elm src/*.elm tests/*.elm --yes
