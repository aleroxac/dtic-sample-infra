conf ?= .env
include $(conf)
export $(shell sed 's/=.*//' $(conf))



## ---------- VARIABLES
TF_DOCKER ?= false
TF_VERSION ?= 1.12.2



## ---------- CHECKS
ifeq ($(TF_DOCKER),true)
	TERRAFORM=docker run -v $(PWD)/terraform:/iac -w /iac \
		-e AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		-e AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		hashicorp/terraform:$(TF_VERSION)
else
	TERRAFORM=terraform
endif



## ---------- UTILS
.DEFAULT_GOAL := help
.PHONY: help ## She this help menu
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: clean
clean: ## Delete .terraform and .terraform.lock.hcl 
	@rm -rfv terraform/.terraform
	@rm -rfv terraform/.terraform.lock.hcl



## ---------- INSTALLATION_COMMANDS
.PHONY: utils-install
utils-install: ## Install useful packages
	@which wget || ${PKGMAN} install unzip
	@which curl || ${PKGMAN} install curl
	@which unzip || ${PKGMAN} install unzip

.PHONY: terraform-install
terraform-install: ## Install terraform
	ifeq ($(TF_DOCKER),false)
		@which terraform || (wget -P /tmp "https://releases.hashicorp.com/terraform/$${TF_VERSION}/terraform_$${TF_VERSION}_${OS_TYPE}_${OS_ARCH}.zip" && unzip /tmp/terraform*.zip && sudo mv /tmp/terraform /usr/local/bin ;)
	endif

.PHONY: docker-install
docker-install: ## Install docker
	@which docker || curl -fsSL https://get.docker.com | sh
	@getent group docker | grep $${USERNAME} || sudo usermod -aG docker $${USERNAME}

.PHONY: python-install
python-install: ## Install python3 and pip3
	@which pip3 || ${PKGMAN} python3 python3-pip

.PHONY: awscli-install
awscli-install: ## Install awscli
	@which aws || sudo pip install awscli

.PHONY: dot-install
dot-install: ## Install graphviz, to be used on "terraform graph" command
	@which /bin/dot || ${PKGMAN} graphviz

.PHONY: install
install: utils-install python-install awscli-install terraform-install dot-install ## Install all dependencies to run terraform locally
	@echo "--- utils"; which wget curl unzip
	@echo "--- terraform"; terraform version
	@echo "--- docker"; docker --version
	@echo "--- python"; python --version
	@echo "--- awscli"; aws --version
	@echo "--- dot"; /bin/dot -V



## ---------- TERRAFORM_COMMANDS
.PHONY: init
init: ## Download all necessary terraform plugins
	@$(TERRAFORM) init

.PHONY: ws-create
ws-create: ## Create a terraform workspace
	@$(TERRAFORM) workspace new ${ENV}

.PHONY: ws-select
ws-select: ## Select a terraform workspace
	@$(TERRAFORM) workspace select ${ENV}

.PHONY: fmt
fmt: ## Show correction on terraform scripts syntax  
	@$(TERRAFORM) fmt --recursive

.PHONY: validate
validate: ## Check if all scripts is ok
	@$(TERRAFORM) validate -json **/*.tf

.PHONY: plan
plan: fmt validate ## Show what terraform will create
	@$(TERRAFORM) plan -out "plan.out"

.PHONY: apply
apply: ## Create all resources described on terraform scripts
	@$(TERRAFORM) apply "plan.out"

.PHONY: graph
graph: ## Show a graph of all resources
	ifeq ($(TF_DOCKER),false)
		@$(TERRAFORM) graph | /usr/bin/dot -Tsvg > svg/graph.svg
		@google-chrome-stable svg/graph.svg
	else
		@echo "This command cannot be used via docker. Please run it locally."
		@echo "[CMD_TO_COPY_AND_PASTE]: terraform graph | /usr/bin/dot -Tsvg > svg/graph.svg"
	endif

.PHONY: list
list: ## Show a list of all resources
	@$(TERRAFORM) state list

.PHONY: show
show: list ## Show all create resources
	@$(TERRAFORM) output
	@$(TERRAFORM) show

.PHONY: plan-destroy
plan-destroy: ## Show what terraform will destroy
	@$(TERRAFORM) plan -destroy -out "plan-destroy.out"

.PHONY: destroy
destroy: plan-destroy ## Destroy all resources
	@$(TERRAFORM) destroy "plan-destroy.out"
