
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and the versioning try follows the [Semantic Versioning 2.0.0](https://semver.org/) specification.

Given a version number MAJOR.MINOR.PATCH:

- MAJOR version when making incompatible API changes,
- MINOR version when adding functionality in a backwards compatible manner,
- PATCH version when making backwards compatible bug fixes.

## [2.1.3] 2021-01-19

### Fixed

- update documentation links to use absolute paths (Terraform Registry do not support relative paths)
- update image link

## [2.1.2] 2021-01-05

### Added

- clarify documentation regarding provider configuration requirements for OCI IAM resources (you must you home region)

## [2.1.1] 2020-12-22

### Added

- variables: type constraints defined for all variables,
- variables: default value is `null` if there is no other advisable value,
- ouputs: user_description output for iam-user module,
- terraform and OCI terraform provider version pinning block,
- examples: add a README

### Changed

Documentation update:

- update README files to use relative links for content coming from this repo
- Update oci provider URL to registry.terraform.io
- update the prerequisites and usage section for each submodule
- add a column with default value for each variable

Resources:

- `count` tests with true/false for boolean variables,
- `count` tests with null or variable length for arrays.

### Fixed

- iam-user: email can be empty if value is set to `null`

## [2.1.0] 2020-12-15

### Added

- More current README.md for the example folder. Also add a sample apply output.

#### Module - iam-compartment, iam-group, iam-dynamic-group

- More complete outputs. oci-compartment now also expose the parent compartment ocid,
- add a new combined output name -> ocid

### Changed

#### Module - iam-compartment

- compartment_name and compartment_description are now mandatory (default value is null),
- compartment_id is now optional: if the parent compartment ID is not specified, the compartment is created at the root level of the tenancy

#### Module - iam-user

- name and description are now mandatory (default value is null)

### Fixed

- update modules and examples to not use deprecated interpolation syntax anymore,
- update examples to show how to use the 2.x.x features of this module.

## [2.0.1] 2020-12-14

### Added

- repo maintenance: starts this CHANGELOG.md
- update README.md prerequisites section with the required Terraform and Terraform Provider versions

### Changed

- repo maintenance: updates Copyright to 2020
- repo maintenance: .gitignore and .gitattributes adjusted files for cleaner repo

### Removed

- Resource "watermark" with freeform tags - may be reintroduced later in a more flexible manner
