resource "aws_cloudwatch_log_group" "tmp_officehour_log_group" {
  name              = "/ecs/tmp-officehourapp"
  retention_in_days = 1

  tags = {
    Name = "${local.instance_name}-tmp-officehour-cw-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "tmp_officehour_log_stream" {
  name           = "${local.instance_name}-tmp-officehour-log-stream"
  log_group_name = aws_cloudwatch_log_group.tmp_officehour_log_group.name
}