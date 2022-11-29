terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.37.0"
    }
  }

  required_version = ">= 1.3.0"
}

provider "aws" {
  region = "us-east-1"
}
################################################################################
# Calling Bot
################################################################################
module "bot_appointment_doctor" {
  source = "./modules/bot"

  bot_name        = var.bot_name
  bot_description = var.bot_description
}