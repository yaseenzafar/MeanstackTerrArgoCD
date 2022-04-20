module vpc {
    source = "git::https://git@github.com/reactiveops/terraform-vpc.git?ref=v5.0.1"
    name = "Demo-VPC"
    cidr = "10.0.0.0/16"
    aws_region = "us-east-1"
    az_count   = 3
    aws_azs         = ["us-east-1a", "us-east-1b", "us-east-1c"]
    private_subnets = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
    public_subnets  = ["10.0.101.0/24","10.0.102.0/24","10.0.103.0/24"]
    enable_nat_gateway = true
    enable_dns_hostname = true
tags = {
    "Name" = "Demo-VPC"
}
public_subnet_tags = {
    "Name" = "Demo-Public-Subnet"
}
private_subnet_tags = {
    "Name" = "Demo-Private-Subnet"
}
}