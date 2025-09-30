
// S3
data "aws_iam_policy_document" "s3_officehour_objects_policy_doc" {
  statement {
    sid = "officehour_s3_moveobjects_document"
    actions = [
      "s3:DeleteObjectOfficehour",
      "s3:PutBucketOfficehour",
      "s3:ReplicateTags",
      "s3:PutObjectVersionOfficehour",
      "s3:PutObjectOfficehour",
      "s3:DeleteObjectVersionOfficehour"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "officehour_ecs_taskexecution_policy_doc" {
  version = "2012-10-17"
  statement {
    sid     = ""
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

//
resource "aws_iam_policy" "officehourAdministratorAccess_policy" {
  name = "${terraform.workspace}-officehour-AdministratorAccess-policy"

  policy = jsonencode({
    Version : "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "*",
        Resource = "*"
      }
    ]
  })
}

//
resource "aws_iam_policy" "officehour_ecs_policy" {
  name = "${terraform.workspace}-officehour-ecs-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "officehourecspolicy"
        Effect   = "Allow"
        Action   = ["sts:AssumeRole"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_policy" "officehour_ecr_policy" {
  name = "${terraform.workspace}-officehour-ecr-policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "officehourecrpolicy"
        Effect = "Allow"
        Action = [
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:BatchCheckLayerAvailability",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:DescribeRepositories",
          "ecr:GetRepositoryPolicy",
          "ecr:ListImages",
          "ecr:DeleteRepository",
          "ecr:BatchDeleteImage",
          "ecr:SetRepositoryPolicy",
          "ecr:DeleteRepositoryPolicy"
        ]
        Resource = "*"
      }
    ]
  })
}

locals {
  vars = {
    "ecs1" = "ecs1",
    "ecr2" = "ecr2"
  }
}

//
resource "aws_iam_role" "officehour_ecs_taskexecution_role" {
  name               = "${terraform.workspace}-${var.ecs_task_execution_role}"
  description        = "test _ access to source and destination S3 bucket"
  assume_role_policy = data.aws_iam_policy_document.officehour_ecs_taskexecution_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "officehour_role_policyattachment1" {
  #for_each = locals.vars
  role       = aws_iam_role.officehour_ecs_taskexecution_role.name
  policy_arn = aws_iam_policy.officehour_ecs_policy.arn
}

resource "aws_iam_role_policy_attachment" "officehour_role_policyattachment2" {
  #for_each = locals.vars
  role       = aws_iam_role.officehour_ecs_taskexecution_role.name
  policy_arn = aws_iam_policy.officehour_ecr_policy.arn
}

resource "aws_iam_role_policy_attachment" "officehour_role_policyattachment3" {
  #for_each = locals.vars
  role       = aws_iam_role.officehour_ecs_taskexecution_role.name
  policy_arn = aws_iam_policy.officehourAdministratorAccess_policy.arn
}
