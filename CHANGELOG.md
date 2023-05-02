# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v3.0.1](https://github.com/osc/puppet-module-openondemand/tree/v3.0.1) (2023-04-14)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v3.0.0...v3.0.1)

### Fixed

- Fixed boolean check for boolean parameter [\#121](https://github.com/OSC/puppet-module-openondemand/pull/121) ([abujeda](https://github.com/abujeda))

## [v3.0.0](https://github.com/osc/puppet-module-openondemand/tree/v3.0.0) (2023-04-03)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.15.0...v3.0.0)

### Changed

- Switch to use OnDemand 3.0 [\#122](https://github.com/OSC/puppet-module-openondemand/pull/122) ([treydock](https://github.com/treydock))
- OnDemand 3.0 support [\#70](https://github.com/OSC/puppet-module-openondemand/pull/70) ([treydock](https://github.com/treydock))

## [v2.15.0](https://github.com/osc/puppet-module-openondemand/tree/v2.15.0) (2022-11-15)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.14.0...v2.15.0)

### Added

- Use NodeJS 14 [\#115](https://github.com/OSC/puppet-module-openondemand/pull/115) ([treydock](https://github.com/treydock))

## [v2.14.0](https://github.com/osc/puppet-module-openondemand/tree/v2.14.0) (2022-08-12)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.13.0...v2.14.0)

### Added

- Add dex\_uri parameter [\#109](https://github.com/OSC/puppet-module-openondemand/pull/109) ([treydock](https://github.com/treydock))
- Support Ubuntu 18.04 and 20.04 [\#103](https://github.com/OSC/puppet-module-openondemand/pull/103) ([treydock](https://github.com/treydock))

## [v2.13.0](https://github.com/osc/puppet-module-openondemand/tree/v2.13.0) (2022-06-10)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.12.1...v2.13.0)

### Added

- Add the ability to configure set\_host for clusters [\#98](https://github.com/OSC/puppet-module-openondemand/pull/98) ([mattmix](https://github.com/mattmix))

## [v2.12.1](https://github.com/osc/puppet-module-openondemand/tree/v2.12.1) (2022-06-08)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.12.0...v2.12.1)

### Fixed

- Allow arbitrary string for auth\_type [\#97](https://github.com/OSC/puppet-module-openondemand/pull/97) ([mattmix](https://github.com/mattmix))

## [v2.12.0](https://github.com/osc/puppet-module-openondemand/tree/v2.12.0) (2022-05-20)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.11.0...v2.12.0)

### Added

- Avoid latest repo by default, not a stable repo [\#91](https://github.com/OSC/puppet-module-openondemand/pull/91) ([treydock](https://github.com/treydock))
- Replace CentOS 8 with Rocky 8 and PDK sync [\#87](https://github.com/OSC/puppet-module-openondemand/pull/87) ([treydock](https://github.com/treydock))

## [v2.11.0](https://github.com/osc/puppet-module-openondemand/tree/v2.11.0) (2022-05-06)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.10.0...v2.11.0)

### Added

- Support installing apps with git [\#85](https://github.com/OSC/puppet-module-openondemand/pull/85) ([treydock](https://github.com/treydock))

## [v2.10.0](https://github.com/osc/puppet-module-openondemand/tree/v2.10.0) (2022-04-11)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.9.0...v2.10.0)

### Added

- Allow setting cluster YAML permissions [\#82](https://github.com/OSC/puppet-module-openondemand/pull/82) ([treydock](https://github.com/treydock))

### Fixed

- Actually use new owner/group/mode cluster parameters [\#83](https://github.com/OSC/puppet-module-openondemand/pull/83) ([treydock](https://github.com/treydock))

## [v2.9.0](https://github.com/osc/puppet-module-openondemand/tree/v2.9.0) (2022-03-04)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.8.2...v2.9.0)

### Added

- Add repo\_exclude parameter [\#81](https://github.com/OSC/puppet-module-openondemand/pull/81) ([treydock](https://github.com/treydock))

### Fixed

- Use 2.0 repo for acceptance tests [\#80](https://github.com/OSC/puppet-module-openondemand/pull/80) ([treydock](https://github.com/treydock))
- Fix when ood-portal-generator is triggered [\#79](https://github.com/OSC/puppet-module-openondemand/pull/79) ([treydock](https://github.com/treydock))
- Ensure that validation errors for Apache config will not persist [\#78](https://github.com/OSC/puppet-module-openondemand/pull/78) ([treydock](https://github.com/treydock))
- Skip nigntly tests until feature/ondemand-2.1 merged [\#74](https://github.com/OSC/puppet-module-openondemand/pull/74) ([treydock](https://github.com/treydock))

## [v2.8.2](https://github.com/osc/puppet-module-openondemand/tree/v2.8.2) (2021-10-14)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.8.1...v2.8.2)

### Fixed

- Further fix how custom configs are defined \(with tests\) [\#73](https://github.com/OSC/puppet-module-openondemand/pull/73) ([treydock](https://github.com/treydock))

## [v2.8.1](https://github.com/osc/puppet-module-openondemand/tree/v2.8.1) (2021-10-14)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.8.0...v2.8.1)

### Fixed

- Fix how custom cluster configs are defined [\#72](https://github.com/OSC/puppet-module-openondemand/pull/72) ([treydock](https://github.com/treydock))

## [v2.8.0](https://github.com/osc/puppet-module-openondemand/tree/v2.8.0) (2021-09-01)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.7.0...v2.8.0)

### Added

- Support nightly repos [\#66](https://github.com/OSC/puppet-module-openondemand/pull/66) ([treydock](https://github.com/treydock))

## [v2.7.0](https://github.com/osc/puppet-module-openondemand/tree/v2.7.0) (2021-08-09)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.6.0...v2.7.0)

### Added

- Add nginx\_stage\_nginx\_file\_upload\_max and nginx\_stage\_configs [\#65](https://github.com/OSC/puppet-module-openondemand/pull/65) ([treydock](https://github.com/treydock))

## [v2.6.0](https://github.com/osc/puppet-module-openondemand/tree/v2.6.0) (2021-08-03)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.5.0...v2.6.0)

### Added

- Support cluster custom\_config [\#63](https://github.com/OSC/puppet-module-openondemand/pull/63) ([treydock](https://github.com/treydock))

## [v2.5.0](https://github.com/osc/puppet-module-openondemand/tree/v2.5.0) (2021-07-29)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.4.1...v2.5.0)

### Added

- Support K8 auto\_supplemental\_groups [\#62](https://github.com/OSC/puppet-module-openondemand/pull/62) ([treydock](https://github.com/treydock))

## [v2.4.1](https://github.com/osc/puppet-module-openondemand/tree/v2.4.1) (2021-07-21)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.4.0...v2.4.1)

### Fixed

- Ensure sudo rpmnew and rpmsave are removed in idempotent fasion [\#61](https://github.com/OSC/puppet-module-openondemand/pull/61) ([treydock](https://github.com/treydock))

## [v2.4.0](https://github.com/osc/puppet-module-openondemand/tree/v2.4.0) (2021-07-14)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.3.0...v2.4.0)

### Added

- Ensure kubectl sudo commands are not logged [\#60](https://github.com/OSC/puppet-module-openondemand/pull/60) ([treydock](https://github.com/treydock))

## [v2.3.0](https://github.com/osc/puppet-module-openondemand/tree/v2.3.0) (2021-06-15)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.2.0...v2.3.0)

### Added

- Support nginx\_stage passenger\_pool\_idle\_time and passenger\_options [\#58](https://github.com/OSC/puppet-module-openondemand/pull/58) ([treydock](https://github.com/treydock))

## [v2.2.0](https://github.com/osc/puppet-module-openondemand/tree/v2.2.0) (2021-06-03)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.1.0...v2.2.0)

### Added

- Support pinned apps, dashboard layout and ondemand.d configuration files [\#55](https://github.com/OSC/puppet-module-openondemand/pull/55) ([treydock](https://github.com/treydock))

## [v2.1.0](https://github.com/osc/puppet-module-openondemand/tree/v2.1.0) (2021-05-26)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.0.0...v2.1.0)

### Added

- Better cluster batch\_connect support, add ssh\_allow support [\#53](https://github.com/OSC/puppet-module-openondemand/pull/53) ([treydock](https://github.com/treydock))

## [v2.0.0](https://github.com/osc/puppet-module-openondemand/tree/v2.0.0) (2021-05-19)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v1.5.0...v2.0.0)

### Changed

- Drop Puppet 5 support, update dependency version ranges [\#50](https://github.com/OSC/puppet-module-openondemand/pull/50) ([treydock](https://github.com/treydock))
- Support OnDemand 2.0 and Puppet 7 [\#46](https://github.com/OSC/puppet-module-openondemand/pull/46) ([treydock](https://github.com/treydock))

### Added

- Depend on EPEL for OnDemand 2.0 on EL7 [\#52](https://github.com/OSC/puppet-module-openondemand/pull/52) ([treydock](https://github.com/treydock))
- Support hook.env [\#51](https://github.com/OSC/puppet-module-openondemand/pull/51) ([treydock](https://github.com/treydock))
- Add tasks [\#48](https://github.com/OSC/puppet-module-openondemand/pull/48) ([treydock](https://github.com/treydock))
- Add support for Kubernetes cluster definition [\#44](https://github.com/OSC/puppet-module-openondemand/pull/44) ([treydock](https://github.com/treydock))

### Fixed

- No longer set rh-ruby27 in Apache SCL, no longer needed [\#49](https://github.com/OSC/puppet-module-openondemand/pull/49) ([treydock](https://github.com/treydock))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
