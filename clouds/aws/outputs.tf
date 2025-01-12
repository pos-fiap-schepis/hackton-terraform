output "vpc_id" {
  value = module.vpc.vpc_id
}

output "app_cluster_endpoint" {
  value = module.app_cluster.cluster_endpoint
}

output "infra_cluster_endpoint" {
  value = module.infra_cluster.cluster_endpoint
}
