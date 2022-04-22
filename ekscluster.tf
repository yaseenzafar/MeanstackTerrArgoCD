module "eks"{
    source = "terraform-aws-modules/eks/aws"
    version = "17.1.0"
    cluster_name = local.cluster_name
    cluster_version = "1.20"
    subnets = module.vpc.private_subnets
tags = {
        Name = "EKS-Cluster-test"
    }
vpc_id = module.vpc.vpc_id

workers_group_defaults = {
    instance_type        = "t2.micro"   
    subnets              = module.vpc.private_subnets
    asg_desired_capacity = 1
    asg_min_size         = 1
    asg_max_size         = 3
  }
data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id
}

