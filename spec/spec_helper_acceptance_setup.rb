# frozen_string_literal: true

install_module_from_forge('puppetlabs-concat', '>= 9.0.0 < 10.0.0')
install_module_from_forge('puppet-augeasproviders_core', '>= 3.0.0 < 4.0.0')
on hosts, 'puppet config set strict warning'

def supported_releases
  osname = fact('os.name')
  osfamily = fact('os.family')
  osmajor = fact('os.release.major')
  if ['Amazon-2023', 'Debian-12'].include?("#{osname}-#{osmajor}")
    ['3.1']
  elsif "#{osfamily}-#{osmajor}" == 'RedHat-7'
    ['3.0']
  else
    ['3.0', '3.1']
  end
end
