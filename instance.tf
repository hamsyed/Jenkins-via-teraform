resource "aws_instance" "hellow-world" {
 ami = "${var.ami}" 
 instance_type = "${var.instance_type}"
 vpc_security_group_ids = ["${aws_security_group.allow_jenkins.id}"]
 availability_zone = "${var.azs}"
 key_name = "terraform"
 tags = {
	 Name = "Hello world"
 }
 provisioner "remote-exec" {
   inline = [
  "sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo",
  "sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key",
  "sudo yum install java-1.8.0-openjdk-devel.x86_64  -y",
  "sudo yum install jenkins -y",
  "sudo systemctl start jenkins",
  "sudo systemctl status jenkins",
  "sudo yum install git -y", 	   
  "wget https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip",
  "wget https://apache.mirror.digitalpacific.com.au/maven/maven-3/3.8.1/binaries/apache-maven-3.8.1-bin.zip",
  "unzip terraform_0.15.4_linux_amd64.zip",
  "unzip apache-maven-3.8.1-bin.zip",
  "sudo mv terraform /usr/local/bin/terraform",
  "sudo mv apache-maven-3.8.1 /opt",
  "terraform version",
  "sudo cat /var/lib/jenkins/secrets/initialAdminPassword", 	   
  "echo #########   all commands executed successfuly !! ##########",
  ]

 connection {
        type = "ssh"
        user = "ec2-user"
        private_key = "${file("./terraform.pem")}"
        host = "${self.public_ip}"
    }


 }
 /*user_data = <<-EOC
  #!/bin/bash 
  exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
  wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
  /bin/sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  sudo yum install java-1.8.0-openjdk-devel.x86_64  -y
  yum install jenkins -y
  systemctl start jenkins
  systemctl status jenkins
  wget -q https://releases.hashicorp.com/terraform/0.15.4/terraform_0.15.4_linux_amd64.zip
  unzip terraform_0.11.6_linux_amd64.zip
  mv terraform /usr/local/bin/terraform
  terraform version
  #echo "#########   all commands executed successfuly !! ########## "
 #EOC */
 }
