SHELL := /bin/bash

CUR_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
ROOT_DIR := $(CUR_DIR)

$(ROOT_DIR)/venv/bin/ansible-playbook:
	python3 -m venv $(ROOT_DIR)/venv
	$(ROOT_DIR)/venv/bin/python -m pip install ansible==7.1.0

ansible: $(ROOT_DIR)/venv/bin/ansible-playbook

build: ansible
	packer init ubuntu.pkr.hcl
	source $(ROOT_DIR)/venv/bin/activate && packer build -var-file ubuntu-18.04.pkrvars.hcl ubuntu.pkr.hcl
