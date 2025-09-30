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
    cidr_block                = ["10.0.0.0/16"]
    availability_zone         = ["us-east-1a", "us-east-1b", "us-east-1c"]
    availability_zone_private = ["us-east-1a", "us-east-1b"]
  }
}

subnet1_cidr = "10.0.224.0/19"
key_name     = "tmp_removeit_generated_key"

ui_health_check_path  = "/"
bff_health_check_path = "/health"
bfb_health_check_path = "/health"


alb_subnets = [
  "subnet-07d773006c3cd2763",
  "subnet-061eaeb9adeed0e3d",
  "subnet-0907a28d76902bd9f"
]

alb_private_subnets = [
  "subnet-0bd4e87c55dd5023d",
  "subnet-00c42aa077f032ae9"
]

######
#subnet_private = "us-east-1a" #["us-east-1a", "us-east-1b"]

public_subnet   = ["10.0.192.0/22", "10.0.196.0/22", "10.0.200.0/21"]
private_subnet  = ["10.0.224.0/20", "10.0.216.0/21"]
NAT_subnet_cidr = "10.0.252.0/22"

ui_host_port  = 80
ui_app_port   = 80
bff_host_port = 3000
bff_app_port  = 3000
bfb_host_port = 8020
bfb_app_port  = 8020


officehour_ui_image  = "327556301244.dkr.ecr.us-east-1.amazonaws.com/officehours-ui:latest"
officehour-bff-image = "327556301244.dkr.ecr.us-east-1.amazonaws.com/officehours-bff:latest"
officehour-bfb-image = "327556301244.dkr.ecr.us-east-1.amazonaws.com/officehours-bfb:latest"
app_count            = 1