output "resource_group_names" {
  description = "Names of the created resource groups"
  value       = [for rg_name in azurerm_resource_group.Mygroup : rg_name.name]
}
