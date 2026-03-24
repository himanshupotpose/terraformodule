provider "aws" {
  region = "ap-south-1"
}


module "vpc_module_eks" {
  source = "./vpc-module"
  env = var.vpc_env
    projectname = var.vpc_projectname
    vpc_cidr_block = var.vpc_cidr_block
    public_sub_cidr = var.vpc_public_sub_cidrs
    private_sub_cidr = var.vpc_private_sub_cidrs


  
}

module "eks_module" {
  source = "./eks-module"
  cluster_name = var.eks_cluster_name
  cluster_addons = var.eks_cluster_addon
  ng_instance_types = var.eks_instance_types
  subnet_ids = module.vpc_module_eks.subnet_id_public
  
  

  
  
        

}