.PHONY: test clean doc cov kill release

test:
	xctool test

cov:
	xctool test GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES GCC_GENERATE_TEST_COVERAGE_FILES=YES

clean:
	xctool clean

kill:
	osascript -e 'tell app "iPhone Simulator" to quit'

covr:
	touch .gcov ; rm -rf .gcov ; mkdir .gcov
	cp `$(MAKE) echo-obj-dir`/* .gcov/
	gcovr -r .

coveralls:
	touch .gcov ; rm -rf .gcov ; mkdir .gcov
	cp `$(MAKE) echo-obj-dir`/* .gcov/
	coveralls -e Pods -e StrawTests -x '.m' -E '.*\.h'
	rm -rf .gcov

echo-obj-dir:
	@echo ` xctool -showBuildSettings | awk '/OBJECT_FILE_DIR_normal =/{x=$$3}/NATIVE_ARCH =/{y=$$3}END{print x"/"y}' `

doc:
	appledoc --project-name 'Straw' --project-company 'kt3k.org' --company-id 'org.kt3k' --output doc-dev --create-html --no-create-docset Straw

doc-release:
	appledoc --project-name 'Straw' --project-company 'kt3k.org' --company-id 'org.kt3k' --output doc/v0.5.3 --create-html --no-create-docset Straw

release:
	pod spec lint Straw.podspec
	pod trunk push Straw.podspec
