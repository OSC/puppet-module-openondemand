# @summary Manage Open OnDemand configuration file in /etc/ood/config/ondemand.d
#
# @param source
#   The source of the configuration file
# @param content
#   The content template of the configuration file
# @param content_template
#   The template to define content
# @param data
#   A hash of data to convert to YAML that defines the configuration file contents
# @param template
#   If true, the file will have .yml.erb extension, otherwise the extension is .yml
# @param filename
#   Override the default filename for the configuration file
#
define openondemand::conf (
  Optional[String] $source = undef,
  Optional[String] $content = undef,
  Optional[String] $content_template = undef,
  Optional[Hash] $data = undef,
  Boolean $template = false,
  Optional[String] $filename = undef,
) {
  if ! $source and ! $content and ! $content_template and ! $data {
    fail('Defined type openondemand::conf: Must define either source, content, content_template or data')
  }

  if $template {
    $extension = 'yml.erb'
  } else {
    $extension = 'yml'
  }

  $_filename = pick($filename, "${name}.${extension}")

  if $data {
    $_content = join([
      '# File managed by Puppet - DO NOT EDIT',
      to_yaml($data),
      '',
    ], "\n")
  } elsif $content_template {
    $_content = template($content_template)
  } else {
    $_content = $content
  }

  include openondemand

  file { "/etc/ood/config/ondemand.d/${_filename}":
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => $_content,
    source  => $source,
    notify  => Class['openondemand::service'],
  }

}
