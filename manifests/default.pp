class { 'ipa':
  master  => true, # Only one master per Puppet master
  domain  => 'vagrant.test',
  realm   => 'VAGRANT.TEST',
  adminpw => '71908174-80b8-11e6-a7fb-2320702943c7',
  dspw    => '79ebae3e-80b8-11e6-a0aa-3b61d8624619',
  require => File['/etc/yum.repos.d/epel.repo']
}

package { 'epel-release':
  ensure => installed,
}

package { 'haveged':
  ensure => present,
  require => File['/etc/yum.repos.d/epel.repo']
}

service { 'haveged':
  ensure => running,
  require => Package['haveged'],
}

file { '/etc/yum.repos.d/epel.repo':
  ensure => present,
  content => '[epel]
name=Extra Packages for Enterprise Linux 7 - $basearch
#baseurl=http://download.fedoraproject.org/pub/epel/7/$basearch
mirrorlist=https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch
failovermethod=priority
enabled=1
gpgcheck=1
gpgkey=file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7',
  require => Package['epel-release'],
}


