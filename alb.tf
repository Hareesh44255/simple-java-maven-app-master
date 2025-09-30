##################  officehour_ui_ alb, tg, starts   ##################
resource "aws_alb" "tmp-officehouralb-ui" {
  #count =  length(aws_subnet.subnet-removeit-public)
  #for_each      =      aws_subnet.subnet-removeit-public
  name    = "${local.workspace_name}-tmp-officehouralb-ui"
  subnets = var.alb_subnets
  #subnets = "${aws_subnet.subnet-removeit-public.*.id}"
  security_groups            = [aws_security_group.tmp-sg-removeit.id]
  enable_deletion_protection = false
  tags = {
    Name = "${local.workspace_name}-tmp-officehouralb-ui"
  }
}


resource "aws_alb_target_group" "tmp_officehour_ui_tg" {
  name        = "${local.workspace_name}-tmp-officehour-ui-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.tmp-vpc-removeit.id
  health_check {
    protocol            = "HTTP"
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 60
    matcher             = "200" ## TODO, change this later with correct statuscode 200
    path                = var.ui_health_check_path
    interval            = 100
  }
  tags = {
    Name = "${local.workspace_name}-tmp-officehour_ui_tg"
  }
}

resource "aws_alb_listener" "tmp_officehour_ui_lsnr" {
  load_balancer_arn = aws_alb.tmp-officehouralb-ui.id
  port              = 80 #var.app_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tmp_officehour_ui_tg.arn
  }
  #     tags = {
  #     Name = "${local.workspace_name}-tmp_officehour_ui_lsnr"
  #   }
}
##################  officehour_ui_ alb, tg, end   ##################



##################  officehour_BFF_alb,tg, starts   ##################
resource "aws_alb" "tmp-officehouralb-bff" {
  #count =  length(aws_subnet.subnet-removeit-public)
  #for_each      =      aws_subnet.subnet-removeit-public
  name    = "${local.workspace_name}-tmp-officehouralb-bff"
  subnets = var.alb_subnets
  #subnets = "${aws_subnet.subnet-removeit-public.*.id}"
  security_groups            = [aws_security_group.tmp-sg-removeit.id]
  enable_deletion_protection = false
  tags = {
    Name = "${local.workspace_name}-tmp-officehouralb-bff"
  }
}

resource "aws_alb_target_group" "tmp_officehour_bff_tg" {
  name        = "${local.workspace_name}-tmp-officehour-bff-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.tmp-vpc-removeit.id
  health_check {
    protocol            = "HTTP"
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 60
    matcher             = "200" ## TODO, change this later with correct statuscode 200
    path                = var.bff_health_check_path
    interval            = 100
  }
  tags = {
    Name = "${local.workspace_name}-tmp-officehour_bff_tg"
  }
}

resource "aws_alb_listener" "tmp_officehour_bff_lsnr" {
  load_balancer_arn = aws_alb.tmp-officehouralb-bff.id
  port              = 80 #var.app_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tmp_officehour_bff_tg.arn
  }
}
##################  officehour_BFF_alb,tg, end   ##################





##################  officehour_BFB_alb,tg, starts   ##################
resource "aws_alb" "tmp-officehouralb-bfb" {
  #count =  length(aws_subnet.subnet-removeit-public)
  #for_each      =      aws_subnet.subnet-removeit-public
  name    = "${local.workspace_name}-tmp-officehouralb-bfb"
  subnets = var.alb_private_subnets
  #subnets = "${aws_subnet.subnet-removeit-public.*.id}"
  security_groups            = [aws_security_group.tmp-sg-internal-removeit.id]
  enable_deletion_protection = false
  tags = {
    Name = "${local.workspace_name}-tmp-officehouralb-bfb"
  }
}

resource "aws_alb_target_group" "tmp_officehour_bfb_tg" {
  name        = "${local.workspace_name}-tmp-officehour-bfb-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.tmp-vpc-removeit.id
  health_check {
    protocol            = "HTTP"
    port                = 80
    healthy_threshold   = 3
    unhealthy_threshold = 10
    timeout             = 60
    matcher             = "200" ## TODO, change this later with correct statuscode 200
    path                = var.bfb_health_check_path
    interval            = 100
  }
  tags = {
    Name = "${local.workspace_name}-tmp-officehour_bfb_tg"
  }
}

resource "aws_alb_listener" "tmp_officehour_bfb_lsnr" {
  load_balancer_arn = aws_alb.tmp-officehouralb-bfb.id
  port              = 80 #var.app_port
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tmp_officehour_bfb_tg.arn
  }
}
##################  officehour_BFB_alb,tg, end   ##################
