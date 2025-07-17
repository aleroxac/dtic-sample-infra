## ---------- PROVIDERS
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.2.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "~> 3.0.2"
    }
  }

  backend "s3" {
    bucket  = "dtic-aleroxac"
    key     = "dev/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

provider "helm" {
  kubernetes = {
    config_path = "~/.kube/config"
  }
}

provider "aws" {
  region = "us-east-1"
}



## ---------- VARIABLES
variable "environment" {
  description = "Deployment environment (dev, stg, prd, etc)"
  type        = string
}



## ---------- DATA_SOURCES
data "aws_organizations_organization" "org_info" {}



## ---------- LOCALS
locals {
  org_name = data.aws_organizations_organization.org_info.master_account_name
  team     = "platform"
  product  = "interview"
  service  = "lab"

  tags = {
    Provider  = "AWS"
    Terraform = true

    Organization = local.org_name
    Team         = local.team
    Product      = local.product
    Service      = local.service
    Environment  = var.environment
  }
}
