##################################################
##################################################
default: build

####################
.PHONY: default all check configure build clean dictation-server natlink docs update rebuild 

##################################################
##################################################
# configure:
# 	cabal --enable-nix new-configure --project-file ./cabal.project
#
####################
check:
	cabal new-build -fno-code -O0 all

####################
compile:
	cabal new-build all

####################
repl:
#TODO	cabal new-repl all
	cabal new-repl natlink # dictation-server

# ####################
# install:
# 	cabal new-build all

####################
execute:
	cabal new-run dictation-server-example

####################
clean:
	rm -rf dist/ dist-newstyle/ .sboo/
	rm -f *.project.local .ghc.environment.*

##################################################
##################################################

####################
all:
	cabal new-build all
	cabal new-test  all

####################
dictation-server:
	cabal new-build dictation-server
	cabal new-test  dictation-server
	cabal new-run   dictation-server-example

####################
natlink:
	cabal new-build natlink
	cabal new-test  natlink

##################################################
##################################################

####################
rebuild: clean update configure build docs

####################
build: check compile

####################
tags: compile
	mkdir -p .sboo/
	fast-tags -o ".sboo/tags" -R .
	cat ".sboo/tags"

########################
build-docs: compile
	cabal new-haddock all

########################
copy-docs: build-docs
	rm -fr ".sboo/documentation/"
	mkdir -p ".sboo/documentation/"
	cp -aRv  ./dist-newstyle/build/*-*/ghc-*/natlink-*/noopt/doc/html/natlink/* ".sboo/documentation/natlink"
	cp -aRv  ./dist-newstyle/build/*-*/ghc-*/dictation-server-*/noopt/doc/html/dictation-server/* ".sboo/documentation/dictation-server"

########################
open-docs: copy-docs
#TODO	xdg-open ".sboo/documentation/index.html"
	xdg-open ".sboo/documentation/natlink/index.html"
	xdg-open ".sboo/documentation/dictation-server/index.html"

#       ^ TODO: cross-platform, use 'open' and alias it to 'xdg-open'; wildcard the platform-directory (and also the various versions), i.e.:
#
#           open ./dist-newstyle/build/*-*/ghc-*/*-*/noopt/doc/html/*/index.html
#       rather than, e.g.:
#
#           xdg-open ./dist-newstyle/build/x86_64-linux/ghc-8.4.3/dictation-server-0.0/noopt/doc/html/dictation-server/index.html
#

# ekmett:
# 	cp -aRv dist-newstyle/build/*/*/unpacked-containers-0/doc/html/unpacked-containers/* docs
# 	cd docs && git commit -a -m "update haddocks" && git push && cd ..

########################
docs: open-docs

####################
update:
	cabal new-update

####################
watch:
	@exec ./scripts/sboo/ghcid.sh & disown

##################################################
##################################################