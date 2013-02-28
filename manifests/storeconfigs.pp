# Class: puppet::storedconfiguration
#
# This class installs and configures Puppet's stored configuration capability
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::storeconfigs (
    $puppet_conf = $::puppet::params::puppet_conf,
    $backend     = $::puppet::params::storeconfigs_backend,
    $dbadapter,
    $dbuser,
    $dbpassword,
    $dbserver,
    $dbsocket
) {

  if $backend == 'active_record' {
    # This version of activerecord works with Ruby 1.8.5 and Centos 5.
    # This ensure should be fixed.
    Package['activerecord'] -> Class['puppet::storeconfigs']

    case $dbadapter {
      'sqlite3': {
        include puppet::storeconfigs::sqlite
      }
      'mysql': {
        class {
          "puppet::storeconfigs::mysql":
            dbuser     => $dbuser,
            dbpassword => $dbpassword,
        }
      }
      default: { err("target dbadapter $dbadapter not implemented") }
    }
  }

  concat::fragment { 'puppet.conf-master-storeconfig':
    order   => '06',
    target  => $puppet_conf,
    content => template("puppet/puppet.conf-master-storeconfigs.erb");
  }

}

