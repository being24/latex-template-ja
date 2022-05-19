MAIN_SRC=main
USE_DOCKER?=yes
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

DOCKER_CMD=docker run --rm $(UIDOPT) -v $(CURDIR):/workdir $(DOCKER_IMAGE)

ifeq "$(USE_DOCKER)" "yes"
	LATEXMK_CMD=$(DOCKER_CMD) latexmk
	WATCH_OPTION=-pvc -view=none
else
	LATEXMK_CMD=latexmk
	WATCH_OPTION=-pvc
endif

.DEFAULT_GOAL := pdf

.PHONY: all
all: clean pdf

.PHONY: pdf
pdf: $(MAIN_SRC).pdf

$(MAIN_SRC).pdf: $(TEX_SRCS) $(STY_SRCS) $(BIB_SRCS) $(FIGS)
	$(LATEXMK_CMD)

target=$(MAIN_SRC).tex
.PHONY: watch
watch:
	$(LATEXMK_CMD) $(WATCH_OPTION) $(target)

.PHONY: clean
clean:
	$(LATEXMK_CMD) -C $(TEX_SRCS)

.latexmkrc:
	$(DOCKER_CMD) cp /.latexmkrc ./

.PHONY: latexmkrc
latexmkrc: .latexmkrc

.PHONY: lint
lint:
	npm run lint

.PHONY: fix
fix:
	npm run fix

branch=wip
.PHONY: draft
draft:
	git checkout -b $(branch)
	git commit -m "WIP" --allow-empty
	git push -u origin $(branch)
	hub compare