boekkooi/openshift-nginx-php54
============================
This is a sample repository to get nginx + php fpm running on openshift.

More information about openshift: https://openshift.redhat.com/

What's inside
-------------

**The `.openshift/action_hooks` scripts:**

* build:
    - Build the versions of nginx, php and nodejs that are needed
* build_*
    - The functions used for checking the versions and installing
* deploy
    - This will render copy the nginx and php conf files
    - Copy the .bash_profile if there is none
* common
    - A common include script for the action hooks (just setting some path's)
* start
    - Starts Nginx and php-fpm
* stop
    - Stops Nginx and php-fpm

**The `.openshift/tmpl` templates:**

Here are the templates used by the build and deploy scripts.
Just customize away.

**The `web/` nginx web folder:**

The web folder currently used. You can change this in `.openshift/tmpl/nginx.conf.tmpl`.

Usage
-----

To get PHP 5.4 working at OpenShift, you have to do the following:

1. Create a new Openshift "Do-It-Yourself" application
2. Clone this repository
3. Add a new remote "openshift" (You can find the URL to your git repository
   on the Openshift application page)
4. Run `git push --force "openshift" master:master`
5. SSH into your gear
7. Wait for build to finish (This may take at least an hour)
8. Open http://appname-namespace.rhcloud.com/ to verify

Other
-----

When using the action hooks within you own project by copy-paste method don't forget todo `git update-index --chmod=+x -- $(git ls-files .openshift/action_hooks/*)`.

Currently [nodejs](http://nodejs.org/) will only be build when the version is not the same a the one installed by default, it will just create a proxy for npm so it can be used with less problems.

Thanks
------

Thanks to the following people:

* [@sgoettschkes](https://github.com/Sgoettschkes)
* [@drejohnson](https://github.com/drejohnson)
* [@openshift](https://github.com/openshift/)

Todo's
------
This is stuff which needs to be done right now. Feel free to do a pull request!

* Get php --with-mcrypt to compile
* Test update functionality more thoroughly
* Test with Jenkins (http://jenkins-ci.org/) builds
* Get a [cup of coffee](https://www.gittip.com/Warnar%20Boekkooi/)

