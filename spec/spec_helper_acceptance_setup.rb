# frozen_string_literal: true

install_module_from_forge('puppetlabs-concat', '>= 9.0.0 < 10.0.0')
install_module_from_forge('puppet-augeasproviders_core', '>= 3.0.0 < 4.0.0')
on hosts, 'puppet config set strict warning'
