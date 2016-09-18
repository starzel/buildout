====================
The Starzel Buildout
====================

.. image:: https://travis-ci.org/starzel/buildout.svg?branch=master
    :target: https://travis-ci.org/starzel/buildout

This is a standard Plone-buildout of the company `Starzel.de <http://www.starzel.de>`_.

.. contents::


Main features
-------------

* It extends to config- and version-files on github shared by all projects that use the same version of Plone.
* It allows to update a project simply by changing the version it extends.
* It allows to update all projects of one version by changing remote files (very useful for HotFixes).
* It is minimal work to setup a new project.
* It has presets for development, testing, staging and production.
* It has all the nice development-helpers we use.


Structure
---------

``buildout.cfg``
    This contains the project settings (name, addons, checkouts etc.).

``local.cfg``
    For each environment (development, production, test) there is a separate ``local_*.cfg``-file. You create a *symlink*  called ``local.cfg`` to one of these files depending on your environment. Each of the files includes the remote ``base.cfg`` that is hosted on github like this:

    .. code-block:: ini

        extends = https://raw.githubusercontent.com/starzel/buildout/5.0.6/linkto/base.cfg

    This example refers to the tag 5.0.6 of this buildout that uses Plone 5.0.6 To use a different Plone-version simply change that to point to a different tag.

``base.cfg``
    This remote file conatains most of the commonly used logic used for prodcution. It also includes two version-files that are also hosted on github:

    * `pinned_versions.cfg <https://raw.githubusercontent.com/starzel/buildout/5.0.6/linkto/pinned_versions.cfg>`_: Pinns the Plone-version using http://dist.plone.org/release/5.0.6/versions.cfg
    * `floating_versions.cfg <https://raw.githubusercontent.com/starzel/buildout/5.0.6/linkto/floating_versions.cfg>`_: Pinns all commonly used addons of this buildout.

``pinned_versions_project.cfg``
    Here you pinn versions to overwrite or extend the hosted ``pinned_versions.cfg``. These eggs are usually pinned for a reason and are usually not safe to be upgraded.

``floating_versions_project.cfg``
    Here you overwrite and extend the hosted ``floating_versions.cfg``. These eggs should usually be safe to be upgraded. ``./bin/checkversions floating_versions_project.cfg`` will check pypi if there are newer releases for your pinned eggs.


Versions
--------

We support the following version of Plone:

- `5.0.6 <https://raw.githubusercontent.com/starzel/buildout/5.0.6/linkto/base.cfg>`_
- `5.0.5 <https://raw.githubusercontent.com/starzel/buildout/5.0.5/linkto/base.cfg>`_
- `5.0.4 <https://raw.githubusercontent.com/starzel/buildout/5.0.4/linkto/base.cfg>`_
- `5.0.3 <https://raw.githubusercontent.com/starzel/buildout/5.0.3/linkto/base.cfg>`_
- `5.0.2 <https://raw.githubusercontent.com/starzel/buildout/5.0.2/linkto/base.cfg>`_
- `5.0 <https://raw.githubusercontent.com/starzel/buildout/5.0/linkto/base.cfg>`_
- `4.3.11 <https://raw.githubusercontent.com/starzel/buildout/4.3.11/linkto/base.cfg>`_
- `4.3.10 <https://raw.githubusercontent.com/starzel/buildout/4.3.10/linkto/base.cfg>`_
- `4.3.9 <https://raw.githubusercontent.com/starzel/buildout/4.3.9/linkto/base.cfg>`_
- `4.3.8 <https://raw.githubusercontent.com/starzel/buildout/4.3.8/linkto/base.cfg>`_
- `4.3.7 <https://raw.githubusercontent.com/starzel/buildout/4.3.7/linkto/base.cfg>`_
- `4.3.6 <https://raw.githubusercontent.com/starzel/buildout/4.3.6/linkto/base.cfg>`_
- `4.3.4 <https://raw.githubusercontent.com/starzel/buildout/4.3.4/linkto/base.cfg>`_
- `4.3.3 <https://raw.githubusercontent.com/starzel/buildout/4.3.3/linkto/base.cfg>`_
- `4.3.2 <https://raw.githubusercontent.com/starzel/buildout/4.3.2/linkto/base.cfg>`_
- `4.3.1 <https://raw.githubusercontent.com/starzel/buildout/4.3.1/linkto/base.cfg>`_
- `4.3 <https://raw.githubusercontent.com/starzel/buildout/4.3/linkto/base.cfg>`_
- `4.2.7 <https://raw.githubusercontent.com/starzel/buildout/4.2.7/linkto/base.cfg>`_
- `4.2.5 <https://raw.githubusercontent.com/starzel/buildout/4.2.5/linkto/base.cfg>`_
- `4.2.3 <https://raw.githubusercontent.com/starzel/buildout/4.2.3/linkto/base.cfg>`_
- `4.2.2 <https://raw.githubusercontent.com/starzel/buildout/4.2.2/linkto/base.cfg>`_

