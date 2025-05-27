// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

variable "compartments" {
  type        = any
  description = "Hierarchical Compartments"
}

variable "root_compartment_id" {
  type        = string
  description = "Target compartment id which is considered as root"
}
