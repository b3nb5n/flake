{ pkgs, ... }: {
  home.packages = with pkgs; [
    kubernetes
    kubectl
    kube-bench
    kube-router
    kube-capacity
    kubecfg
    kubecolor
    kubeshark
    kubectl-tree
  ];
}