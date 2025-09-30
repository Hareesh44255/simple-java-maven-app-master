ami                     = "ami-003634241a8fcdec0"
region                  = "us-west-2"
instance_type           = "t2.medium"
vpc_cidr                = "10.0.0.0/16"
vpc                     = "tmp_vpc_removeit"
fargate_cpu             = 2048
fargate_memory          = 4096
ecs_task_execution_role = "ecs_task_execution_role"
availability_zones      = ["us-west-2a", "us-west-2b"]
availability_zone_NAT   = "us-west-2a"

pub_subnet = {
  "PubSub1" = {
    cidr_block        = ["10.0.0.0/16"]
    availability_zone = ["us-west-2a", "us-west-2b", "us-west-2c"]
  }
}

subnet1_cidr          = "10.0.224.0/19"
key_name              = "tmp_removeit_generated_key"
ui_health_check_path  = "/"
bff_health_check_path = "/health"
alb_subnets = [
  "subnet-0c272b12f834de972",
  "subnet-0b80d65d07b2a0235",
  "subnet-09cf3865b703c0fdb"
]

#subnet_private      = "us-west-2a"
ui_app_port    = 80
ui_host_port   = 80
bff_app_port   = 3000
bff_host_port  = 3000

officehour_ui_image  = "327556301244.dkr.ecr.us-east-1.amazonaws.com/officehours-ui:latest"
officehour-bff-image = "327556301244.dkr.ecr.us-east-1.amazonaws.com/officehours-bff:latest"
app_count            = 1