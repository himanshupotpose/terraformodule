# for vpc only variables
vpc_env = "test"
vpc_cidr_block = "198.16.0.0/16"
vpc_public_sub_cidrs = ["198.16.0.0/20", "198.16.16.0/20", "198.16.32.0/20"]
vpc_private_sub_cidrs = ["198.16.48.0/20", "198.16.64.0/20", "198.16.80.0/20"]
vpc_projectname = "vpc-eks-project"



# for cluster variables
eks_cluster_name = "my-eks-cluster"
eks_cluster_addon = [
  "eks-pod-identity-agent",
  "vpc-cni",
  "kube-proxy"
]

eks_instance_types = ["t3.small"]