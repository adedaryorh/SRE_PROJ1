module "project_rds_p" {
  source = "./modules/rds-p"
  private_subnet_ids = module.vpc.private_subnet_ids
  vpc_id = module.vpc.vpc_id
}

module "project_rds_s" {
  depends_on = [resource.time_sleep.wait_120_seconds]
  source                  = "./modules/rds-s"
  primary_db_cluster_arn  = module.project_rds_p.db_cluster_arn
  providers = {
    aws = aws.usw1
  }
  private_subnet_ids = module.vpc_west.private_subnet_ids
  vpc_id = module.vpc_west.vpc_id
}

resource "time_sleep" "wait_120_seconds" {
  depends_on = [module.project_rds_p]
  create_duration = "120s"
}