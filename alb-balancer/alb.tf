resource "aws_lb_target_group" "target-group" {
    health_check {
        interval            = 10
        path                = "/"
        protocol             = "HTTP"
        timeout             = 5
        healthy_threshold   = 5
        unhealthy_threshold = 2
    }
    port        = 80
    protocol    = "HTTP"
    vpc_id      = data.aws_vpc.default.id
    name        = "alb-demo-tg"
    target_type = "instance"
}

resource "aws_lb" "alb-demo-terraform" {
    name               = "alb-demo"
    internal = false
    ip_address_type = "ipv4"
    load_balancer_type = "application"
    security_groups = [ aws_security_group.alb-demo-sg.id ]
    subnets = data.aws_subnet_ids.default.ids
    tags = {
        Name =  "alb-demo"
    }
}


resource "aws_lb_listener" "alb-listner" {
    load_balancer_arn = aws_lb.alb-demo-terraform.arn
    port              = 80
    protocol          = "HTTP"
    default_action {
        target_group_arn = aws_lb_target_group.target-group.arn
        type             = "forward"
    }
}

resource "aws_lb_target_group_attachment" "alb-demo-terraform" {
    target_group_arn = aws_lb_target_group.target-group.arn
    target_id        = aws_instance.web-1[0].id
    port             = 80
}