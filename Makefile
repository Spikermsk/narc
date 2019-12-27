.DEFAULT_GOAL := test

.PHONY: test
#test: clean lint unit dry
test: clean unit dry

.PHONY: lint
lint:
	@echo "Starting  lint"
	find . -name "*.yaml" | xargs yamllint -s
	find . -name "*.py" | xargs pylint
	find . -name "*.py" | xargs black -l 85 --check
	@echo "Completed lint"

.PHONY: unit
unit:
	@echo "Starting  unit tests"
	python -m pytest tests/ --verbose
	@echo "Completed unit tests"

.PHONY: dry
dry:
	@echo "Starting  dryruns"
	python runbook.py -d
	head -n 5 outputs/*
	python runbook.py --dryrun --failonly
	head -n 5 outputs/*
	@echo "Completed dryruns"

.PHONY: clean
clean:
	@echo "Starting  clean"
	find . -name "*.pyc" | xargs -r rm
	rm -f nornir.log
	@echo "Starting  clean"
