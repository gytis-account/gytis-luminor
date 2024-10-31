account_id           = "054037101494"
region               = "eu-north-1"
cluster_name         = "terraform-eks"
eks_version          = "1.30"
node_group_name      = "atlantis-nodes"
vpc_name             = "Atlantis-VPC"
vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["eu-north-1a", "eu-north-1b"]
public_subnets       = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets      = ["10.0.3.0/24", "10.0.4.0/24"]
worker_min_size      = 1
worker_max_size      = 2
worker_desired_size  = 1
volume_size          = 20
eks_node_role_name   = "eks-nodes-role"

# Additional variables
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"] 