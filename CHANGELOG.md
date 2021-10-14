# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

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

## [v1.5.0](https://github.com/osc/puppet-module-openondemand/tree/v1.5.0) (2020-11-04)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v1.4.0...v1.5.0)

### Added

- Add parameters around ood-portal-generator security settings [\#43](https://github.com/OSC/puppet-module-openondemand/pull/43) ([treydock](https://github.com/treydock))

## [v1.4.0](https://github.com/osc/puppet-module-openondemand/tree/v1.4.0) (2020-10-08)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v1.3.0...v1.4.0)

### Added

- Add nginx\_stage\_min\_uid parameter [\#42](https://github.com/OSC/puppet-module-openondemand/pull/42) ([hcartiaux](https://github.com/hcartiaux))

## [v1.3.0](https://github.com/osc/puppet-module-openondemand/tree/v1.3.0) (2020-09-30)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v1.2.0...v1.3.0)

### Added

- XDMoD Support [\#41](https://github.com/OSC/puppet-module-openondemand/pull/41) ([treydock](https://github.com/treydock))

## [v1.2.0](https://github.com/osc/puppet-module-openondemand/tree/v1.2.0) (2020-09-18)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v1.1.1...v1.2.0)

### Added

- Add repo\_priority parameter [\#40](https://github.com/OSC/puppet-module-openondemand/pull/40) ([treydock](https://github.com/treydock))

## [v1.1.1](https://github.com/osc/puppet-module-openondemand/tree/v1.1.1) (2020-09-17)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v1.1.0...v1.1.1)

### Fixed

- Ensure grafana configs are shown when using SLURM [\#39](https://github.com/OSC/puppet-module-openondemand/pull/39) ([treydock](https://github.com/treydock))

## [v1.1.0](https://github.com/osc/puppet-module-openondemand/tree/v1.1.0) (2020-09-15)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v1.0.0...v1.1.0)

### Added

- Support Linux Host Adapter [\#38](https://github.com/OSC/puppet-module-openondemand/pull/38) ([treydock](https://github.com/treydock))

## [v1.0.0](https://github.com/osc/puppet-module-openondemand/tree/v1.0.0) (2020-08-24)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.14.0...v1.0.0)

### Changed

- BREAKING: READ COMMENTS - Major changes to support OnDemand 1.8 [\#35](https://github.com/OSC/puppet-module-openondemand/pull/35) ([treydock](https://github.com/treydock))

## [v0.14.0](https://github.com/osc/puppet-module-openondemand/tree/v0.14.0) (2020-08-03)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.13.0...v0.14.0)

### Added

- Make nginx\_clean cron schedule configurable [\#37](https://github.com/OSC/puppet-module-openondemand/pull/37) ([danifr](https://github.com/danifr))

## [v0.13.0](https://github.com/osc/puppet-module-openondemand/tree/v0.13.0) (2020-07-29)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.12.0...v0.13.0)

### UNCATEGORIZED PRS; GO LABEL THEM

- Add the ability to load announcements from the config\_repo [\#36](https://github.com/OSC/puppet-module-openondemand/pull/36) ([mattmix](https://github.com/mattmix))

## [v0.12.0](https://github.com/osc/puppet-module-openondemand/tree/v0.12.0) (2020-06-04)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.11.0...v0.12.0)

### Changed

- BREAKING: Switch to using puppet-rhsm for RHEL SCL repo management [\#33](https://github.com/OSC/puppet-module-openondemand/pull/33) ([treydock](https://github.com/treydock))

## [v0.11.0](https://github.com/osc/puppet-module-openondemand/tree/v0.11.0) (2020-06-03)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.10.0...v0.11.0)

### Added

- Add manage\_logrotate parameter [\#32](https://github.com/OSC/puppet-module-openondemand/pull/32) ([treydock](https://github.com/treydock))

## [v0.10.0](https://github.com/osc/puppet-module-openondemand/tree/v0.10.0) (2020-06-02)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.9.3...v0.10.0)

### Added

- Add support for mod\_auth\_cas [\#31](https://github.com/OSC/puppet-module-openondemand/pull/31) ([ghjs](https://github.com/ghjs))

## [v0.9.3](https://github.com/osc/puppet-module-openondemand/tree/v0.9.3) (2020-05-18)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.9.2...v0.9.3)

### Fixed

- Fix OIDC URLs when SSL not configured [\#29](https://github.com/OSC/puppet-module-openondemand/pull/29) ([danifr](https://github.com/danifr))

## [v0.9.2](https://github.com/osc/puppet-module-openondemand/tree/v0.9.2) (2020-05-12)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.9.1...v0.9.2)

### Fixed

- Make sure osmajor does not contain minor release version [\#27](https://github.com/OSC/puppet-module-openondemand/pull/27) ([danifr](https://github.com/danifr))

## [v0.9.1](https://github.com/osc/puppet-module-openondemand/tree/v0.9.1) (2020-04-17)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.9.0...v0.9.1)

### Fixed

- Fix typo when generating grafana configs [\#25](https://github.com/OSC/puppet-module-openondemand/pull/25) ([treydock](https://github.com/treydock))

## [v0.9.0](https://github.com/osc/puppet-module-openondemand/tree/v0.9.0) (2020-03-04)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.8.0...v0.9.0)

### Added

- Support changing maintenance mode HTML [\#24](https://github.com/OSC/puppet-module-openondemand/pull/24) ([treydock](https://github.com/treydock))

## [v0.8.0](https://github.com/osc/puppet-module-openondemand/tree/v0.8.0) (2020-03-03)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.7.0...v0.8.0)

### Added

- Remove ood-portal.conf unit dropin file [\#23](https://github.com/OSC/puppet-module-openondemand/pull/23) ([treydock](https://github.com/treydock))

## [v0.7.0](https://github.com/osc/puppet-module-openondemand/tree/v0.7.0) (2020-03-03)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.6.0...v0.7.0)

### Added

- Add maintenance task [\#22](https://github.com/OSC/puppet-module-openondemand/pull/22) ([treydock](https://github.com/treydock))

## [v0.6.0](https://github.com/osc/puppet-module-openondemand/tree/v0.6.0) (2020-03-02)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.5.0...v0.6.0)

### Added

- Support grafana in cluster configs [\#21](https://github.com/OSC/puppet-module-openondemand/pull/21) ([treydock](https://github.com/treydock))
- Add use\_rewrites, use\_maintenance and maintenance\_ip\_whitelist parameters [\#20](https://github.com/OSC/puppet-module-openondemand/pull/20) ([treydock](https://github.com/treydock))

## [v0.5.0](https://github.com/osc/puppet-module-openondemand/tree/v0.5.0) (2020-02-11)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.4.0...v0.5.0)

### Added

- Better configuration of mod\_auth\_openidc [\#18](https://github.com/OSC/puppet-module-openondemand/pull/18) ([treydock](https://github.com/treydock))

## [v0.4.0](https://github.com/osc/puppet-module-openondemand/tree/v0.4.0) (2020-01-20)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.3.0...v0.4.0)

### Added

- Add oidc\_extra\_configs parameter [\#17](https://github.com/OSC/puppet-module-openondemand/pull/17) ([treydock](https://github.com/treydock))

## [v0.3.0](https://github.com/osc/puppet-module-openondemand/tree/v0.3.0) (2019-11-14)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.2.0...v0.3.0)

### Added

- Add nginx\_stage\_pun\_custom\_env parameter [\#15](https://github.com/OSC/puppet-module-openondemand/pull/15) ([treydock](https://github.com/treydock))

### Fixed

- Fix EL8 support [\#16](https://github.com/OSC/puppet-module-openondemand/pull/16) ([treydock](https://github.com/treydock))

## [v0.2.0](https://github.com/osc/puppet-module-openondemand/tree/v0.2.0) (2019-10-17)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.1.1...v0.2.0)

### Added

- Changes to support 1.7 [\#14](https://github.com/OSC/puppet-module-openondemand/pull/14) ([treydock](https://github.com/treydock))

## [v0.1.1](https://github.com/osc/puppet-module-openondemand/tree/v0.1.1) (2019-09-19)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/v0.1.0...v0.1.1)

### Fixed

- Fix README links [\#13](https://github.com/OSC/puppet-module-openondemand/pull/13) ([treydock](https://github.com/treydock))

## [v0.1.0](https://github.com/osc/puppet-module-openondemand/tree/v0.1.0) (2019-09-19)

[Full Changelog](https://github.com/osc/puppet-module-openondemand/compare/6a14d62901baf820ece3c8c38e29ee3494b30822...v0.1.0)

### Changed

- Make cluster url optional and remove default [\#7](https://github.com/OSC/puppet-module-openondemand/pull/7) ([treydock](https://github.com/treydock))
- Remove use of mod\_php [\#4](https://github.com/OSC/puppet-module-openondemand/pull/4) ([treydock](https://github.com/treydock))
- Refactor ondemand::cluster to better match v2 configs [\#3](https://github.com/OSC/puppet-module-openondemand/pull/3) ([treydock](https://github.com/treydock))
- Major overhaul [\#2](https://github.com/OSC/puppet-module-openondemand/pull/2) ([treydock](https://github.com/treydock))

### Added

- Misc improvements [\#12](https://github.com/OSC/puppet-module-openondemand/pull/12) ([treydock](https://github.com/treydock))
- Add CentOS 7 SCL repo to fix issues with EOL SCLs being removed from CentOS 7.7 [\#11](https://github.com/OSC/puppet-module-openondemand/pull/11) ([treydock](https://github.com/treydock))
- Add README contents [\#10](https://github.com/OSC/puppet-module-openondemand/pull/10) ([treydock](https://github.com/treydock))
- Improvements to simplify module [\#6](https://github.com/OSC/puppet-module-openondemand/pull/6) ([treydock](https://github.com/treydock))
- Improve docs and improve app configs parameters [\#5](https://github.com/OSC/puppet-module-openondemand/pull/5) ([treydock](https://github.com/treydock))
- Convert to PDK module and improvements to pass tests [\#1](https://github.com/OSC/puppet-module-openondemand/pull/1) ([treydock](https://github.com/treydock))

### Fixed

- Only add LDAP Apache modules if auth\_type is 'ldap' [\#9](https://github.com/OSC/puppet-module-openondemand/pull/9) ([treydock](https://github.com/treydock))
- Fix extra newline issue in cluster config [\#8](https://github.com/OSC/puppet-module-openondemand/pull/8) ([treydock](https://github.com/treydock))



\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
