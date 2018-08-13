##################################################
##################################################
all: build

####################
.PHONY:	all check configure build clean docs update rebuild

##################################################
##################################################
configure:
	cabal --enable-nix new-configure --project-file ./cabal.project

####################
check:
	cabal new-build -fno-code -O0 all

####################
compile:
	cabal new-build all

####################
repl:
	cabal new-repl dictation-server

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
	cp -aRv  ./dist-newstyle/build/*-*/ghc-*/dictation-server-*/noopt/doc/html/dictation-server/* ".sboo/documentation/"

########################
open-docs: copy-docs
	xdg-open ".sboo/documentation/index.html"

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