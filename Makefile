##################################################
# Makefile Variables
##################################################

BaseDirectory=$(CURDIR)

#------------------------------------------------#

ProjectName=dictation
PackageName=dictation-server

##################################################
# the `default` target
##################################################

default: build
.PHONY: default

##################################################
# `cabal` wrapper targets
##################################################

#------------------------------------------------#
build: check compile

.PHONY: build

#------------------------------------------------#
check:
	cabal new-build -fno-code -O0 all

.PHONY: check

#------------------------------------------------#
compile:
	cabal new-build all

.PHONY: compile

#------------------------------------------------#
repl:
#TODO	cabal new-repl all
	cabal new-repl $(PackageName)

.PHONY: repl

#------------------------------------------------#
execute:
	cabal new-run $(PackageName)-example

.PHONY: execute

#------------------------------------------------#
update:
	cabal new-update

.PHONY: update

##################################################
# component targets (i.e. for `cabal new-build`)
##################################################

#------------------------------------------------#
all:
	cabal new-build all
	cabal new-test  all

.PHONY: all

#------------------------------------------------#

configure: install-dependencies cabal-configure

.PHONY: configure

#------------------------------------------------#

install: install-dependencies #TODO is "install" the right name.

.PHONY: install

#------------------------------------------------#

install-dependencies:
	nix-env -f ./nix/shell.nix -i

#TODO? ./nix/environment/shell.nix

.PHONY: install-dependencies

#------------------------------------------------#

cabal-configure:
	cabal --enable-nix new-configure --project-file ./cabal.project

.PHONY: cabal-configure

#------------------------------------------------#
package:
	cabal new-build $(PackageName)
	cabal new-test  $(PackageName)
	cabal new-run   $(PackageName)-example

.PHONY: package

#------------------------------------------------#
dictation-server: package

.PHONY: dictation-server

##################################################
# my own build scripts (make things, move them)
##################################################

#------------------------------------------------#
clean:
	rm -rf dist/ dist-newstyle/ .sboo/
	rm -f *.project.local .ghc.environment.*

.PHONY: clean

#------------------------------------------------#
rebuild: clean update configure build docs

.PHONY: rebuild

#------------------------------------------------#
tags: compile
	mkdir -p .sboo/
	fast-tags -o ".sboo/tags" -R .
	cat ".sboo/tags"

.PHONY: tags

#------------------------------------------------#
build-docs: compile
	cabal new-haddock all

.PHONY: build-docs

#------------------------------------------------#
copy-docs: build-docs
	rm -fr ".sboo/documentation/"
	mkdir -p ".sboo/documentation/"
	cp -aRv ./dist-newstyle/build/*-*/ghc-*/$(PackageName)-*/noopt/doc/html/$(PackageName) ".sboo/documentation/$(PackageName)"

.PHONY: copy-docs

#------------------------------------------------#
open-docs: copy-docs
#TODO	xdg-open ".sboo/documentation/index.html"
	xdg-open ".sboo/documentation/$(PackageName)/index.html"

.PHONY: open-docs

#       ^ TODO: cross-platform, use 'open' and alias it to 'xdg-open'; wildcard the platform-directory (and also the various versions), i.e.:
#
#           open ./dist-newstyle/build/*-*/ghc-*/*-*/noopt/doc/html/*/index.html
#       rather than, e.g.:
#
#           xdg-open ./dist-newstyle/build/x86_64-linux/ghc-8.4.3/$(PackageName)-0.0/noopt/doc/html/$(PackageName)/index.html
#

# ekmett:
# 	cp -aRv dist-newstyle/build/*/*/unpacked-containers-0/doc/html/unpacked-containers/* docs
# 	cd docs && git commit -a -m "update haddocks" && git push && cd ..

#------------------------------------------------#
docs: open-docs

.PHONY: docs

#------------------------------------------------#
watch:
	@exec ./scripts/sboo/ghcid.sh & disown

.PHONY: watch

##################################################