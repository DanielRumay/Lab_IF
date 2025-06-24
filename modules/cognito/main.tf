resource "aws_instance" "jenkins" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  security_groups             = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y openjdk-11-jdk
              wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
              sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
              sudo apt update -y
              sudo apt install -y jenkins
              sudo systemctl enable jenkins
              sudo systemctl start jenkins
              EOF

  tags = {
    Name = "JenkinsServer"
  }
}