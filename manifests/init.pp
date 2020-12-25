# @summary Manage the BIND domain name server and DNS zones
#
# @example
#   include bind
#
# @param config_dir
#   Directory for BIND configuration files.
#
# @param package_manage
#   Whether to have this module manage the BIND package.
#
# @param service_manage
#   Whether to have this module manage the BIND service.
#
# @param package_backport
#   Whether to install the BIND package from Debian backports.
#
# @param package_name
#   The name of the BIND package.
#
# @param package_ensure
#   The `ensure` parameter for the BIND package.
#
# @param resolvconf_package_name
#   The name of the resolvconf package to use if `resolvconf_service_enable` is `true`.
#
# @param resolvconf_service_enable
#   Whether to enable the named-resolvconf service so that localhost's BIND resolver is used in
#   `/etc/resolv.conf`.
#
# @param service_enable
#   The `enable` parameter for the BIND service.
#
# @param service_ensure
#   The `ensure` parameter for the BIND service.
#
# @param service_name
#   The name of the BIND service.
#
# @param service_options
#   [Command line
#   options](https://bind9.readthedocs.io/en/latest/manpages.html#named-internet-domain-name-server)
#   for the BIND service.
#
class bind (
  Stdlib::Absolutepath $config_dir,
  Boolean $package_backport,
  String[1] $package_name,
  String[1] $resolvconf_package_name,
  Boolean $resolvconf_service_enable,
  String[1] $service_name,
  String[1] $service_options,
  String[1] $package_ensure = installed,
  Boolean $package_manage = true,
  Variant[Boolean, String[1]] $service_enable = true,
  Stdlib::Ensure::Service $service_ensure = running,
  Boolean $service_manage = true,
) {
  contain bind::install
  contain bind::config
  contain bind::service

  Class['bind::install']
  -> Class['bind::config']
  ~> Class['bind::service']
}