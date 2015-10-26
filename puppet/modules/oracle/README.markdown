[![Build Status](https://travis-ci.org/hajee/oracle.png?branch=master)](https://travis-ci.org/hajee/oracle)

####Table of Contents

[![Powered By EasyType](https://raw.github.com/hajee/easy_type/master/powered_by_easy_type.png)](https://github.com/hajee/easy_type)


1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with oracle](#setup)
    * [What oracle affects](#what-oracle-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with oracle](#beginning-with-oracle)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Troubleshooting](#troubleshooting)
6. [Limitations - OS compatibility, etc.](#limitations)
7. [Development - Guide for contributing to the module](#development)
    * [OS support](#os-support)
    * [Oracle versions support](#oracle-version-support)
    * [Managable Oracle objects](#managable-oracle-objects)
    * [Tests - Testing your configuration](#testing)

##Overview

This module contains a couple of Puppet custom types to manage 'stuff' in an Oracle database. At this point in time we support manage tablespaces, oracle users, grants, roles, init parameters, asm diskgroups, threads and services. To learn more, check [the blog post](http://hajee.github.io/2014/02/23/using-puppet-to-manage-oracle/)

##Module Description

This module contains custom types that can help you manage DBA objects in an Oracle database. It runs **after** the database is installed. IT DOESN'T INSTALL the Oracle database software. With this module, you can setup a database to receive an application. You can:

* create a tablespace
* create a user with the required grants and quota's
* create one or more roles
* create one or more services

##Setup

###What oracle affects

The types in this module will change settings **inside** a Oracle Database. No changes are made outside of the database.

###Setup Requirements

To use this module, you need a running Oracle database and/or a running asm database. I can recommend [Edwin Biemonds Puppet OraDb module](https://github.com/biemond/puppet/tree/master/modules/oradb). 

The Oracle module itself is based on [easy_type](https://github.com/hajee/easy_type). SO you need to have that module installed to.

###Beginning with oracle module

After you have a running database, (See [Edwin Biemonds Puppet OraDb module](https://github.com/biemond/puppet/tree/master/modules/oradb)), you need to install [easy_type](https://github.com/hajee/easy_type), and this module.

```sh
puppet module install hajee/easy_type
puppet module install hajee/oracle
```


##Usage

The module contains the following types:

- `ora_asm_diskgroup`
- `ora_asm_volume`
- `ora_exec`
- `ora_database`
- `ora_init_params`
- `ora_listener`
- `ora_record`
- `ora_role`
- `ora_schema_definition`
- `ora_service`
- `ora_tablespace`
- `ora_thread`
- `ora_user`

Here are a couple of examples on how to use them.

###ora_listener

This is the only module that does it's work outside of the Oracle database. It makes sure the Oracle SQL*Net listener is running.

```puppet
ora_listener {'SID':
  ensure  => running,
  require => Exec['db_install_instance'],
}
```

The name of the resource *MUST* be the sid for which you want to start the listener.

###Specifying the SID

All types have a name like `resource@sid`. The sid is optional. If you don't specify the sid, the type will use the first database instance from the `/etc/oratab`  file. We advise you to use a full name, e.g. an sid and a resource name. This makes the manifest much more resilient for changes in the environment.


###ora_user

This type allows you to manage a user inside an Oracle Database. It recognises most of the options that [CREATE USER](http://docs.oracle.com/cd/B28359_01/server.111/b28286/statements_8003.htm#SQLRF01503) supports. Besides these options, you can also use this type to manage the grants and the quota's for this user.

```puppet
ora_user{user_name@sid:
  temporary_tablespace      => temp,
  default_tablespace        => 'my_app_ts,
  password                  => 'verysecret',
  require                   => Ora_tablespace['my_app_ts'],
  grants                    => ['SELECT ANY TABLE', 'CONNECT', 'CREATE TABLE', 'CREATE TRIGGER'],
  quotas                    => {
                                  "my_app_ts"  => 'unlimited'
                                },
}
```


###ora_tablespace

This type allows you to manage a tablespace inside an Oracle Database. It recognises most of the options that [CREATE TABLESPACE](http://docs.oracle.com/cd/B28359_01/server.111/b28310/tspaces002.htm#ADMIN11359) supports.

```puppet
ora_tablespace {'my_app_ts@sid':
  ensure                    => present,
  datafile                  => 'my_app_ts.dbf',
  size                      => 5G,
  logging                   => yes,
  autoextend                => on,
  next                      => 100M,
  max_size                  => 20G,
  extent_management         => local,
  segment_space_management  => auto,
}
```

You can also create an undo tablespace:

```puppet
ora_tablespace {'my_undots_1@sid':
  ensure                    => present,
  contents                  => 'undo',
}
```

or a temporary taplespace:

```puppet
tablespace {'my_temp_ts@sid':
  ensure                    => present,
  datafile                  => 'my_temp_ts.dbf',
  content                   => 'temporary',
  size                      => 5G,
  logging                   => yes,
  autoextend                => on,
  next                      => 100M,
  max_size                  => 20G,
  extent_management         => local,
  segment_space_management  => auto,
}
```

###ora_role

This type allows you to create or delete a role inside an Oracle Database. It recognises a limit part of the options that [CREATE ROLE](http://docs.oracle.com/cd/B28359_01/server.111/b28286/statements_6012.htm#SQLRF01311) supports.


```puppet
ora_role {'just_a_role@sid':
  ensure    => present,
}
```

You can also add grants to a role:

```puppet
ora_role {'just_a_role@sid':
  ensure    => present,
  grants    => ['create session','create table'],
}
```


###ora_service

This type allows you to create or delete a service inside an Oracle Database.


```puppet
ora_service{'my_app_service@sid':
  ensure  => present,
}
```

###ora_init_param

this type allows you to manage your init.ora parameters. You can manage your `spfile` parameters and your `memory` parameters. First the easy variant where you want to change an spfile parameter on your current sid for your current sid.


```puppet
ora_init_param{'SPFILE/PARAMETER':
  ensure  => present,
  value   => 'the_value'
}
```

To manage the same parameter only the in-memory one, use:

```puppet
init_param{'MEMORY/PARAMETER':
  ensure  => present,
  value   => 'the_value'
}
```

If you are running RAC and need to specify a parameter for an other instance, you can specify the instance as well.

```puppet
init_param{'MEMORY/PARAMETER:INSTANCE':
  ensure  => present,
  value   => 'the_value'
}
```

Sometimes parameters have multiple value. In that case you can specify an array.

```puppet
ora_init_param{'SPFILE/audit_trail':
  ensure => present,
  value  => [EXTENDED,XML]
}
```

Having more then one sid running on your node and you want to specify the sid you want to use, use `@SID` at the end.


```puppet
init_param{'MEMORY/PARAMETER:INSTANCE@SID':
  ensure  => present,
  value   => 'the_value'
}
```

###ora_asm_diskgroup

This type allows you to manage your ASM diskgroups. Like the other Oracle types, you must specify the SID. But for this type it must be the ASM sid. Most of the times, this is `+ASM1`

```puppet
ora_asm_diskgroup {'REDO@+ASM1':
  ensure          => 'present',
  redundancy_type => 'normal',
  compat_asm      => '11.2.0.0.0',
  compat_rdbms    => '11.2.0.0.0',
  disks           => {
    'FAILGROUP1' => [
      { 'diskname' => 'REDOVOL1', 'path' => 'ORCL:REDOVOL1'}
    ,
    'FAILGROUP2' => [
      { 'diskname' => 'REDOVOL2', 'path' => 'ORCL:REDOVOL2'},
    ]
  }
}

```

At this point in time the type support just the creation and the removal of a diskgroup. Modification of diskgroups is not (yet) supported.

###ora_exec

this type allows you run a specific SQL statement or an sql file on a specified instance sid.

```puppet
  ora_exec{"drop table application_users@sid":
    username => 'app_user',
    password => 'password,'
  }
```

This statement will execute the sql statement `drop table application_users` on the instance names `instance`. 

You can use the `unless` parameter to only execute the statement in certain states. If the query specified in the `unless` parameter returns one or more records, the main statement is skipped.

```puppet
  ora_exec{ "create synonym ${user}.${synonym} for USER.${synonym}":
    unless  => "select * from all_synonyms where owner=\'${user}\' and synonym_name=\'${synonym}\'",
  }
```

You can also execute a script.

```puppet
ora_exec{"@/tmp/do_some_stuff.sql@sid":
  username  => 'app_user',
  password  => 'password,'
  logoutput => on_failure,  # can be true, false or on_failure
}
```

This statement will run the sqlscript `/tmp/do_some_stuff.sql` on the sid named `sid`. Use the `unless` parameter to just 

When you don't specify the username and the password, the type will connect as `sysdba`.

### ora_record

With `ora_record` you can manage individual records in a database.  It is **NOT** intended to insert large quantities of records into a database, but it is intended to use puppet to manage configuration information stored in database tables. An example:

```puppet
ora_record{'SUBSCRIPTION':
  ensure     => 'updated',
  table_name => 'SUBSCRIPTION',
  username   => 'APP',
  password   => 'APP',
  key_name   => 'SUBSCRIPTIONID',
  key_value  => '19',
  data       => {
      'CUSTOMER_NAME'               => 'Favorite customer',
      'TYPE_OF_SUBSCRIPTION'        => 'REGULAR'
    }
}
```
This puppet definition will make sure a records with `SUBSCRIPTIONID` `19`  exists in the database. The content is taken from the property `DATA`. Because `ensure` is specified as `updated`, every time puppet run's it will change the content of the database records based on your definition. This may not be what you want. Sometimes you just want to make sure an initial record exists with these values, but after the user has changed the values, you want to keep the changes. `ora_record` supports this behaviour by setting `ensure` to `present`. This will make sure a record with the specified key and content exists, but it will not look at the data part.

### ora_schema_definition

`ora_schema_definition` allows you to manage schema definitions for your application. Here's an example:

```puppet
ora_schema_definition{'app@test':
  ensure      => '2.3.0',
  source_path => '/vagrant',
  parameters => {
    app_data_tablespace  => 'USERS',
    app_index_tablespace => 'USERS',
  }
}
```
Internally this type creates or updates a table containing the latest version of the schema. It uses update and downgrade sqlscripts. These sqlscripts must be available in the directory specified by `source_path`. upgrade scripts in the subdirectory `upgrades` and downgrade scripts in the subdirectory `downgrades`. Each script must have the following format:

  `sequence_name_version_description.sql`

where:

- `sequence` is a four digit incremental sequence number starting at `0000`
- `name` is a character string name
- `version` is is number in the form `x.y.z` where all are numbers
- `description` is a description of the content.

###ora_thread

This type allows you to enable a thread. Threads are used in Oracle RAC installations. This type might not be very useful for regular use, but it is used in the [Oracle RAC module](https://forge.puppetlabs.com/hajee/ora_rac).


```puppet
ora_thread{"2@sid":
  ensure  => 'enabled',
}
```

This enables thread 2 on instance named `sid`

###ora_database

This type allows you to create a database. In one of it's simplest form:

```puppet
ora_database{'oradb':
  ensure          => present,
  oracle_base     => '/opt/oracle',
  oracle_home     => '/opt/oracle/app/11.04',
  control_file    => 'reuse',
}
```

The `ora_database` type uses structured types for some of the parameters. Here is part of an example with some of these structured parameters filled in:


```puppet
ora_database{'bert':
  logfile_groups => [
      {file_name => 'test1.log', size => '10M'},
      {file_name => 'test2.log', size => '10M'},
    ],
  ...
  default_tablespace => {
    name      => 'USERS',
    datafile  => {
      file_name  => 'users.dbs',
      size       => '1G',
      reuse      =>  true,
    },
    extent_management => {
      type          => 'local',
      autoallocate  => true,
    }
  },
  ...
  datafiles       => [
    {file_name   => 'file1.dbs', size => '1G', reuse => true},
    {file_name   => 'file2.dbs', size => '1G', reuse => true},
  ],
  ...
  default_temporary_tablespace => {
    name      => 'TEMP',
    type      => 'bigfile',
    tempfile  => {
      file_name  => 'tmp.dbs',
      size       => '1G',
      reuse      =>  true,
      autoextend => {
        next    => '10K',
        maxsize => 'unlimited',
      }
    },
    extent_management => {
      type          => 'local',
      uniform_size  => '1G',
    },
  },
  ....
  undo_tablespace   => {
    name      => 'UNDOTBS',
    type      => 'bigfile',
    datafile  => {
      file_name  => 'undo.dbs',
      size       => '1G',
      reuse      =>  true,
    }
  },
  ....
  sysaux_datafiles => [
    {file_name   => 'sysaux1.dbs', size => '1G', reuse => true},
    {file_name   => 'sysaux2.dbs', size => '1G', reuse => true},
  ]

```

You can also specify some initialisation scripts.

```
ora_database{$db_name:
  ensure            => present,
  ...
  config_scripts    => [
    {'Catalog' => template('oracle/dbs/Catalog.sql.erb')},
    {'Context' => template('oracle/dbs/Context.sql.erb')},
  ],
```

These initialisation scripts will be executed in the order specified. The module has templates for the following scripts:

- Catalog.sql.erb
- Context.sql.erb
- Cwmlite.sql.erb
- Grants.sql.erb
- Help.sql.erb
- JServer.sql.erb
- LockAccount.sql.erb
- Post_Create_RAC.sql.erb
- Psu.sql.erb
- README
- RenameRedo1.sql.erb
- Xdb_Protocol.sql.erb

You can find these templates in the `dbs` directory.

##detailed description

See the type documentation for all parameters.

```sh
$ puppet describe ora_database
```
You can also checkout an example in the [test directory](https://github.com/hajee/oracle/blob/master/tests/create_database.pp)


##Troubleshooting

When it fails on a Master-Agent setup you can do the following actions:

- Check the time difference/timezone between all the puppet master and agent machines.
- Update oracle and its dependencies on the puppet master.
- After adding or refreshing the easy_type or oracle modules you need to restart all the PE services on the puppet master (this will flush the PE cache) and always do a puppet agent run on the Puppet master
- To solve this error "no such file to load -- easy_type" you need just to do a puppet run on the puppet master when it is still failing you can move the easy_type module to its primary module location ( /etc/puppetlabs/puppet/module )

When the `ora_database` creation fails:

- First remove all `config_scripts`. Then start again. If the database creation run's fine, check the scripts.
- Check if all the path's in the script exist and log file directories are writable by the specified Oracle user. 

##Limitations

This module is tested on Oracle 11 on CentOS and Redhat. It will probably work on other Linux distributions. It will definitely **not** work on Windows. As far as Oracle compatibility. Most of the sql commands's it creates under the hood are pretty much Oracle version independent. It should work on most Oracle versions.

##Development

This is an open projects, and contributions are welcome.

###OS support

Currently we have tested:

* Oracle 11.2.0.2 & 11.2.0.4
* CentOS 5.8
* Redhat 5

It would be great if we could get it working and tested on:

* Oracle 12
* Debian
* Windows
* Ubuntu
* ....

###Oracle version support

Currently we have tested:

* Oracle 11.2.0.2
* Oracle 11.2.0.4

It would be great if we could get it working and tested on:

* Oracle 12
* Oracle XE

###Managable Oracle objects

Obviously Oracle has many many many more DBA objects that need management. For some of these Puppet would be a big help. It would be great if we could get help getting this module to support all of the objects.

If you have knowledge in these technologies, know how to code, and wish to contribute to this project, we would welcome the help.

###Testing

Make sure you have:

* rake
* bundler

Install the necessary gems:

    bundle install

And run the tests from the root of the source code:

    rake test

We are currently working on getting the acceptance test running as well.

