variable "project_name" {
  description = "Name of the project"
  type        = string
  default = "NSH-usecase-1"
}

variable "container_port" {
  description = "Port exposed by the container"
  type        = number
  default     = 3000
}

variable "container_cpu" {
  description = "CPU units for the container (1024 = 1 vCPU)"
  type        = number
  default     = 256
}

variable "container_memory" {
  description = "Memory for the container in MB"
  type        = number
  default     = 512
}

variable "app_count" {
  description = "Number of containers to run"
  type        = number
  default     = 2
}

variable "vpc_id" {
  
}

variable "public_cidr_block" {
  default= ["10.0.1.0/24","10.0.2.0/24"]
}

variable "execution_role_arn" {
  
}
variable "task_role_arn" {
  
}
variable "public_subnet" {
  
}