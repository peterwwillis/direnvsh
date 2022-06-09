all: clean shellcheck test README.md

clean:
	rm -f README.md

test: test-simple-mode test-dynamic-mode

test-simple-mode:
	OPWD="`pwd`"; cd test/simple-mode/1/2/3 ; "$$OPWD/direnvsh"

test-dynamic-mode:
	OPWD="`pwd`"; cd test/dynamic-mode/1/2/3 ; "$$OPWD/direnvsh" -D

shellcheck:
	shellcheck direnvsh

README.md:
	( cat README.md.tmpl ; ./direnvsh -h | sed -e 's/^/    /g' ) > README.md

