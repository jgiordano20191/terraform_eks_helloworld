provider "aws" {
    region = "us-east-1"
}

terraform {
    backend "s3" {
        bucket = "terraform-eks-staging55555"
        key    = "eks/terraform.tfstate"
        region = "us-east-1"
    }
}


data "aws_eks_cluster" {
    name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id
}

provider "kubernetes" {
    host                     = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate   = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                    = data.aws_eks_cluster_auth.cluster.token
    load_config_file         = false
    version                  = "~> 1.9"
}

module "eks" {
    source          =  "terraform-aws-modules/eks/aws"
    cluster_name    =  "one-eks"
    cluster_version =  "1.17"
    subnets         = ["subnet-0539d01b65a6e04d1", "subnet-0526b9ea57da07279"]
    vpc_id          = "vpc-00cb45b8d4cbc6d64"
}

node_groups = {
    public = {
        subnets             = ["subnet-0539d01b65a6e04d1"]
        desired_capacity    = 1
        max_capacity        = 10
        min_capacity        = 1

        instance_type       = "t2.small"
        k8s_labels          = {
            Environment = "public"
        }
    }
    private = {
        subnets             = ["subnet-0526b9ea57da07279"]
        desired_capacity    = 1
        max_capacity        = 10
        min_capacity        = 1

        instance_type       = "t2.small"
        k8s_labels          = {
            Environment     = "private"
        }
        
    }
}

