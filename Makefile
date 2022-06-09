all: clean shellcheck test README.md

clean:
	rm -f README.md

test: test-simple-mode test-dynamic-mode test-export-mode

test-simple-mode:
	@OPWD="`pwd`"; cd test/simple-mode/1/2/3 ; \
	RESULT="`env -i ../../../../../direnvsh sh -c 'echo $$THIS'`" ; \
	if [ ! "$$RESULT" = "THAT BAZ thing here VAR" ] ; then \
		echo "ERROR: simple mode failed" ; exit 1 ; \
	fi

test-dynamic-mode:
	@OPWD="`pwd`"; cd test/dynamic-mode/1/2/3 ; \
	RESULT="`env -i ../../../../../direnvsh -D sh -c 'echo $$THIS'`" ; \
	if [ ! "$$RESULT" = "THAT BAZ thing here VAR" ] ; then \
		echo "ERROR: dynamic mode failed" ; exit 1 ; \
	fi

test-export-mode:
	@OPWD="`pwd`"; cd test/export-mode/1/2/3 ; \
	RESULT="`env -i ../../../../../direnvsh -E sh -c 'echo $$THIS'`" ; \
	if [ ! "$$RESULT" = "THAT sOMETHINg ELSE VAR" ] ; then \
		echo "ERROR: dynamic mode failed" ; exit 1 ; \
	fi

shellcheck:
	shellcheck direnvsh

README.md:
	( cat README.md.tmpl ; ./direnvsh -h | sed -e 's/^/    /g' ) > README.md

