newparam(:source_path) do
  include EasyType

  desc %q{the source containing the sql upgrade and downgrade scripts.

    You can use either:

    a base directory: 

    ora_schema-definition{'app':
      ensure => latest,
      source => '/staging'
    }

    in this case, puppet will look for upgrade and downgrade scripts in:
      /staging/app/sql/upgrades 
      /staging/app/sql/downgrades


    a base url: 

    ora_schema-definition{'app':
      ensure => latest,
      source => 'http://host/staging'
    }

    in this case, puppet will look for upgrade and downgrade scripts in:
      http://host/staging/app/sql/upgrades 
      http://host/staging/app/sql/downgrades

    a container file. Either local or remote: 

    ora_schema-definition{'app':
      ensure => latest,
      source => 'http://host/staging/app-1.2.3.zip'
    }

    in this case, puppet will download the file, unpack it in /tmp and look for upgrade and downgrade scripts in:
      /tmp/app-1.2.3/sql/upgrades 
      /tmp/app-1.2.3/sql/downgrades
  }

end
