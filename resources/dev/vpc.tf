module "vpc" {
  source = "../../modules/vpc"

  vpcs = {
    main = {
      cidr_block           = "10.0.0.0/16"
      enable_dns_hostnames = true
      enable_dns_support   = true
      name                 = "vpc-${var.environment}"
    }
  }

  subnets = {
    # Public Subnets
    "public-1" = {
      vpc_id            = module.vpc.vpc_ids["main"]
      vpc_cidr_block    = "10.0.0.0/16"
      availability_zone = "us-east-1a"
      cidr_offset       = 1
      name              = "subnet-${var.environment}-public-1"
      public            = true
    }
    "public-2" = {
      vpc_id            = module.vpc.vpc_ids["main"]
      vpc_cidr_block    = "10.0.0.0/16"
      availability_zone = "us-east-1b"
      cidr_offset       = 2
      name              = "subnet-${var.environment}-public-2"
      public            = true
    }
    "public-3" = {
      vpc_id            = module.vpc.vpc_ids["main"]
      vpc_cidr_block    = "10.0.0.0/16"
      availability_zone = "us-east-1c"
      cidr_offset       = 3
      name              = "subnet-${var.environment}-public-3"
      public            = true
    }

    # Private Subnets
    "private-1" = {
      vpc_id            = module.vpc.vpc_ids["main"]
      vpc_cidr_block    = "10.0.0.0/16"
      availability_zone = "us-east-1a"
      cidr_offset       = 11
      name              = "subnet-${var.environment}-private-1"
      public            = false
    }
    "private-2" = {
      vpc_id            = module.vpc.vpc_ids["main"]
      vpc_cidr_block    = "10.0.0.0/16"
      availability_zone = "us-east-1b"
      cidr_offset       = 12
      name              = "subnet-${var.environment}-private-2"
      public            = false
    }
    "private-3" = {
      vpc_id            = module.vpc.vpc_ids["main"]
      vpc_cidr_block    = "10.0.0.0/16"
      availability_zone = "us-east-1c"
      cidr_offset       = 13
      name              = "subnet-${var.environment}-private-3"
      public            = false
    }
  }

  igws = {
    igw = {
      vpc_id = module.vpc.vpc_ids["main"]
      name   = "igw-${var.environment}"
    }
  }

  eips = {
    nat1 = {
      name = "eip-nat-${var.environment}-1"
    }
    nat2 = {
      name = "eip-nat-${var.environment}-2"
    }
    nat3 = {
      name = "eip-nat-${var.environment}-3"
    }
  }

  nat_gateways = {
    nat1 = {
      subnet_id     = module.vpc.subnet_ids["public-1"]
      allocation_id = module.vpc.eip_ids["nat1"]
      name          = "nat-gw-${var.environment}-1"
    }
    nat1 = {
      subnet_id     = module.vpc.subnet_ids["public-2"]
      allocation_id = module.vpc.eip_ids["nat2"]
      name          = "nat-gw-${var.environment}-1"
    }
    nat3 = {
      subnet_id     = module.vpc.subnet_ids["public-3"]
      allocation_id = module.vpc.eip_ids["nat3"]
      name          = "nat-gw-${var.environment}-3"
    }
  }

  route_tables = {
    public-rt = {
      vpc_id     = module.vpc.vpc_ids["main"]
      name       = "public-rt"
      routes     = [{
        cidr_block     = "0.0.0.0/0"
        gateway_id     = module.vpc.internet_gateway_ids["igw"]
        nat_gateway_id = null
      }]
      subnet_ids = [
        module.vpc.subnet_ids["public-1"],
        module.vpc.subnet_ids["public-2"],
        module.vpc.subnet_ids["public-3"]
      ]
    }

    private-rt = {
      vpc_id     = module.vpc.vpc_ids["main"]
      name       = "private-rt"
      routes     = [{
        cidr_block     = "0.0.0.0/0"
        gateway_id     = null
        nat_gateway_id = module.vpc.nat_gateway_ids["nat1"]
      }]
      subnet_ids = [
        module.vpc.subnet_ids["private-1"],
        module.vpc.subnet_ids["private-2"],
        module.vpc.subnet_ids["private-3"]
      ]
    }
  }

  tags = local.tags
}
