ami                     = "ami-003634241a8fcdec0"
region                  = "us-west-2"
instance_type           = "t2.micro"
vpc_cidr                = "10.0.0.0/16"
vpc                     = "tmp_vpc_removeit"
ecs_task_execution_role = "ecs_task_execution_role"
availability_zones      = ["us-west-2a", "us-west-2b"]
