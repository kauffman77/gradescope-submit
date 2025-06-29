
PYPA_DIR = pypa-package			# directory used for python packaging

build:  $(PYPA_DIR)/README.md		# build the python source/wheel packages
	python -m build $(PYPA_DIR)

$(PYPA_DIR)/README.md: README.org	# update markdown based on org
	emacs README.org --batch \
		-f org-md-export-to-markdown \
		--kill
	mv README.md $@

venv:					# start a virtual env shell with the package installed
	python -m venv .venv
	source .venv/bin/activate && \
	  pip install --editable $(PYPA_DIR) && \
	  bash

clean:                                  # clean up build artifacts
	rm -rf $(PYPA_DIR)/dist $(PYPA_DIR)/gradescope_submit.egg-info
