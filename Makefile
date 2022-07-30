.PHONY: install build dev test clean

.FORCE: ;

# This is to disable check for new release in aw-webui for aw-android
ifdef ON_ANDROID
# The following flag will pass --android as a command line argument to vue-cli-service
# https://docs.npmjs.com/cli/run-script
androidflag := -- --os=android
else
androidflag :=
endif

build: install
	pnpm run build ${androidflag}

install:
	pnpm i

uninstall:
	rm -r node_modules/

dev:
	pnpm run serve ${androidflag}

test:
	pnpm test

test-e2e:
	pnpx testcafe firefox test/e2e/ -s takeOnFails=true

clean:
	rm -rf node_modules dist

lint:
	pnpx eslint --ext=js,ts,vue --max-warnings=0 src/ test/

lint-fix:
	pnpx eslint --ext=js,ts,vue --fix src/ test/
