# boekkooi/openshift-nginx-php
This is a sample repository to get nginx + php fpm running on openshift.

More information about openshift: https://openshift.redhat.com/

**If you are using [openshift online](https://www.openshift.com/) you may want to take a look at the special [nginx](https://github.com/boekkooi/openshift-cartridge-nginx) and [php](https://github.com/boekkooi/openshift-cartridge-php) catridge**

## What's inside

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

## Usage

To get PHP 5.6 working at OpenShift, you have to do the following:

1. Create a new Openshift "Do-It-Yourself" application
2. Clone this repository
3. Add a new remote "openshift" (You can find the URL to your git repository
   on the Openshift application page)
4. Run `git push --force "openshift" master:master`
5. SSH into your gear
7. Wait for build to finish (This may take at least an hour)
8. Open http://appname-namespace.rhcloud.com/ to verify

## Extra's

#### Nodejs
Support for [NodeJS](http://nodejs.org/) is availible!
Just uncomment `NODE_VERSION` in `.openshift/action_hooks/build` and commit/push the file.

#### Phalcon Framework
Support for [Phalcon](http://phalconphp.com) is availible!
Just uncomment `PHALCON_VERSION` in `.openshift/action_hooks/build` and commit/push the file.

## Known issues

#### PHP 5.4 won't build
To get PHP 5.4 to build open `.openshift/action_hooks/build_php` and remove `--enable-opcache`(line: 68).

#### Only index.php works in root dir
Currently the `.openshift/tmpl/nginx.conf.tmpl` configuration template for nginx only redirects to the `web/index.php` file.
You can change this by editing the template file. Also see http://wiki.nginx.org/Symfony for some extra information.

#### The hooks are not executing
This probably happens because they are not executable.
Just do `git update-index --chmod=+x -- $(git ls-files .openshift/action_hooks/*)` in your project root and commit/push.

#### Openshift disconnects on build
This seems to be a problem within openshift (see https://www.openshift.com/forums/openshift/openshift-build-timeout).

To resume the build, first make an arbitrary change to your local repo (e.g. add some text to README.md), commit that change and then do another `git push --force "openshift" master:master`.

#### Other
Maybe have a look at [stackoverflow](http://stackoverflow.com/questions/tagged/openshift) and if you end up empty-handed just [create a issue](https://github.com/boekkooi/openshift-diy-nginx-php/issues).

## Thanks

Thanks to the following people:

* [@sgoettschkes](https://github.com/Sgoettschkes)
* [@drejohnson](https://github.com/drejohnson)
* [@openshift](https://github.com/openshift/)
 
## Reading material

Some articles that mention how you can use this repo and other related articles:

* [[DIY] Nginx + PHP 5.4](https://www.openshift.com/forums/openshift/diy-nginx-php-54) origional forum post.
* [Nginx, PHP5.5 and Phalcon on OpenShift](http://www.sitepoint.com/nginx-php5-5-phalcon-openshift/) by [Bruno Skvorc](https://twitter.com/bitfalls) using a fork by [duythien](https://github.com/duythien).
* [How to Run Nginx PHP-FPM under OpenShift](https://www.openshift.com/blogs/how-to-run-nginx-php-fpm-under-openshift) a cartridge created by [Getup Cloud](http://getupcloud.com/index_en.html)
 
If you wrote a article about openshit and nginx+php please let me know so I can add it to the list.
