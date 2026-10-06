module "vpc" {
  source                  = "./module/vpc"
  name                    = var.name
  vpc_name                = var.vpc_name
  public_subnet_name      = var.public_subnet_name
  public_subnet_name2     = var.public_subnet_name2
  igw_name                = var.igw_name
  public_route_table_name = var.public_route_table_name
  tags                    = var.tags
}

module "securitygroup" {
  source           = "./module/securitygroup"
  name             = var.name
  description      = "Allow SSH and HTTP inbound traffic"
  vpc_id           = module.vpc.vpc_id
  ssh_allowed_cidr = var.ssh_allowed_cidr
  tags             = var.tags
}

module "ec2" {
  source                 = "./module/ec2"
  name                   = var.name
  AMI_ID                 = var.AMI_ID
  instance_type          = var.instance_type
  vpc_security_group_ids = [module.securitygroup.security_group_id]
  subnet_id              = module.vpc.public_subnet_id
  key_name               = var.key_name
  user_data              = var.user_data
  tags                   = var.tags

}

module "elastic_ip" {
  source      = "./module/elastic_ip"
  name        = var.name
  instance_id = module.ec2.instance_id
  tags        = var.tags
}

module "s3" {
  source         = "./module/s3"
  s3_bucket_name = var.bucket_name
  tags           = var.tags
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/module/lambda.zip/index.py"
  output_path = "${path.module}/function.zip"
}



module "lambda" {
  source                = "./module/lambda"
  function_name         = var.lambda_function_name
  handler               = "index.handler"
  runtime               = var.lambda_runtime
  filename              = data.archive_file.lambda_zip.output_path
  environment_variables = {}
  tags                  = var.tags
}

module "cloudwatch" {
  source        = "./module/cloudwatch"
  alarm_name    = "${var.name}-high-cpu"
  instance_id   = module.ec2.instance_id
  cpu_threshold = var.cpu_threshold
  tags          = var.tags
}