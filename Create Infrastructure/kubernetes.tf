provider "kubernetes" {
    host = data.aws_eks_cluster.cluster.endpoint
    token = data.aws_eks_cluster_auth.cluster.token
    cluster_ca_certificate = base64encode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
}

#output
output "cluster_id" {
    value = module.eks.cluster_id
}
output "cluster_endpoint" {
    value = module.eks.cluster_endpoint
}