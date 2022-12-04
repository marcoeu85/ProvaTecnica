terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

# locals {
#   json_data = jsondecode(file("${path.module}/data.json"))
# }

# ***** REGION MILAN *****
provider "aws" {
  profile = "default"
  region  = var.aws_provider1_region
}

# Creazione da template AWS Cloudformation ParameterStore-milan
resource "aws_cloudformation_stack" "ParameterStore-milan" {
  name          = "ParameterStore-milan"
  template_body = file("${path.module}/jsonTemplates/ParameterStore-milan.json")
}

# Creazione da template AWS Cloudformation NetworkMain
resource "aws_cloudformation_stack" "NetworkMain" {
  name          = "NetworkMain"
  template_body = file("${path.module}/jsonTemplates/NetworkMain.json")
  depends_on    = [aws_cloudformation_stack.ParameterStore-milan]
}

# Creazione da template AWS Cloudformation NetworkNatRoutes
resource "aws_cloudformation_stack" "NetworkNatRoutes" {
  name          = "NetworkNatRoutes"
  template_body = file("${path.module}/jsonTemplates/NetworkNatRoutes.json")
  depends_on    = [
    aws_cloudformation_stack.NetworkMain,
    aws_cloudformation_stack.ParameterStore-milan
    ]
}

# Creazione da template AWS Cloudformation SecurityGroups
resource "aws_cloudformation_stack" "SecurityGroups" {
  name          = "SecurityGroups"
  template_body = file("${path.module}/jsonTemplates/SecurityGroups.json")
  depends_on    = [
    aws_cloudformation_stack.NetworkNatRoutes,
    aws_cloudformation_stack.ParameterStore-milan
    ]
}

# Creazione da template AWS Cloudformation ASG-LT-ELB-TG
resource "aws_cloudformation_stack" "ASG-LT-ELB-TG" {
  name = "ASG-LT-ELB-TG"
  parameters = {
    #CapacityDesired = local.json_data.CapacityDesired
    #CapacityMin     = local.json_data.CapacityMin
    #CapacityMax     = local.json_data.CapacityMax
    EC2AppType      = var.ASG-LT-ELB-TG_EC2AppType
    EC2AppAMI       = var.ASG-LT-ELB-TG_EC2AppAMI
    CapacityDesired = var.ASG-LT-ELB-TG_CapacityDesired
    CapacityMin     = var.ASG-LT-ELB-TG_CapacityMin
    CapacityMax     = var.ASG-LT-ELB-TG_CapacityMax
  }
  template_body = file("${path.module}/jsonTemplates/ASG-LT-ELB-TG.json")
  depends_on    = [
    aws_cloudformation_stack.SecurityGroups,
    aws_cloudformation_stack.ParameterStore-milan
  ]
}

# Creazione da template AWS Cloudformation WAF-ALB
resource "aws_cloudformation_stack" "WAF-ALB" {
  name          = "WAF-ALB"
  template_body = file("${path.module}/jsonTemplates/WAF-ALB.json")
  depends_on    = [
    aws_cloudformation_stack.ASG-LT-ELB-TG,
    aws_cloudformation_stack.ParameterStore-milan
    ]
}

