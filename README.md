# software_install cookbook

# Requirements

* You should already have a RHEL/CentOS 6.x target.  The provided
Vagrantfile will retrieve a basebox for you that includes 10.14
chef-client.  Note, this assumes:

  1.  You have internet access.
  2.  You have vagrant installed.
  3.  You have berkshelf installed.
  4.  You have VirtualBox installed.

* Create the 'software' data bag:

  1.  knife data bag create software
  2.  knife data bag from file software software/git.json
  3.  knife data bag from file software software/apache.json

# Usage

  1.  Modify data bag to your liking:
    * Create new data bag items.
    * Modify the existing ones.
  2.  Create data bag and upload items (see above for details).
  3.  Upload software_install cookbook to Chef server.
  4.  Add `software_install::default` to run_list.
  5.  Invoke chef-client on system to be automated.


# Attributes

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
