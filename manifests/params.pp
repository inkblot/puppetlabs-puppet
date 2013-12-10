# Class: puppet::params
#
# This class installs and configures parameters for Puppet
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class puppet::params {

  $puppet_server                    = 'aserver.puppetlabs.lan'
  $environment                      = 'production'
  $puppet_storeconfigs_password     = 'password'
  $modulepath                       = "/etc/puppet/modules"
  $storeconfigs_dbadapter           = 'mysql'
  $storeconfigs_dbuser              = 'puppet'
  $storeconfigs_dbpassword          = 'password'
  $storeconfigs_dbserver            = 'localhost'
  $storeconfigs_dbsocket            = '/var/run/mysqld/mysqld.sock'
  $certname                         = downcase($::fqdn)
  $confdir                          = '/etc/puppet'
  $configtimeout                    = '120'
  $manifest                         = '/etc/puppet/manifests/site.pp'
  $templatedir                      = '$confdir/templates'
  $puppet_site                      = downcase($::fqdn)
  $puppet_docroot                   = '/etc/puppet/rack/public/'
  $puppet_passenger_port            = '8140'

  case $::operatingsystem {
    'centos', 'redhat', 'fedora', 'scientific': {
      $puppet_master_package        = 'puppet'
      $puppet_master_service        = 'puppetmaster'
      $puppet_agent_service         = 'puppet'
      $puppet_agent_name            = 'puppet'
      $puppet_defaults              = '/etc/sysconfig/puppet'
      $puppet_dashboard_report      = ''
      $puppet_storeconfigs_packages = 'mysql-devel'
      $puppet_conf                  = '/etc/puppet/puppet.conf'
      $puppet_logdir                = '/var/log/puppet'
      $puppet_vardir                = '/var/lib/puppet'
      $puppet_ssldir                = '/var/lib/puppet/ssl'
      $rack_config_source           = "puppet:///modules/puppet/config.ru"
    }
    'ubuntu', 'debian': {
      $puppet_master_package        = 'puppet'
      $puppet_master_service        = 'puppetmaster'
      $puppet_agent_service         = 'puppet'
      $puppet_agent_name            = 'puppet'
      $puppet_defaults              = '/etc/default/puppet'
      $puppet_dashboard_report      = '/usr/lib/ruby/1.8/puppet/reports/puppet_dashboard.rb'
      $puppet_storeconfigs_packages = 'libmysql-ruby'
      $puppet_conf                  = '/etc/puppet/puppet.conf'
      $puppet_logdir                = '/var/log/puppet'
      $puppet_vardir                = '/var/lib/puppet'
      $puppet_ssldir                = '/var/lib/puppet/ssl'
      $rack_config_source           = '/usr/share/puppet/ext/rack/files/config.ru'
    }
    'freebsd': {
      $puppet_agent_service         = 'puppet'
      $puppet_agent_name            = 'puppet'
      $puppet_conf                  = '/usr/local/etc/puppet/puppet.conf'
      $puppet_logdir                = '/var/log/puppet'
      $puppet_vardir                = '/var/puppet'
      $puppet_ssldir                = '/var/puppet/ssl'
      $rack_config_source           = "puppet:///modules/puppet/config.ru"
    }
    'darwin': {
      $puppet_agent_service         = 'com.puppetlabs.puppet'
      $puppet_agent_name            = 'puppet'
      $puppet_conf                  = '/etc/puppet/puppet.conf'
      $puppet_logdir                = '/var/log/puppet'
      $puppet_vardir                = '/var/lib/puppet'
      $puppet_ssldir                = '/etc/puppet/ssl'
      $rack_config_source           = "puppet:///modules/puppet/config.ru"
    }
  }

}
