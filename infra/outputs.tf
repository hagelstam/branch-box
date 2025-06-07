output "endpoint_url" {
  value = module.lambda_function_from_container_image.lambda_function_url
}
