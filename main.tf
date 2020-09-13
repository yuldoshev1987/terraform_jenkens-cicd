resource "aws_launch_configuration" "autoscale_launch" {
  image_id = data.aws_ami.linux_ami.id
  instance_type = var.instance_vm_type
  security_groups = [aws_security_group.web-server-sg.id]
  key_name = var.ssh_key_name
  user_data       = file("userdata.sh")
  lifecycle {
    create_before_destroy = true
  }
}
locals {
  public_subnets = split(",", var.subnet_ids)
}

resource "aws_autoscaling_group" "autoscale_group" {
  launch_configuration = aws_launch_configuration.autoscale_launch.id
  vpc_zone_identifier = local.public_subnets
  target_group_arns = [aws_lb_target_group.alb_target_group.arn]
  min_size = 1
  max_size = 2
  tag {
    key = "Name"
    value = "autoscale"
    propagate_at_launch = true
  }
}
resource "aws_security_group" "web-server-sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id = data.aws_vpc.develoment_vpc.id
  ingress {
    description = "TLS from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_lb" "alb" {
  name            = "alb"
  load_balancer_type = "application"
  subnets         = local.public_subnets
  security_groups = [aws_security_group.web-server-sg.id]
  internal        = false


  idle_timeout    = 60
  tags = {
    Name    = "alb"
  }

}

resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.develoment_vpc.id
  tags = {
    name = "alb_target_group"
  }
  stickiness {
    type            = "lb_cookie"
    cookie_duration = 1800
    enabled         = true
  }
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 5
    interval            = 10
    path                = "/"
    port                = 80
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.alb_target_group.arn
    type             = "forward"
  }
}

resource "aws_autoscaling_attachment" "alb_autoscale" {
  alb_target_group_arn   = aws_lb_target_group.alb_target_group.arn
  autoscaling_group_name = aws_autoscaling_group.autoscale_group.id
}