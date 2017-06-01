class profile::release_accounts (
        $ensure = 'absent'
) {
        user { 'pcadiz' :
                ensure => $ensure,
        }
        user { 'cmmendoza' :
                ensure => $ensure,
        }
        user { 'mgalero' :
                ensure => $ensure,
        }
        user { 'rdabu' :
                ensure => $ensure,
        }

}

