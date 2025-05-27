// Copyright (c) 2018, 2021, Oracle and/or its affiliates.

locals {
  compartment_level_1 = flatten(setsubtract([for entry1 in var.compartments : {
    compartment_name = entry1.compartment_name
    defined_tags     = lookup(entry1, "defined_tags", null)
    description      = entry1.description
    freeform_tags    = lookup(entry1, "freeform_tags", {})
  enable_delete = lookup(entry1, "enable_delete", false) }], []))

  compartment_level_2 = flatten(setsubtract([for entry1 in var.compartments : [for entry2 in entry1.compartments : {
    compartment_name   = entry2.compartment_name
    defined_tags       = lookup(entry2, "defined_tags", null)
    description        = entry2.description
    freeform_tags      = lookup(entry2, "freeform_tags", {})
    parent_compartment = entry1.compartment_name
  enable_delete = lookup(entry2, "enable_delete", false) }]], []))

  compartment_level_3 = flatten(setsubtract([for entry1 in var.compartments : [for entry2 in entry1.compartments :
    [for entry3 in entry2.compartments : {
      compartment_name   = entry3.compartment_name
      defined_tags       = lookup(entry3, "defined_tags", null)
      description        = entry3.description
      freeform_tags      = lookup(entry3, "freeform_tags", {})
      parent_compartment = "${entry1.compartment_name}/${entry2.compartment_name}"
  enable_delete = lookup(entry3, "enable_delete", false) }]]], []))

  compartment_level_4 = flatten(setsubtract([for entry1 in var.compartments : [for entry2 in entry1.compartments :
    [for entry3 in entry2.compartments : [for entry4 in entry3.compartments : {
      compartment_name   = entry4.compartment_name
      defined_tags       = lookup(entry4, "defined_tags", null)
      description        = entry4.description
      freeform_tags      = lookup(entry4, "freeform_tags", {})
      parent_compartment = "${entry1.compartment_name}/${entry2.compartment_name}/${entry3.compartment_name}"
  enable_delete = lookup(entry4, "enable_delete", false) }]]]], []))

  compartment_level_5 = flatten(setsubtract([for entry1 in var.compartments : [for entry2 in entry1.compartments :
    [for entry3 in entry2.compartments : [for entry4 in entry3.compartments :
      [for entry5 in entry4.compartments : {
        compartment_name   = entry5.compartment_name
        defined_tags       = lookup(entry5, "defined_tags", null)
        description        = entry5.description
        freeform_tags      = lookup(entry5, "freeform_tags", {})
        parent_compartment = "${entry1.compartment_name}/${entry2.compartment_name}/${entry3.compartment_name}/${entry4.compartment_name}"
  enable_delete = lookup(entry5, "enable_delete", false) }]]]]], []))

  compartment_level_6 = flatten(setsubtract([for entry1 in var.compartments : [for entry2 in entry1.compartments :
    [for entry3 in entry2.compartments : [for entry4 in entry3.compartments :
      [for entry5 in entry4.compartments : [for entry6 in entry5.compartments : {
        compartment_name   = entry6.compartment_name
        defined_tags       = lookup(entry6, "defined_tags", null)
        description        = entry6.description
        freeform_tags      = lookup(entry6, "freeform_tags", {})
        parent_compartment = "${entry1.compartment_name}/${entry2.compartment_name}/${entry3.compartment_name}/${entry4.compartment_name}/${entry5.compartment_name}"
  enable_delete = lookup(entry6, "enable_delete", false) }]]]]]], []))
}




resource "oci_identity_compartment" "compartment_level_1" {
  for_each       = { for entry in local.compartment_level_1 : entry.compartment_name => entry }
  compartment_id = var.root_compartment_id
  description    = each.value["description"]
  name           = each.value["compartment_name"]
  defined_tags   = each.value["defined_tags"]
  freeform_tags  = each.value["freeform_tags"]
  enable_delete  = each.value["enable_delete"]
}

resource "oci_identity_compartment" "compartment_level_2" {
  for_each       = { for entry in local.compartment_level_2 : "${entry.parent_compartment}/${entry.compartment_name}" => entry }
  compartment_id = oci_identity_compartment.compartment_level_1[each.value["parent_compartment"]].id
  description    = each.value["description"]
  name           = each.value["compartment_name"]
  defined_tags   = each.value["defined_tags"]
  freeform_tags  = each.value["freeform_tags"]
  enable_delete  = each.value["enable_delete"]
}

resource "oci_identity_compartment" "compartment_level_3" {
  for_each       = { for entry in local.compartment_level_3 : "${entry.parent_compartment}/${entry.compartment_name}" => entry }
  compartment_id = oci_identity_compartment.compartment_level_2[each.value["parent_compartment"]].id
  description    = each.value["description"]
  name           = each.value["compartment_name"]
  defined_tags   = each.value["defined_tags"]
  freeform_tags  = each.value["freeform_tags"]
  enable_delete  = each.value["enable_delete"]
}

resource "oci_identity_compartment" "compartment_level_4" {
  for_each       = { for entry in local.compartment_level_4 : "${entry.parent_compartment}/${entry.compartment_name}" => entry }
  compartment_id = oci_identity_compartment.compartment_level_3[each.value["parent_compartment"]].id
  description    = each.value["description"]
  name           = each.value["compartment_name"]
  defined_tags   = each.value["defined_tags"]
  freeform_tags  = each.value["freeform_tags"]
  enable_delete  = each.value["enable_delete"]
}

resource "oci_identity_compartment" "compartment_level_5" {
  for_each       = { for entry in local.compartment_level_5 : "${entry.parent_compartment}/${entry.compartment_name}" => entry }
  compartment_id = oci_identity_compartment.compartment_level_4[each.value["parent_compartment"]].id
  description    = each.value["description"]
  name           = each.value["compartment_name"]
  defined_tags   = each.value["defined_tags"]
  freeform_tags  = each.value["freeform_tags"]
  enable_delete  = each.value["enable_delete"]
}

resource "oci_identity_compartment" "compartment_level_6" {
  for_each       = { for entry in local.compartment_level_6 : "${entry.parent_compartment}/${entry.compartment_name}" => entry }
  compartment_id = oci_identity_compartment.compartment_level_5[each.value["parent_compartment"]].id
  description    = each.value["description"]
  name           = each.value["compartment_name"]
  defined_tags   = each.value["defined_tags"]
  freeform_tags  = each.value["freeform_tags"]
  enable_delete  = each.value["enable_delete"]
}
