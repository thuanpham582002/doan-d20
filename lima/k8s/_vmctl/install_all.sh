vmctl config set-context /Users/noroom113/IdeaProjects/final-project-b20dccn678_thuanpt/lima/k8s/_vmctl/configuration.yaml
vmctl create .nfs.nfs_server -r -f
vmctl create .k8s_control_plane.master_node1 -r -f
vmctl create .k8s_worker -r -f
vmctl create .load_balancer -r -f
vmctl create .gitlab_runner -r -f