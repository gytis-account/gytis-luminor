variable "account_id" {
  description = "The AWS account ID"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "vpc_name" {
  description = "The name of the project"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "The availability zones for the VPC"
  type        = list(string)
}

variable "public_subnets" {
  description = "The public subnets for the VPC"
  type        = list(string)
}

variable "private_subnets" {
  description = "The private subnets for the VPC"
  type        = list(string)
}


variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "eks_version" {
  description = "The Kubernetes version for the EKS cluster"
  type        = string
}

variable "worker_min_size" {
  description = "The minimum number of workers in the autoscaling group"
  type        = number
}

variable "worker_max_size" {
  description = "The maximum number of workers in the autoscaling group"
  type        = number
}

variable "worker_desired_size" {
  description = "The desired number of workers in the autoscaling group"
  type        = number
}

variable "eks-worker-ami" {
  description = "Ami to use for deployment"
  default     = "ami-0fb0f7412811d3538"
}

variable "volume_size" {
  description = "Enter size of the volume"
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "The CIDRs for public access to the EKS cluster endpoint"
  type        = list(string)
}

variable "github_token" {
  description = "GitHub token for Atlantis"
  type        = string
}

variable "github_webhook_secret" {
  description = "GitHub webhook secret for Atlantis"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository for Atlantis"
  type        = string
}

variable "node_group_name" {
  description = "The name of the EKS node group"
  type = string
}

variable "github_user" {
  description = "Enter your GitHub email"
  type = string
}

variable "eks_node_role_name" {
  description = "The name of the EKS node role"
  type        = string
}