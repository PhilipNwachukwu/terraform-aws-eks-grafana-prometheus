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


# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "19.11.0"
# }
  
# data "aws_eks_cluster" "cluster" {
#   name = module.eks.cluster_id
# }

# data "aws_eks_cluster_auth" "cluster" {
#   name = module.eks.cluster_id
# }

provider "kubernetes" {
  experiments {
    manifest_resource = true
  }
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}
  
provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    token                  = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  }
}

#   required_providers {
#     aws        = ">= 3.13"
#     helm       = ">= 1.0"
#     kubernetes = ">= 1.10.0"
#   }
# }
