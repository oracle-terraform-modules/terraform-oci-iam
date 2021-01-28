
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and the versioning follows the [Semantic Versioning 2.0.0](https://semver.org/) specification.

Given a version number MAJOR.MINOR.PATCH:

- MAJOR version when making incompatible API changes,
- MINOR version when adding functionality in a backwards compatible manner,
- PATCH version when making backwards compatible bug fixes.

## [2.0.1] - 2021-02-09

### Fixed

- missing description for outputs
- Remove uncorrect module version from examples (Issue #18)
- typo in examples/main.tf for iam_dynamic_group module source path (Issue #19)
- explanation of `enable_delete` argument behaviour in modules/iam-compartment documentation (Issue #20)

### Changed

- no more version pinning in examples to keep documentation current, but add a note on how to do it for production code.

## [2.0.0] - 2021-01-27

### Added

#### New features

- delete a compartment
- create a sub-compartment
- create a list of oci users
- set email of oci user

#### Documentation

- CHANGELOG following [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) format
- CONTRIBUTING guide
- prerequisites section with the required Terraform and Terraform Provider versions
- clarify provider configuration requirements for OCI IAM resources (you must your home region)
- README for /examples
- examples on how to use the new features of this module

### Changed

#### Resources

- `count` tests with true/false for boolean variables,
- `count` tests with null or variable length for arrays.

#### modules/*

- terraform and OCI terraform provider version pinning block : Terraform 0.12 and OCI Provider 3.27 or greater
- new outputs for each sub-modules
- typed variables
- variables default value is `null` if there is no better advisable value

#### modules/iam-compartment

- compartment_name and compartment_description are now mandatory (default value is null),
- compartment_id is now optional: if the parent compartment ID is not specified, the compartment is created at the root level of the tenancy

#### modules/iam-user

- name and description are now mandatory (default value is null)

### Fixed

- Issues: #11 #12 #16
- no more deprecated interpolation syntax in modules and examples
