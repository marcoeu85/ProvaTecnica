variable "aws_provider1_region" {
  description = "AWS region for provider 1"
  type        = string
  default     = "eu-south-1"
}
variable "ASG-LT-ELB-TG_EC2AppType" {
  description = "AMI launch template for ASG"
  type        = string
  default     = "c5a.large"
}
variable "ASG-LT-ELB-TG_EC2AppAMI" {
  description = "AMI launch template for ASG"
  type        = string
  default     = "ami-04a7ae2c9fa687f3f"
}
variable "EC2DBAmi" {
  description = "AMI for EC2 with db"
  type        = string
  default     = "ami-055e1aad53a5c3187"
}
variable "ASG-LT-ELB-TG_CapacityDesired" {
  description = "Desidered capacity for ASG"
  type        = string
  default     = "1"
}
variable "ASG-LT-ELB-TG_CapacityMin" {
  description = "Min capacity for ASG"
  type        = string
  default     = "1"
}
variable "ASG-LT-ELB-TG_CapacityMax" {
  description = "Max capacity for ASG"
  type        = string
  default     = "1"
}


