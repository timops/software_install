# software_install Cookbook

This cookbook automates the deployment of software packages which are
specified in a data bag.  For demonstration purposes only.

## Requirements

You should already have a RHEL/CentOS 6.x target.  The provided
Vagrantfile will retrieve a basebox for you that includes 10.14
chef-client.  Note, this assumes:

  1.  You have internet access.
  2.  You have vagrant installed.
  3.  You have berkshelf installed.
  4.  You have VirtualBox installed.


## Usage

  1.  Modify data bag to your liking:
    * Create new data bag items.
    * Modify the existing ones.
  2.  Create data bag and upload items (see below).

  knife data bag create software
  knife data bag from file software software/git.json
  knife data bag from file software software/apache.json

  3.  Upload software_install cookbook to Chef server.

  knife cookbook upload software_install

  4.  Add `software_install::default` to run_list.

  knife node run_list add <nodename> 'recipe[software_install]'

  5.  Invoke chef-client on system to be automated.

  chef-client

## Attributes

* This cookbook is driven by a 'software' data bag, and thus no
attributes are required.
* Each software component is specified in a data bag item that
resembles:

```json
{
  "id": "apache",
  "description": "Apache Server",
  "version": "2.2.15",
  "pkgs": [ "httpd", "httpd-devel" ]
}
```

* The value for *pkgs* key represents a list of packages that yum needs
to install to successfully deploy this software object.

# Recipes

* `default.rb` - will install software packages from 'software' data
bag.
