
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and the versioning try follows the [Semantic Versioning 2.0.0](https://semver.org/) specification.

Given a version number MAJOR.MINOR.PATCH:

- MAJOR version when making incompatible API changes,
- MINOR version when adding functionality in a backwards compatible manner,
- PATCH version when making backwards compatible bug fixes.

## [2.1.0] 2020-12-15

### Added

- more current README.md for the example folder. Also add a sample apply output.

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

- updates modules and examples to not use deprecated interpolation syntax anymore,
- updates examples to show how to use the 2.x.x features of this module.

## [2.0.1] 2020-12-14

### Added

- repo maintenance: starts this CHANGELOG.md
- updates README.md prerequisites section with the required Terraform and Terraform Provider versions

### Changed

- repo maintenance: updates Copyright to 2020
- repo maintenance: .gitignore and .gitattributes adujsted files for cleaner repo

### Removed

- Resource "watermark" with freeform tags - may be reintroduced later in a more flexible manner
