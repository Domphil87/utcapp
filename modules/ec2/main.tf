data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_launch_template" "this" {
  name = "${var.project_name}-${var.environment}-ec2"

  image_id      = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  iam_instance_profile {
    name = var.ec2_instance_profile_name
  }

  vpc_security_group_ids = [
    var.app_security_group_id
  ]

  monitoring {
    enabled = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash

    dnf update -y

    dnf install -y httpd

    systemctl enable httpd
    systemctl start httpd

    echo "<h1>${var.project_name} - ${var.environment}</h1>" > /var/www/html/index.html
    echo "<p>Application server is running.</p>" >> /var/www/html/index.html
  EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = merge(
      var.tags,
      {
        Name        = "${var.project_name}-${var.environment}-ec2"
        Project     = var.project_name
        Environment = var.environment
        Tier        = "application"
        ManagedBy   = "Terraform"
      }
    )
  }

  tags = merge(
    var.tags,
    {
      Name        = "${var.project_name}-${var.environment}-ec2-launch-template"
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

resource "aws_autoscaling_group" "this" {
  name = "${var.project_name}-${var.environment}-ec2-asg"

  min_size         = var.min_size
  max_size          = var.max_size
  desired_capacity  = var.desired_capacity

  vpc_zone_identifier = var.private_app_subnet_ids

  health_check_type         = "ELB"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.this.id
    version = aws_launch_template.this.latest_version
  }

  tag {
    key                 = "Name"
    value               = "${var.project_name}-${var.environment}-ec2"
    propagate_at_launch = true
  }

  tag {
    key                 = "Project"
    value               = var.project_name
    propagate_at_launch = true
  }

  tag {
    key                 = "Environment"
    value               = var.environment
    propagate_at_launch = true
  }

  tag {
    key                 = "Tier"
    value               = "application"
    propagate_at_launch = true
  }

  tag {
    key                 = "ManagedBy"
    value               = "Terraform"
    propagate_at_launch = true
  }
}