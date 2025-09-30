# output "subnet" {
#   value = aws_subnet.subnet-removeit[0].id
#   #value = join(",", aws_subnet.subnet-removeit.)
#   #value = ["${aws_subnet.subnet-removeit.*.id}"]
#   #value = concat(aws_subnet.subnet-removeit.*.id, aws_subnet.prod2_public.*.id)
# }

output "instance_name" {
  value = local.instance_name
}

output "alb_ui_hostname" {
  value = aws_alb.tmp-officehouralb-ui.dns_name
}
