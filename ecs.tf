resource "aws_ecs_cluster" "tmp-officehour_cluster" {
  name = "${local.workspace_name}-tmp-officehour_cluster"
}

############## OFFICEHOUR-UI Service, starts ##############
data "template_file" "tmp-officehour-ui" {
  template = file("./templates/image/${local.workspace_name}-officehour-ui.json")

  vars = {
    app_image      = var.officehour_ui_image
    app_port       = var.ui_app_port
    host_port      = var.ui_host_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.region

  }
}

resource "aws_ecs_task_definition" "tmp_officehour_ui_def" {
  family                   = "${local.workspace_name}_tmp_officehour_ui_def_tasks"
  execution_role_arn       = aws_iam_role.officehour_ecs_taskexecution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.tmp-officehour-ui.rendered

  tags = {
    Name = "${local.workspace_name}-tmp-officehour_ui_def_tasks"
  }
}

resource "aws_ecs_service" "tmp-officehour-ui-service" {
  name            = "${local.workspace_name}-tmp-officehour-ui-service"
  cluster         = aws_ecs_cluster.tmp-officehour_cluster.id
  task_definition = aws_ecs_task_definition.tmp_officehour_ui_def.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.tmp-sg-removeit.id]
    subnets          = var.alb_subnets #aws_subnet.subnet-removeit-public.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.tmp_officehour_ui_tg.arn
    container_name   = "${local.workspace_name}-tmp-officehour-ui"
    container_port   = var.ui_app_port
  }

  depends_on = [aws_alb_listener.tmp_officehour_ui_lsnr, aws_iam_role_policy_attachment.officehour_role_policyattachment1, aws_iam_role_policy_attachment.officehour_role_policyattachment2, aws_iam_role_policy_attachment.officehour_role_policyattachment3]
  tags = {
    Name = "${local.workspace_name}-tmp-officehour-ui-service"
  }
}
############## OFFICEHOUR-UI Service, ends ##############



############## OFFICEHOUR-BFF Service, starts ##############
data "template_file" "tmp-officehour-bff" {
  template = file("./templates/image/${local.workspace_name}-officehour-bff.json")

  vars = {
    app_image      = var.officehour-bff-image
    app_port       = var.bff_app_port
    host_port      = var.bff_host_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.region

  }
}

resource "aws_ecs_task_definition" "tmp_officehour_bff_def" {
  family                   = "${local.workspace_name}-officehour_bff_def_tasks"
  execution_role_arn       = aws_iam_role.officehour_ecs_taskexecution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.tmp-officehour-bff.rendered

  tags = {
    Name = "${local.workspace_name}-tmp-officehour_bff_def_tasks"
  }
}

resource "aws_ecs_service" "tmp-officehour-bff-service" {
  name            = "${local.workspace_name}-tmp-officehour-bff-service"
  cluster         = aws_ecs_cluster.tmp-officehour_cluster.id
  task_definition = aws_ecs_task_definition.tmp_officehour_bff_def.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.tmp-sg-removeit.id]
    subnets          = var.alb_subnets #aws_subnet.officehour_subnet_public.*.id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.tmp_officehour_bff_tg.arn
    container_name   = "${local.workspace_name}-tmp-officehour-bff"
    container_port   = var.bff_app_port
  }

  depends_on = [aws_alb_listener.tmp_officehour_ui_lsnr, aws_iam_role_policy_attachment.officehour_role_policyattachment1, aws_iam_role_policy_attachment.officehour_role_policyattachment2, aws_iam_role_policy_attachment.officehour_role_policyattachment3]
  tags = {
    Name = "${local.workspace_name}-tmp-officehour-bff-service"
  }
}
############## OFFICEHOUR-BFF Service, ends ##############





############## OFFICEHOUR-BFB Service, starts ##############
data "template_file" "tmp-officehour-bfb" {
  template = file("./templates/image/${local.workspace_name}-officehour-bfb.json")

  vars = {
    app_image      = var.officehour-bfb-image
    app_port       = var.bfb_app_port
    host_port      = var.bfb_host_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.region

  }
}

resource "aws_ecs_task_definition" "tmp_officehour_bfb_def" {
  family                   = "${local.workspace_name}-officehour_bfb_def_tasks"
  execution_role_arn       = aws_iam_role.officehour_ecs_taskexecution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.fargate_cpu
  memory                   = var.fargate_memory
  container_definitions    = data.template_file.tmp-officehour-bfb.rendered

  tags = {
    Name = "${local.workspace_name}-tmp-officehour_bfb_def_tasks"
  }
}

resource "aws_ecs_service" "tmp-officehour-bfb-service" {
  name            = "${local.workspace_name}-tmp-officehour-bfb-service"
  cluster         = aws_ecs_cluster.tmp-officehour_cluster.id
  task_definition = aws_ecs_task_definition.tmp_officehour_bfb_def.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.tmp-sg-internal-removeit.id]
    subnets          = var.alb_subnets #aws_subnet.officehour_subnet_public.*.id
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.tmp_officehour_bfb_tg.arn
    container_name   = "${local.workspace_name}-tmp-officehour-bfb"
    container_port   = var.bfb_app_port
  }

  depends_on = [aws_alb_listener.tmp_officehour_ui_lsnr, aws_iam_role_policy_attachment.officehour_role_policyattachment1, aws_iam_role_policy_attachment.officehour_role_policyattachment2, aws_iam_role_policy_attachment.officehour_role_policyattachment3]
  tags = {
    Name = "${local.workspace_name}-tmp-officehour-bfb-service"
  }
}
############## OFFICEHOUR-BFB Service, ends ##############