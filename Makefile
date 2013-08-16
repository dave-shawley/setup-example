# vim: set shiftwidth=8 tabstop=8 noexpandtab:
CURDIR	?= $(shell pwd)
ENVDIR	?= $(CURDIR)/env
PROJECT	?= $(notdir $(CURDIR))
MAKEFLAGS += --silent

AWK	?= awk
ECHO	?= echo
EGREP	?= grep -E
FIND	?= find
GREP	?= grep
PIP	:= $(ENVDIR)/bin/pip
PYTHON	:= $(ENVDIR)/bin/python
RM	?= rm -f
SED	?= sed
SETUP	:= $(PYTHON) ./setup.py
SORT	?= sort
TOUCH	?= touch


.PHONY: help environment requirements shell test

help:
	@$(ECHO) "============================================================"
	@$(ECHO) "Useful targets"
	@$(ECHO) "  environment - create virtual environment"
	@$(ECHO) "  requirements - create environment and install requirements"
	@$(ECHO) "  shell - create bootstrapped environment and launch a shell"
	@$(ECHO) "  test - create bootstrapped environment and run unit tests"
	@$(ECHO) "------------------------------------------------------------"
	@$(ECHO) "Housekeeping targets:"
	@$(ECHO) "  clean - remove intermediate files"
	@$(ECHO) "  mostly-clean - remove cached files"
	@$(ECHO) "  dist-clean - remove distributions"
	@$(ECHO) "  maintainer-clean - remove environment"
	@$(ECHO) "============================================================"

environment: $(ENVDIR)

$(ENVDIR):
	@$(ECHO) "Creating virtual environment in $(ENVDIR)."
	virtualenv --quiet --prompt="($(PROJECT))" $(ENVDIR)

requirements: $(ENVDIR)/requirements-installed

$(ENVDIR)/requirements-installed: $(ENVDIR) $(ENVDIR)/requirements.txt
	@$(ECHO) "Installing requirements using pip."
	@$(ECHO) "This may take a few minutes..."
	$(PIP) -q install -r "$(ENVDIR)/requirements.txt"
	@$(SETUP) --help-commands | \
	  $(GREP) '^  [a-z]' | $(EGREP) -v '^  (test|clean)\>' | \
	  $(AWK) '{ printf "%s:\n\t@$$(SETUP) %s\n\n", $$1, $$1 }' > "$@"
	$(TOUCH) "$@"

$(ENVDIR)/requirements.txt: requirements.txt test-requirements.txt tools.txt
	@$(SORT) -u $^ | $(GREP) -v '^-' | $(SED) -e 's/#.*$$//' -e '/^ *$$/d' > "$@"


shell: requirements
	ENV=$(ENVDIR)/bin/activate $(SHELL)

test: requirements
	@$(ECHO) "Running unit tests."
	$(SETUP) test


.PHONY: clean mostly-clean mostlyclean dist-clean distclean maintainer-clean

clean:
	@$(ECHO) "Removing intermediate files."
	- $(FIND) . -name '*.py[co]' -delete
	- $(RM) MANIFEST .coverage nosetests.xml
	- $(RM) $(ENVDIR)/requirements-installed

mostly-clean mostlyclean: clean
	@$(ECHO) "Removing cached files and reports."
	- $(FIND) . -name '__pycache__' -delete
	- $(RM) -r htmlcov .cache build *.egg *.egg-info .tox/dist .tox/log

dist-clean distclean: mostly-clean
	@$(ECHO) "Removing built distributions."
	- $(RM) -r dist

maintainer-clean: dist-clean
	@$(ECHO) "Removing environments."
	- $(RM) -r env* .tox


.PHONY: $(ENVDIR)/makefile.inc

-include $(ENVDIR)/makefile.inc

