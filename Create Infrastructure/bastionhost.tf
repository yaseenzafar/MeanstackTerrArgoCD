#launch configuration

resource "aws_launch_configuration" "bastiontest" {
  name_prefix     = "bastion-test-config"
  image_id        = ami-0130c3a072f3832ff
  instance_type   = "t2.micro"
  user_data       = file("user-data.sh")
  security_groups = [aws_security_group.public_security_group.id]

  lifecycle {
    create_before_destroy = true
  }
}

#Autoscaling Group
resource "aws_autoscaling_group" "bastionscaling" {
  min_size             = 1
  max_size             = 3
  desired_capacity     = 3
  launch_configuration = aws_launch_configuration.bastiontest.name
  vpc_zone_identifier  = module.vpc.public_subnets
}

#loadbalancer
resource "aws_lb" "bastionlb" {
  name               = "bastionlb-config"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.public_security_group.id]
  subnets            = module.vpc.public_subnets
}

#Autoscaling target group
 resource "aws_lb_target_group" "bastionTG" {
   name     = "bastionTG-test"
   port     = [80, 443]
   protocol = ["HTTP", "HTTPS"]
   vpc_id   = module.vpc.vpc_id
 }

resource "aws_autoscaling_attachment" "terramino" {
  autoscaling_group_name = aws_autoscaling_group.terramino.id
  alb_target_group_arn   = aws_lb_target_group.terramino.arn
}

#Autoscaling loadbalancer listener
resource "aws_lb_listener" "bastionlistener" {
  load_balancer_arn = aws_lb.bastionlb.arn
  port              = ["80","443"]
  protocol          = ["HTTP","HTTPS"]

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.bastionTG.arn
  }
}