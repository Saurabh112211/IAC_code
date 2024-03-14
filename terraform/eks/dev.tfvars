instance_types = [ "t3.medium" ]
min_size                               = 1
max_size                               = 3
desired_size                           = 2
autoscaling_policies_enabled           = true
map_additional_iam_users = []
region = "us-east-1"
tags      = {
    project = "test"
    enviroment = "poc"
  } 