To develop against the current `Coredev <https://github.com/plone/buildout.coredev/tree/5.0>`_ use ``local_coredev.cfg``.

Please note that new features are not introduced to old versions.

Tags for development-versions (alpha, beta and rc) will exists but will be removed after the final release of that version.


Quickstart
----------

.. code-block:: bash

    $ git clone https://github.com/starzel/buildout SOME_PROJECT
    $ cd SOME_PROJECT

You do not need the linkto-directory since its files are used via links to github.

.. code-block:: bash

    $ rm -rf linkto

If you are not developing the buildout itself you want a create a new repo.

.. code-block:: bash

    $ rm -rf .git && git init

Add a file that contains a passwort. Do **not** use ``admin`` as a password in production!

.. code-block:: bash

    $ echo -e "[buildout]\nlogin = admin\npassword = admin" > secret.cfg

Symlink to the file that best fits you local environment. At first that is usually development. Later you can use production or test. This buildout only uses ``local.cfg`` and ignores all ``local_*.cfg``.

.. code-block:: bash

    $ ln -s local_develop.cfg local.cfg

Build Plone

.. code-block:: bash

    $ virtualenv-2.7 .
    $ ./bin/pip install -r requirements.txt
    $ ./bin/buildout


Configuring a project
---------------------

``buildout.cfg`` contains the general project settings. Here you configure the name of the project, the eggs, source-checkouts and languages Plone will use.


Use in development
------------------

Symlink to the development-config:

.. code-block:: bash

    $ ln -s local_develop.cfg local.cfg

The development-setup will build a simple instance with some useful tools (see below). The setup assumes that zeo, varnish, haproxy and nginx are only configured on production.


Use in production
-----------------

Symlink to the production-config:

.. code-block:: bash

    $ ln -s local_production.cfg local.cfg

In ``local_production.cfg`` to select the parts you really need. A average project that uses haproxy, vanish and two zeoclients looks like this:

.. code-block:: ini

    parts +=
        ${buildout:zeo-ha-parts}
        ${buildout:nginx-parts}
        ${buildout:varnish-parts}
        ${buildout:supervisor-parts}
        ${buildout:cron-parts}
        backup
        logrotate
        precompiler

Also modify ``templates/supervisord.conf`` to have supervisor manage the parts you want to use.


Use for test-instances
----------------------

Create a copy of ``local_production.cfg`` called ``local_test.cfg`` and modify it according to your needs.

.. warning::

    If test runs on the same server as production:

    In this case you need a different name for the project on test. Otherwise one will overwrite the database of the other. Because of this the name of the project must **not** be set in ``buildout.cfg`` but in the ``local_*.cfg``-files.


Features
--------

Debugging and Development
+++++++++++++++++++++++++

packages
    All eggs of your buildout will be symlinked to in ``parts/packages``.

zopepy
    Run ``./bin/zopepy`` to have a python-prompt with all eggs of your buildout in its python-path.

