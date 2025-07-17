module "bucket" {
  source = "../../modules/aws/s3"

  bucket_name = "${local.org_name}-s3-bucket-${local.team}-${local.product}-${local.service}-${var.environment}"
  tags        = local.tags
}
