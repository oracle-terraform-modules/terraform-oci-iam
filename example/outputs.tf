// Copyright (c) 2018, Oracle and/or its affiliates. All rights reserved.

output "compartment_name" {
  value = "${module.iam_compartment.compartment_name}"
}

output "compartment_id" {
  value = "${module.iam_compartment.compartment_id}"
}

output "iam_user1_name" {
  value = "${module.iam_user1.user_name}"
}

output "iam_user2_name" {
  value = "${module.iam_user2.user_name}"
}

output "iam_user1_id" {
  value = "${module.iam_user1.user_id}"
}

output "iam_user2_id" {
  value = "${module.iam_user2.user_id}"
}

output "iam_group_name" {
  value = "${module.iam_group.group_name}"
}

output "iam_dynamic_group_name" {
  value = "${module.iam_dynamic_group.dynamic_group_name}"
}