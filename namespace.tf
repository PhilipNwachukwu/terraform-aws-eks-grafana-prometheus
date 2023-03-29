resource "null_resource" "kubeconfig" {
  triggers = {
    always = timestamp()
  }

  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOT
      set -e
      echo 'Applying Auth ConfigMap with kubectl...'
      aws eks wait cluster-active --name '${local.cluster_name}'
      aws eks update-kubeconfig --name ${EKS_CLUSTER_NAME} --region ${REGION}
    EOT
  }
}

resource "kubernetes_namespace" "grafana" {
#   depends_on = [module.eks]
  count      = (var.enabled && var.create_namespace_grafana && var.namespace_grafana != "kube-system") ? 1 : 0

  metadata {
    name = var.namespace_grafana
  }
}

resource "kubernetes_namespace" "prometheus" {
#   depends_on = [module.eks]
  count      = (var.enabled && var.create_namespace_prometheus && var.namespace_prometheus != "kube-system") ? 1 : 0

  metadata {
    name = var.namespace_prometheus
  }
}
