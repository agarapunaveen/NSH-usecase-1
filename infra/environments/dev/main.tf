module "vpc" {
  source = "../../modules/vpc"
  cidr_block = var.cidr_block
  public_cidr_block = var.public_cidr_block
  private_cidr_block = var.private_cidr_block
}



module "iam" {
  source = "../../modules/iam"
}

module "ecs" {
  source = "../../modules/ecs"
  vpc_id = module.vpc.vpc_id
  execution_role_arn = module.iam.execution_role_arn
  task_role_arn = module.iam.task_role_arn
  private_subnet = module.vpc.private_subnet
  public_subnet = module.vpc.public_subnet
}