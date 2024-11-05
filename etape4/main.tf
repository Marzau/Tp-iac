provider "aws" {
  region = "us-west-2"  # Remplace par la région souhaitée
}

resource "aws_instance" "http_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # AMI appropriée
  instance_type = "t2.micro"

  tags = {
    Name = "HTTP-Container"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker"
    ]
  }
}

resource "aws_instance" "php_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # AMI appropriée
  instance_type = "t2.micro"

  tags = {
    Name = "PHP-FPM-Container"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker"
    ]
  }
}

resource "aws_instance" "db_instance" {
  ami           = "ami-0c55b159cbfafe1f0"  # AMI appropriée
  instance_type = "t2.micro"

  tags = {
    Name = "DB-Container"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker"
    ]
  }
}

output "instance_ips" {
  value = [
    aws_instance.http_instance.public_ip,
    aws_instance.php_instance.public_ip,
    aws_instance.db_instance.public_ip
  ]
}
