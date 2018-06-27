# Makefile for building CORD docs site, guide.opencord.org
# Building docs requires the following tools:
#  - Gitbook toolchain: https://toolchain.gitbook.com/setup.html
#  - NPM (for Gitbook and Swagger)
#  - Python (for build glossary script)
#  - linkchecker (for test target) http://wummel.github.io/linkchecker/

default: build

# use bash for pushd/popd, and to fail if commands within  a pipe fail
SHELL = bash -o pipefail

GENERATED_DOCS =

LINT_STYLE ?= mdl_relaxed.rb


build:
	gitbook init
	gitbook install
	gitbook build
	gitbook serve

test: linkcheck lint

linkcheck: build
	linkchecker -a _book/

lint:
	@echo "markdownlint(mdl) version: `mdl --version`"
	@echo "style config:"
	@echo "---"
	@cat $(LINT_STYLE)
	@echo "---"

clean:
	rm -rf _book
	rm -rf node_modules