checkversions
    Run ``./bin/checkversions floating_versions_project.cfg`` to check if your pinned eggs are up-to-date.

codeintel
    This part uses ``corneti.recipes.codeintel`` to prepare for codeintel-integration (useful for users of Sublime Text).

stacktrace
    The part ``stacktrace-script`` adds a bash-script ``./bin/stack.sh`` that will print the current stacktrace to stdout. Useful to find out what Plone is doing when it's busy.

code-analysis
    This installs a pre-commit-hook that runs the codeanalysis-tests from ``plone.recipe.codeanalysis``.

mrbob
    This part adds `bobtemplates.plone <https://github.com/collective/bobtemplates.plone>`_ to simplify the creation of new addons.

test
    Run tests for your test-eggs

coverage-test
    Generate coverage-reports for your test-eggs in parts/test/.


i18n
++++

Restrict loaded languages
    By default only german ('de') is loaded on startup. In your ``buildout.cfg`` you can override the loaded languages using ``language = de en fr``. This setting also affects the languages used in the ``i18nize-xxx`` part. (see http://maurits.vanrees.org/weblog/archive/2010/10/i18n-plone-4#restrict-the-loaded-languages)

i18nize-diff
    Show differences of the po files against what is currently in git.
    This script uses `podiff <https://pypi.python.org/pypi/podiff>`_ that filters out a lot of noise like creation dates and line numbers.
    So this output is much more usable.
    Use this script in jenkins together with i18nize-all to make sure that you po files are up to date.

i18nize-xxx
    Modify the commented-out part ``i18nize-xxx`` to get a script that runs i18ndude fro an egg. Here is an example for the egg ``dynajet.site`` adding a script ``./bin/i18nize-site``.

    .. code-block:: ini

        [i18nize-site]
        recipe = collective.recipe.template
        input = ${buildout:directory}/i18nize.in
        output = ${buildout:bin-directory}/i18nize-site
        mode = 775
        dollar = $
        domain = dynajet.site
        packagepath = ${buildout:directory}/src/dynajet.site/src/dynajet/site
        languages = ${buildout:languages}

i18nize-all
    This runs all i18nize commands for a package.


Testing
+++++++

Setup for gitlab-ci and jenkins
    Configure your ci-system to run the script ``./bootstrap_ci.sh``. This will configure and run the whole buildout.


Deployment
++++++++++

nginx
    TODO: Documentation

haproxy
    If you cannot use chroot to run haproxy as a isolated user you need to modify ``templates/haproxy.cfg`` like this:

    .. code-block::

        global
          maxconn 480
          user ${haproxy-conf:user}
          group ${haproxy-conf:group}
          daemon
          log 127.0.0.1 local2

varnish
    Up to Plone 4.3.3 we still use varnish 2. To use varnish 3 please modify your ``local_production.cfg`` like this:

    .. code-block:: ini

        [varnish]
        varnish_version = 3

        [varnish-config]
        input = templates/varnish_3x.vcl.in

    varnish 4: TODO. See https://github.com/plone/documentation/blob/master/manage/deploying/caching/varnish4.rst


monitoring
    Change the settings for ``maxram`` to have memmon restart an instance when it uses up to much memory.

Sentry logging
    Configure zeoclients to send tracebacks to Sentry in ``local_production.cfg`` by uncommenting it and adding a dsn. You also need to enable the egg ``raven``. Repeat for each zeoclient.

solr
    TODO: Not included yet.


Notes
-----

``local.cfg`` and ``secret.cfg`` must **never** be versioned. The file ``.gitignore`` in this buildout already prevent this.

It might feels weird that ``buildout.cfg`` loads ``local.cfg``, but this avoids some weird behavior of buildouts extends-feature.


To have different supervisor-configurations for test-servers by adding a file ``templates/supervisord-test.conf`` and referencing it in local_test.cfg:

.. code-block:: ini

    [supervisor-conf]
        input= ${buildout:directory}/templates/supervisord-test.conf

