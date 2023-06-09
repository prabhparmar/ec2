provider "aws" {
  access_key = "your_accesskey"
  secret_key = "your_secretkey"
  region     = var.region
}

resource "aws_s3_bucket" "bucket" {
  bucket = "test-bucket"
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_security_group" "alb" {
  name_prefix = "alb"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb" "load_balancer" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb.id]
  subnets         = ["subnet-12345678", "subnet-87654321"]
}

resource "aws_lb_target_group" "target_group" {
  name        = "test-target-group"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "vpc-12345678"
}

resource "aws_instance" "test" {
  ami           = "ami-08333bccc35d71140"
  instance_type = "t2.micro"

  subnet_id              = "subnet-12345678"
  vpc_security_group_ids = [aws_security_group.alb.id]

  tags = {
    Name = "test-instance"
  }
}

resource "aws_lb_target_group_attachment" "instance_1" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.test.id
}

