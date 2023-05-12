variable        "region"      {
default      =  "eu-west-2"
description  =  "Aws region"
}

variable        "vpc_cidr"      {
default      =  "10.0.0.0/16"
description  =  "This is the vpc cidr cidr_block"
}


variable        "public_subnet_1_cidr"      {
default      =  "10.0.0.0/24"
description  =  "This is the public sub-1 cidr_block"
}

variable        "public_subnet_2_cidr"      {
default      =  "10.0.1.0/24"
description  =  "This is the public sub-2 cidr_block"
}

variable        "private_subnet_1_cidr"      {
default      =  "10.0.2.0/24"
description  =  "This is the private sub-1 cidr_block"
}

variable        "private_subnet_2_cidr"      {
default      =  "10.0.3.0/24"
description  =  "This is the private sub-2 cidr_block"
}



