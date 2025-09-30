variable "region" {
  type = string
}

variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "vpc" {
  type = string
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(any)
}
variable "availability_zone_NAT" {
  type = string
}
variable "ecs_task_execution_role" {
  type = string
}

variable "subnet1_cidr" {
  type = string
}

variable "pub_subnet" {
  type = map(object({
    cidr_block                = list(any)
    availability_zone         = list(any)
    availability_zone_private = list(any)
  }))
  default     = {}
  description = "map object for subnet"
}

variable "key_name" {
  type = string
}

variable "instance_username" {
  default = "ubuntu"
}

variable "alb_subnets" {
  type = list(any)
}
variable "alb_private_subnets" {
  type = list(any)
}

# variable "subnet_private" {
#   type = string
# }
variable "private_subnet" {
  type = list(any)
}

variable "NAT_subnet_cidr" {
  type = string
}

variable "public_subnet" {
  type = list(any)
}

##########
variable "ui_health_check_path" {
  type = string
}

variable "officehour_ui_image" {
  type = string
}
variable "ui_app_port" {
  type = number
}

variable "ui_host_port" {
  type = number
}

##########
variable "bff_health_check_path" {
  type = string
}

variable "officehour-bff-image" {
  type = string
}

variable "bff_app_port" {
  type = number
}

variable "bff_host_port" {
  type = number
}

##########
variable "bfb_health_check_path" {
  type = string
}

variable "officehour-bfb-image" {
  type = string
}

variable "bfb_app_port" {
  type = number
}

variable "bfb_host_port" {
  type = number
}

##########
variable "fargate_cpu" {
  type = number
}

variable "fargate_memory" {
  type = number
}
variable "app_count" {
  type = number
}




# variable "pub_subnet" {
#   type = map(object({
#     cidr_block        = string
#     availability_zone = string
#   }))
#   default = {
#     "PubSub1" = {
#       cidr_block        = "10.0.0.0/16"
#       availability_zone = "us-east-1a"
#     }
#   }
# }