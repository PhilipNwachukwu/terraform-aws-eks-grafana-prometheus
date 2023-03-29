terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    
    helm = {
      source = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}

provider "kubernetes" {}


#   required_providers {
#     aws        = ">= 3.13"
#     helm       = ">= 1.0"
#     kubernetes = ">= 1.10.0"
#   }
# }
