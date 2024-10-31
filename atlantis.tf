provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    exec {
      api_version = "client.authentication.k8s.io/v1beta1"
      command     = "aws"
      args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.cluster.name]
    }
  }
}

resource "helm_release" "atlantis" {
  name       = "atlantis"
  repository = "https://runatlantis.github.io/helm-charts"
  chart      = "atlantis"
  version    = "5.7.0"

  set {
    name  = "github.user"
    value = var.github_user
  }

  set {
    name  = "github.token"
    value = var.github_token
  }

  set {
    name  = "github.secret"
    value = var.github_webhook_secret
  }

  set {
    name  = "orgAllowlist"
    value = "github.com/gytis-account/gytis-devops"
  }

  set {
    name  = "ingress.ingressClassName"
    value = "nginx"
  }

  set {
    name  = "ingress.host"
    value = data.external.ingress_ip.result.ingress_ip
  }

  set {
    name  = "ingress.path"
    value = "/*"
  }

  set {
    name  = "ingress.pathType"
    value = "ImplementationSpecific"
  }

  set {
    name  = "volumeClaim.enabled"
    value = "true"
  }

  set {
    name  = "volumeClaim.dataStorage"
    value = "10Gi"
  }

  set {
    name  = "volumeClaim.storageClassName"
    value = "gp2"
  }

  set {
    name  = "volumeClaim.accessModes[0]"
    value = "ReadWriteOnce"
  }

  set {
    name  = "replicaCount"
    value = "1"
  }

  set {
    name  = "tolerations[0].key"
    value = "node.cloudprovider.kubernetes.io/uninitialized"
  }

  set {
    name  = "tolerations[0].operator"
    value = "Exists"
  }

  set {
    name  = "tolerations[0].effect"
    value = "NoSchedule"
  }

  set {
    name  = "statefulSet.securityContext.fsGroup"
    value = "1000"
  }

  set {
    name  = "statefulSet.securityContext.runAsUser"
    value = "1000"
  }

  set {
    name  = "statefulSet.securityContext.runAsGroup"
    value = "1000"
  }

  set {
    name  = "initContainers[0].name"
    value = "init-permissions"
  }

  set {
    name  = "initContainers[0].image"
    value = "busybox"
  }

  set {
    name  = "initContainers[0].command[0]"
    value = "sh"
  }

  set {
    name  = "initContainers[0].command[1]"
    value = "-c"
  }

  set {
    name  = "initContainers[0].command[2]"
    value = "chown -R 1000:1000 /atlantis-data && chmod -R 777 /atlantis-data"
  }

  set {
    name  = "initContainers[0].securityContext.runAsUser"
    value = "0"
  }

  set {
    name  = "initContainers[0].securityContext.runAsGroup"
    value = "0"
  }

  set {
    name  = "initContainers[0].volumeMounts[0].mountPath"
    value = "/atlantis-data"
  }

  set {
    name  = "initContainers[0].volumeMounts[0].name"
    value = "atlantis-data"
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_nodes_amazon_ebs_csi_driver_policy
  ]
}

resource "aws_security_group" "atlantis_sg" {
  name        = "atlantis-sg"
  description = "Security group for Atlantis"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}