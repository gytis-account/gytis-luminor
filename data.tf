data "aws_caller_identity" "current" {}

data "aws_availability_zones" "available" {}

data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
  depends_on = [ module.eks ]
}

data "aws_eks_cluster_auth" "cluster" {
  name = var.cluster_name
}

data "external" "ingress_ip" {
  program = ["bash", "${path.module}/fetch_ingress_host.sh"]
}

## Test Comment
