resource "aws_security_group" "public_security_group" {
    name = "public_security_rules"
    vpc_id = module.vpc.vpc_id

ingress {
        from_port = 0
        to_port = 65535
        protocol = "all"
        
ingress {
        from_port = 80
        to_port = 80
        protocol = "http"
     
ingress {
        from_port = 443
        to_port = 443
        protocol = "https"
        cidr_blocks = ["10.0.101.0/8","10.0.102.0/8","10.0.103.0/8"]
}
}
}
        
ingress {
        from_port = 22
        to_port = 22
        protocol = "ssh"
        cidr_blocks = ["10.0.101.4/24",10.0.101.5/24"]
  }

egress {
       from_port = 0
       to_port = 65535
       protocol = "-1"
       cidr_blocks = ["0.0.0.0/0"]
  } 
