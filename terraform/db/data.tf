data "aws_caller_identity" "this"  {}

data "aws_vpc" "vpc" {
    filter {
        name = "tag:Name"
        values = ["${var.namespace}-${var.stage}-network" ]
    }
}

data "aws_subnets" "public" {
    filter {
        name = "tag:Name"
        values = [
          "${var.namespace}-${var.stage}-network-public-use1a",
          "${var.namespace}-${var.stage}-network-public-use1b"   
         ]

    }
}

data "aws_subnets" "private" {
    filter {
        name = "tag:Name"
        values = [
          "${var.namespace}-${var.stage}-network-private-use1a",
          "${var.namespace}-${var.stage}-network-private-use1b"   
         ]

    }
}

