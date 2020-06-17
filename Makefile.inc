DEFAULT_GOAL=	test

ROOT_DIR_REL?=	..
BUILD_FILE?=	${ROOT_DIR_REL}/p6common/scripts/build.sh
TEST_FILE?=	${ROOT_DIR_REL}/p6common/scripts/test.sh
LINT_FILE?=	${ROOT_DIR_REL}/p6common/scripts/lint.sh
DOC_FILE?=	${ROOT_DIR_REL}/p6common/scripts/doc.sh
RELEASE_FILE?=	${ROOT_DIR_REL}/p6common/scripts/release.sh
DEPLOY_FILE?=	${ROOT_DIR_REL}/p6common/scripts/deploy.sh

all:	test

build:
	ROOT_DIR_REL=${ROOT_DIR_REL} ${BUILD_FILE}

lint:
	ROOT_DIR_REL=${ROOT_DIR_REL} ${LINT_FILE}

doc:	lint
	ROOT_DIR_REL=${ROOT_DIR_REL} ${DOC_FILE}

test:	doc
	ROOT_DIR_REL=${ROOT_DIR_REL} ${TEST_FILE}

release: test
	ROOT_DIR_REL=${ROOT_DIR_REL} ${RELEASE_FILE}

deploy:
	ROOT_DIR_REL=${ROOT_DIR_REL} ${DEPLOY_FILE}

## For use by Maintainers
x-rmrf-node_modules:
	-rm -rf node_modules 
	-rm -rf packages/*/node_modules 
	-rm -rf packages/@p6-*/*/node_modules

.PHONY:	all build lint doc test release deploy