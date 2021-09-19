terraform {
  required_version = ">= 1"

  required_providers {

    template = {
      source  = "hashicorp/template"
      version = ">= 2.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.0"
    }
  }
}
