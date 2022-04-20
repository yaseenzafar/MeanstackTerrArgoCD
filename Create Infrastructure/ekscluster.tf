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
        root_volume_type = "gp2"
    }
workers_group = [
        {
            name = "Worker-Group-1"
            instance_type = "t2.micro"
            asg_desired_capacity = 1
            additional_security_group_ids = [aws_security_group.public_security_group.id]
        },
        {
            name = "Worker-Group-2"
            instance_type = "t2.micro"
            asg_desired_capacity = 1
            additional_security_group_ids = [aws_security_group.public_security_group.id]
        },

        {
            name = "Worker-Group-2"
            instance_type = "t2.micro"
            asg_desired_capacity = 1
            additional_security_group_ids = [aws_security_group.public_security_group.id]
        },

    ]
}
data "aws_eks_cluster" "cluster" {
    name = module.eks.cluster_id
}
data "aws_eks_cluster_auth" "cluster" {
    name = module.eks.cluster_id
}

scaling_config {
    min_size     = 1
    max_size     = 3
  }