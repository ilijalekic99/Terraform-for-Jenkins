resource "aws_security_group" "jenkins_web_sg" {
  name        = "jenkins_web_sg"
  description = "Security group for jenkins web servers"
  vpc_id      = aws_vpc.jenkins_vpc.id

  ingress {
    description = "Allow all traffic through HTTP"
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all traffic through ports 8080"
    from_port   = "8080"
    to_port     = "8080"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow all traffic through ports 50000"
    from_port   = "50000"
    to_port     = "50000"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH from my computer"
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins_web_sg"
  }
}

resource "aws_security_group" "jenkins_db_sg" {
  name        = "jenkins_db_sg"
  description = "Security group for jenkins databases"
  vpc_id      = aws_vpc.jenkins_vpc.id

  ingress {
    description     = "Allow MySQL traffic from only the web sg"
    from_port       = "3306"
    to_port         = "3306"
    protocol        = "tcp"
    security_groups = [aws_security_group.jenkins_web_sg.id]
  }

  tags = {
    Name = "jenkins_db_sg"
  }
}