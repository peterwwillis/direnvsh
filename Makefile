all: clean README.md

clean:
	rm -f README.md

README.md:
	( cat README.md.tmpl ; ./direnvsh -h | sed -e 's/^/    /g' ) > README.md

