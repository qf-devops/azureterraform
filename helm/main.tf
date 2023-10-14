provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}


resource "kubernetes_namespace" "example_namespace" {
  metadata {
    name = "example-namespace"
  }
}

resource "helm_release" "example_helm_release" {
  name       = "nginx-ingress-controller"
  namespace  = kubernetes_namespace.example_namespace.metadata[0].name
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  set {
    name  = "service.type"
    value = "ClusterIP"
  }
}

resource "kubernetes_namespace" "certificate_manager" {
  metadata {
    name = "certificate-manager"
  }
}