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
    cidr_block                = ["10.0.0.0/16"]
    availability_zone         = ["us-west-2a", "us-west-2b", "us-west-2c"]
    availability_zone_private = ["us-west-2a", "us-west-2b"]
  }
}


######
subnet1_cidr          = "10.0.224.0/19"
key_name              = "tmp_removeit_generated_key"
ui_health_check_path  = "/"
bff_health_check_path = "/health"
bfb_health_check_path = "/health"


######
alb_subnets = [
  "subnet-09dfebefab508f1ef",
  "subnet-036cfb68576900385",
  "subnet-0bcf9d7fd369c4079"
]
alb_private_subnets = [
  "subnet-02d169cca4277ae82"
]


######
#subnet_private = "us-west-2a"#["us-west-2a", "us-west-2b"]
public_subnet   = ["10.0.192.0/22", "10.0.196.0/22", "10.0.200.0/21"]
private_subnet  = ["10.0.224.0/20", "10.0.240.0/20"]
NAT_subnet_cidr = "10.0.252.0/22"

ui_host_port  = 80
ui_app_port   = 80
bff_host_port = 3000
bff_app_port  = 3000
bfb_host_port = 8020
bfb_app_port  = 8020


######
officehour_ui_image  = "327556301244.dkr.ecr.us-east-1.amazonaws.com/officehours-ui:latest"
officehour-bff-image = "327556301244.dkr.ecr.us-east-1.amazonaws.com/officehours-bff:latest"
officehour-bfb-image = "327556301244.dkr.ecr.us-east-1.amazonaws.com/officehours-bfb:latest"
app_count            = 1