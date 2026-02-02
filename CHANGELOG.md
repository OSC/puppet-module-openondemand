# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v8.0.0](https://github.com/osc/puppet-module-openondemand/tree/v8.0.0) (2026-02-02)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v7.3.0...v8.0.0)

### Changed

- Support OnDemand 4.1 [\#183](https://github.com/OSC/puppet-module-openondemand/pull/183) ([treydock](https://github.com/treydock))

## [v7.3.0](https://github.com/osc/puppet-module-openondemand/tree/v7.3.0) (2026-01-16)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v7.2.0...v7.3.0)

### Added

- Allow vnc\_args for vnc batch connect configuration [\#184](https://github.com/OSC/puppet-module-openondemand/pull/184) ([treydock](https://github.com/treydock))

## [v7.2.0](https://github.com/osc/puppet-module-openondemand/tree/v7.2.0) (2026-01-12)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v7.1.1...v7.2.0)

### Added

- add http proxy for vcsrepo as git\_proxy parameter [\#180](https://github.com/OSC/puppet-module-openondemand/pull/180) ([elawrence42](https://github.com/elawrence42))

## [v7.1.1](https://github.com/osc/puppet-module-openondemand/tree/v7.1.1) (2025-06-12)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v7.1.0...v7.1.1)

### Fixed

- Do not manage maintenance.enable if undef [\#174](https://github.com/OSC/puppet-module-openondemand/pull/174) ([treydock](https://github.com/treydock))

## [v7.1.0](https://github.com/osc/puppet-module-openondemand/tree/v7.1.0) (2025-01-21)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v7.0.0...v7.1.0)

### Added

- Added configuration to enable/disable maintenance with Puppet [\#170](https://github.com/OSC/puppet-module-openondemand/pull/170) ([abujeda](https://github.com/abujeda))

## [v7.0.0](https://github.com/osc/puppet-module-openondemand/tree/v7.0.0) (2025-01-09)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v6.1.0...v7.0.0)

### Changed

- Support OnDemand 4.0 [\#169](https://github.com/OSC/puppet-module-openondemand/pull/169) ([treydock](https://github.com/treydock))

## [v6.1.0](https://github.com/osc/puppet-module-openondemand/tree/v6.1.0) (2024-12-11)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v6.0.0...v6.1.0)

### Added

- Add oidc\_crypto\_passphrase parameter [\#168](https://github.com/OSC/puppet-module-openondemand/pull/168) ([treydock](https://github.com/treydock))

## [v6.0.0](https://github.com/osc/puppet-module-openondemand/tree/v6.0.0) (2024-10-16)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v5.2.0...v6.0.0)

### Changed

- Require stdlib \>= 9.x [\#165](https://github.com/OSC/puppet-module-openondemand/pull/165) ([treydock](https://github.com/treydock))

## [v5.2.0](https://github.com/osc/puppet-module-openondemand/tree/v5.2.0) (2024-10-16)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v5.1.0...v5.2.0)

### Added

- Support Ubuntu 24.04 [\#163](https://github.com/OSC/puppet-module-openondemand/pull/163) ([treydock](https://github.com/treydock))
- Remove EL7 support [\#161](https://github.com/OSC/puppet-module-openondemand/pull/161) ([treydock](https://github.com/treydock))

## [v5.1.0](https://github.com/osc/puppet-module-openondemand/tree/v5.1.0) (2024-09-06)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v5.0.1...v5.1.0)

### Added

- Added support to configure the GPG check for the OnDemand repo [\#159](https://github.com/OSC/puppet-module-openondemand/pull/159) ([abujeda](https://github.com/abujeda))

### Fixed

- Don't wrap yaml lines for confs [\#160](https://github.com/OSC/puppet-module-openondemand/pull/160) ([mattmix](https://github.com/mattmix))

## [v5.0.1](https://github.com/osc/puppet-module-openondemand/tree/v5.0.1) (2024-04-17)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v5.0.0...v5.0.1)

### Fixed

- Allow undef for logout\_uri and logout\_redirect [\#157](https://github.com/OSC/puppet-module-openondemand/pull/157) ([abujeda](https://github.com/abujeda))

## [v5.0.0](https://github.com/osc/puppet-module-openondemand/tree/v5.0.0) (2024-02-13)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v4.5.0...v5.0.0)

### Changed

- Support OnDemand 3.1 [\#154](https://github.com/OSC/puppet-module-openondemand/pull/154) ([treydock](https://github.com/treydock))

## [v4.5.0](https://github.com/osc/puppet-module-openondemand/tree/v4.5.0) (2024-01-25)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v4.4.1...v4.5.0)

### Added

- Added support for files to configure cluster definitions [\#156](https://github.com/OSC/puppet-module-openondemand/pull/156) ([abujeda](https://github.com/abujeda))

## [v4.4.1](https://github.com/osc/puppet-module-openondemand/tree/v4.4.1) (2024-01-25)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v4.4.0...v4.4.1)

### Fixed

- Fix Apache user for Ubuntu and Debian [\#155](https://github.com/OSC/puppet-module-openondemand/pull/155) ([treydock](https://github.com/treydock))

## [v4.4.0](https://github.com/osc/puppet-module-openondemand/tree/v4.4.0) (2024-01-21)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v4.3.1...v4.4.0)

### Added

- Added support to add module files into the OnDemand public folder [\#151](https://github.com/OSC/puppet-module-openondemand/pull/151) ([abujeda](https://github.com/abujeda))

## [v4.3.1](https://github.com/osc/puppet-module-openondemand/tree/v4.3.1) (2023-12-01)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v4.3.0...v4.3.1)

### Fixed

- document multi-line strings [\#146](https://github.com/OSC/puppet-module-openondemand/pull/146) ([johrstrom](https://github.com/johrstrom))

## [v4.3.0](https://github.com/osc/puppet-module-openondemand/tree/v4.3.0) (2023-11-27)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v4.2.1...v4.3.0)

### Added

- Support new module dependencies [\#144](https://github.com/OSC/puppet-module-openondemand/pull/144) ([treydock](https://github.com/treydock))

### Fixed

- Removed Nginx stage ondemand title default value [\#142](https://github.com/OSC/puppet-module-openondemand/pull/142) ([abujeda](https://github.com/abujeda))

## [v4.2.1](https://github.com/osc/puppet-module-openondemand/tree/v4.2.1) (2023-10-06)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v4.2.0...v4.2.1)

### Fixed

- Fix nginx\_stage task to work on Python 3 [\#138](https://github.com/OSC/puppet-module-openondemand/pull/138) ([treydock](https://github.com/treydock))

## [v4.2.0](https://github.com/osc/puppet-module-openondemand/tree/v4.2.0) (2023-09-19)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v4.1.0...v4.2.0)

### Added

- Refactor how cluster YAML is generated to stop using ERB template [\#137](https://github.com/OSC/puppet-module-openondemand/pull/137) ([treydock](https://github.com/treydock))

## [v4.1.0](https://github.com/osc/puppet-module-openondemand/tree/v4.1.0) (2023-06-16)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v4.0.0...v4.1.0)

### Added

- Support newer stdlib and systemd modules [\#131](https://github.com/OSC/puppet-module-openondemand/pull/131) ([treydock](https://github.com/treydock))
- Allow apps to be installed from source parameter [\#130](https://github.com/OSC/puppet-module-openondemand/pull/130) ([treydock](https://github.com/treydock))
- Document adding support ticket configuration [\#126](https://github.com/OSC/puppet-module-openondemand/pull/126) ([treydock](https://github.com/treydock))

### Fixed

- Set mode for managed directories [\#132](https://github.com/OSC/puppet-module-openondemand/pull/132) ([treydock](https://github.com/treydock))

## [v4.0.0](https://github.com/osc/puppet-module-openondemand/tree/v4.0.0) (2023-05-04)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v3.0.1...v4.0.0)

### Changed

- Support Puppet 8, Drop Puppet 6 support, update dependencies [\#125](https://github.com/OSC/puppet-module-openondemand/pull/125) ([treydock](https://github.com/treydock))

### Added

- Adding proxy for ondemand repo. [\#124](https://github.com/OSC/puppet-module-openondemand/pull/124) ([pedmon](https://github.com/pedmon))

## [v3.0.1](https://github.com/osc/puppet-module-openondemand/tree/v3.0.1) (2023-04-14)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v3.0.0...v3.0.1)

### Fixed

- Fixed boolean check for boolean parameter [\#121](https://github.com/OSC/puppet-module-openondemand/pull/121) ([abujeda](https://github.com/abujeda))

## [v3.0.0](https://github.com/osc/puppet-module-openondemand/tree/v3.0.0) (2023-04-03)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.15.0...v3.0.0)

### Changed

- Switch to use OnDemand 3.0 [\#122](https://github.com/OSC/puppet-module-openondemand/pull/122) ([treydock](https://github.com/treydock))

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

## [v2.8.2](https://github.com/osc/puppet-module-openondemand/tree/v2.8.2) (2021-10-14)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.8.1...v2.8.2)

## [v2.8.1](https://github.com/osc/puppet-module-openondemand/tree/v2.8.1) (2021-10-14)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.8.0...v2.8.1)

## [v2.8.0](https://github.com/osc/puppet-module-openondemand/tree/v2.8.0) (2021-09-01)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.7.0...v2.8.0)

## [v2.7.0](https://github.com/osc/puppet-module-openondemand/tree/v2.7.0) (2021-08-09)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.6.0...v2.7.0)

## [v2.6.0](https://github.com/osc/puppet-module-openondemand/tree/v2.6.0) (2021-08-03)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.5.0...v2.6.0)

## [v2.5.0](https://github.com/osc/puppet-module-openondemand/tree/v2.5.0) (2021-07-29)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.4.1...v2.5.0)

## [v2.4.1](https://github.com/osc/puppet-module-openondemand/tree/v2.4.1) (2021-07-21)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.4.0...v2.4.1)

## [v2.4.0](https://github.com/osc/puppet-module-openondemand/tree/v2.4.0) (2021-07-14)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.3.0...v2.4.0)

## [v2.3.0](https://github.com/osc/puppet-module-openondemand/tree/v2.3.0) (2021-06-15)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.2.0...v2.3.0)

## [v2.2.0](https://github.com/osc/puppet-module-openondemand/tree/v2.2.0) (2021-06-03)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.1.0...v2.2.0)

## [v2.1.0](https://github.com/osc/puppet-module-openondemand/tree/v2.1.0) (2021-05-26)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v2.0.0...v2.1.0)

## [v2.0.0](https://github.com/osc/puppet-module-openondemand/tree/v2.0.0) (2021-05-19)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v1.5.0...v2.0.0)



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
