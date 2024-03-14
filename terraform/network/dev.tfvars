availability_zones = [ "us-east-1a", "us-east-1b"]
ipv4_primary_cidr_block = "172.0.0.0/16"
namespace   = "test"
  name      = "network"
  stage     = "poc"
  tags      = {
        project = "test"
        enviroment = "poc"
  } 

max_nats = 1
max_subnet_count = 0
region = "us-east-1"

