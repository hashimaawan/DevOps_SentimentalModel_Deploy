variable "name"          { type = string }
variable "vpc_cidr"      { type = string }
variable "public_subnets_cidrs" { type = list(string) }
variable "azs"           { type = list(string) }
