resource "aws_security_group" "allow_jenkins" {
  name        = "jenkins"
  description = "Allow inbound traffic to jenkins"

  ingress {
    description      = "allow ssh"
    from_port        = "${var.ssh}"
    to_port          = "${var.ssh}"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

   ingress {
    description      = "allow jenkins"
    from_port        = "${var.jenkins_port}"
    to_port          = "${var.jenkins_port}"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_jenkins"
  }
}