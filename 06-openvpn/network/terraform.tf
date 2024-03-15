terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "cwchoiit-terraform"

    workspaces {
      name = "cwchoiit-terraform-cloud-backend"
    }
  }
}


###################################################
# Local Variables
###################################################

locals {
  context = yamldecode(file(var.config_file)).context
  config  = yamldecode(templatefile(var.config_file, local.context))
}


###################################################
# Providers
###################################################

provider "aws" {
  region = "ap-northeast-2"
}