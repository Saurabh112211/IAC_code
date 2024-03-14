provider "aws" {
  region = "us-east-1"  
}

resource "aws_instance" "metadata" {
  ami           = "ami-0274c926b2daf1d51"
  instance_type = "t2.micro"

  user_data = <<-EOF
    #!/bin/bash
    
    # Execute metadata.sh script
    /home/ubuntu/get_instance_metadata.sh > /home/ubuntu/output-metadata.sh
  EOF
}
