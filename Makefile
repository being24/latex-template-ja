IN_CONTAINER=$(shell if test -f /.dockerenv || test -f /run/.containerenv || grep -Eq '(docker|containerd|kubepods|libpod)' /proc/1/cgroup 2>/dev/null; then echo yes; else echo no; fi)
USE_DOCKER?=$(if $(filter yes,$(IN_CONTAINER)),no,yes)
DOCKER_IMAGE=ghcr.io/being24/latex-docker

# TeX sources
STY_SRCS=$(wildcard ./*.sty)
BIB_SRCS=$(wildcard ./*.bst) $(wildcard ./*.bib)
TEX_SRCS=$(wildcard ./*.tex) $(wildcard */*.tex)

# Figures
FIG_DIR=figures
FIG_PNG=$(wildcard $(FIG_DIR)/*.png)
FIG_JPG=$(wildcard $(FIG_DIR)/*.jpg) $(wildcard $(FIG_DIR)/*.JPG) $(wildcard $(FIG_DIR)/*.jpeg)
FIG_EPS=$(wildcard $(FIG_DIR)/*.eps)
FIG_PDF=$(wildcard $(FIG_DIR)/*.pdf)
FIGS=$(FIG_PNG) $(FIG_JPG) $(FIG_EPS) $(FIG_PDF)

ifeq "$(OS)" "Windows_NT"
	# Windows uses Docker Desktop.
	UIDOPT=
else
	UNAME=$(shell uname)
	ifeq "$(UNAME)" "Linux"
		# Exec docker with the UID and GID as same as the login user.
		UID=$(shell id -u)
		GID=$(shell id -g)
		UIDOPT=-u $(UID):$(GID)
	else
		# This section is for macOS. It uses Docker Desktop, too.
		UIDOPT=
	endif
endif

DOCKER_CMD=docker run --rm $(UIDOPT) -v $(CURDIR):/workdir -w /workdir $(DOCKER_IMAGE)

ifeq "$(USE_DOCKER)" "yes"
	LATEXMK_CMD=$(DOCKER_CMD) latexmk
	LATEXMKRC_CMD=$(DOCKER_CMD) cp /.latexmkrc ./
	NPM_CMD=$(DOCKER_CMD) npm
	CHECK_CMD=$(DOCKER_CMD) bash ./bin/check.sh
	WATCH_OPTION=-pvc -view=none
else
	LATEXMK_CMD=latexmk
	LATEXMKRC_CMD=cp /.latexmkrc ./
	NPM_CMD=npm
	CHECK_CMD=bash ./bin/check.sh
	WATCH_OPTION=-pvc
endif

.DEFAULT_GOAL := pdf

.PHONY: all
all: clean pdf

.PHONY: pdf
pdf:
ifndef FILE
	$(error FILE is not set. Usage: make pdf FILE=<file without .tex extension>, e.g. make pdf FILE=main)
endif
	$(LATEXMK_CMD) $(FILE).tex

.PHONY: watch
watch:
ifndef FILE
	$(error FILE is not set. Usage: make watch FILE=<file without .tex extension>, e.g. make watch FILE=main)
endif
	$(LATEXMK_CMD) $(WATCH_OPTION) $(FILE).tex

.PHONY: check
check:
ifndef FILE
	$(error FILE is not set. Usage: make check FILE=<file without .tex extension>, e.g. make check FILE=main)
endif
	$(CHECK_CMD) $(FILE)

.PHONY: clean
clean:
	$(LATEXMK_CMD) -C $(TEX_SRCS)
	rm -rf build-check

.latexmkrc:
	$(LATEXMKRC_CMD)

.PHONY: latexmkrc
latexmkrc: .latexmkrc

.PHONY: lint
lint:
	$(NPM_CMD) run lint -- main.tex sections

.PHONY: fix
fix:
	$(NPM_CMD) run fix -- main.tex sections

.PHONY: mcp
mcp:
	npm run mcp

branch=wip
.PHONY: draft
draft:
	git checkout -b $(branch)
	git commit -m "WIP" --allow-empty
	git push -u origin $(branch)
	hub compare
