ami                     = "ami-0261755bbcb8c4a84"
region                  = "us-east-1"
instance_type           = "t2.micro"
vpc_cidr                = "10.0.0.0/16"
vpc                     = "tmp_vpc_removeit"
fargate_cpu             = 2048
fargate_memory          = 4096 #512
ecs_task_execution_role = "ecs_task_execution_role"
availability_zones      = ["us-east-1a", "us-east-1b", "us-east-1c"]
availability_zone_NAT   = "us-east-1a"

pub_subnet = {
  "PubSub1" = {
    cidr_block        = ["10.0.0.0/16"]
    availability_zone = ["us-east-1a", "us-east-1b", "us-east-1c"]
  }
}

subnet1_cidr         = "10.0.224.0/19"
key_name             = "tmp_removeit_generated_key"

ui_health_check_path = "/"
bff_health_check_path="/health"

alb_subnets = [
  "subnet-0ad8637209a9b4f9a",
  "subnet-053c7f4a51824ec10",
  "subnet-01148089b97164165"]

#subnet_private = "us-east-1a"
ui_app_port    = 80
ui_host_port   = 80
bff_app_port   = 3000
bff_host_port  = 3000

officehour_ui_image  = "327556301244.dkr.ecr.us-east-1.amazonaws.com/officehours-ui:latest"
officehour-bff-image = "327556301244.dkr.ecr.us-east-1.amazonaws.com/officehours-bff:latest"
app_count            = 1