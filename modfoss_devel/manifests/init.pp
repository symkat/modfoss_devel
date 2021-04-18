class modfoss_devel {
    include accounts
    include sudo
    include ntp

    file { "/etc/profile.d/locallib.sh":
        ensure => 'present',
        content => 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"',
    }

    package { 'git':
        ensure => 'installed',
    }
    
    # Install local lib
    package { 'liblocal-lib-perl':
        ensure => 'installed',
    }
    
    # Install cpanminus
    package { 'cpanminus':
        ensure => 'installed',
    }

    # libpq is required for perl PSQL lib building
    package { 'libpq-dev':
        ensure => 'installed',
    }

    # libssl is required for perl SSL lib building
    package { 'libssl-dev':
        ensure => 'installed',
    }
    
    # libz is required for perl SSL lib building
    package { 'libz-dev':
        ensure => 'installed',
    }
    
    # Build essential is required to compile Perl things
    package { 'build-essential':
        ensure => 'installed',
    }
}
