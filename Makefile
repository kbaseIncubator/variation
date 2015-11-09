SERVICE = variation
SERVICE_CAPS = variation
SPEC_FILE = variation.spec
URL = https://kbase.us/services/variation
DIR = $(shell pwd)
LIB_DIR = lib
SCRIPTS_DIR = scripts
LBIN_DIR = bin
EXECUTABLE_SCRIPT_NAME = run_$(SERVICE_CAPS)_async_job.sh
STARTUP_SCRIPT_NAME = start_server.sh

default: compile-kb-module build-startup-script build-executable-script

compile-kb-module:
	kb-sdk compile $(SPEC_FILE) \
		--out $(LIB_DIR) \
		--plclname $(SERVICE_CAPS)::$(SERVICE_CAPS)Client \
		--jsclname javascript/Client \
		--pyclname $(SERVICE_CAPS).$(SERVICE_CAPS)Client \
		--javasrc java \
		--java \
		--pysrvname $(SERVICE_CAPS).$(SERVICE_CAPS)Server \
		--pyimplname $(SERVICE_CAPS).$(SERVICE_CAPS)Impl;
	chmod +x $(SCRIPTS_DIR)/entrypoint.sh

build-executable-script:
	mkdir -p $(LBIN_DIR)
	echo '#!/bin/bash' > $(LBIN_DIR)/$(EXECUTABLE_SCRIPT_NAME)
	echo 'export PYTHONPATH=$(DIR)/$(LIB_DIR):$$PATH:$$PYTHONPATH' >> $(LBIN_DIR)/$(EXECUTABLE_SCRIPT_NAME)
	echo 'python $(DIR)/$(LIB_DIR)/$(SERVICE_CAPS)/$(SERVICE_CAPS)Server.py $$1 $$2 $$3' >> $(LBIN_DIR)/$(EXECUTABLE_SCRIPT_NAME)
	chmod +x $(LBIN_DIR)/$(EXECUTABLE_SCRIPT_NAME)

build-startup-script:
	mkdir -p $(LBIN_DIR)
	echo '#!/bin/bash' > $(SCRIPTS_DIR)/$(STARTUP_SCRIPT_NAME)
	echo 'export KB_DEPLOYMENT_CONFIG=$(DIR)/deploy.cfg' >> $(SCRIPTS_DIR)/$(STARTUP_SCRIPT_NAME)
	echo 'export PYTHONPATH=$(DIR)/$(LIB_DIR):$$PATH:$$PYTHONPATH' >> $(SCRIPTS_DIR)/$(STARTUP_SCRIPT_NAME)
	echo 'uwsgi --master --processes 5 --threads 5 --http :5000 --wsgi-file $(DIR)/$(LIB_DIR)/$(SERVICE_CAPS)/$(SERVICE_CAPS)Server.py' >> $(SCRIPTS_DIR)/$(STARTUP_SCRIPT_NAME)
	chmod +x $(SCRIPTS_DIR)/$(STARTUP_SCRIPT_NAME)

clean:
	rm -rfv $(LBIN_DIR)
