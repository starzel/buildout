====================
The Starzel Buildout
====================

.. image:: https://github.com/starzel/buildout/actions/workflows/ci.yml/badge.svg
    :target: https://github.com/starzel/buildout/actions/workflows/ci.yml

This is a standard Plone-buildout of the company `Starzel.de <http://www.starzel.de>`_.

.. contents::


Main features
-------------

* It extends to config- and version-files on github shared by all projects that use the same version of Plone.
* It allows to update a project simply by changing the version it extends.
* It allows to update all projects of one version by changing remote files (very useful for HotFixes).
* It is minimal work to setup a new project.
* It has presets for development, testing, staging and production.
* It has all the nice development-helpers we use.


Quickstart
----------

.. code-block:: bash

    git clone https://github.com/starzel/buildout SOME_PROJECT
    cd SOME_PROJECT

Remove all files that are not needed for a project but are only used for the buildout itself.

.. code-block:: bash

    rm -rf linkto README.rst README.txt VERSION.txt local_coredev.cfg CHANGES.rst .github

If you're not developing the buildout itself you want a create a new git repo.

.. code-block:: bash

    rm -rf .git && git init

Add a file that contains a passwort. Do **not** use ``admin`` as a password in production!

.. code-block:: bash

    echo -e "[buildout]\nlogin = admin\npassword = admin" > secret.cfg

Symlink to the file that best fits you local environment. At first that is usually development. Later you can use production or test. This buildout only uses ``local.cfg`` and ignores all ``local_*.cfg``.

.. code-block:: bash

    ln -s local_develop.cfg local.cfg

Create a virtualenv in Python 2.7 or Python 3.7 (Plone 5.2 only).

.. code-block:: bash

    virtualenv .  # for Python 2.7
    python3.7 -m venv .  # for Python 3 (Plone 5.2 only)

Install and configure Plone

.. code-block:: bash

    ./bin/pip install -r requirements.txt
    ./bin/buildout

Install git pre-commit hooks

.. code-block:: bash

    ./bin/pre-commit install


Structure
---------

``buildout.cfg``
    This contains the project settings (name, addons, checkouts etc.). It also includes the remote ``base.cfg`` that is hosted on github like this:

    .. code-block:: ini

        extends = https://raw.githubusercontent.com/starzel/buildout/6.0.0/linkto/base.cfg

    This example refers to the tag 6.0.0 of this buildout that uses Plone 6.0.0 To use a different Plone-version simply change that to point to a different tag.

``local.cfg``
    For each environment (development, production, test) there is a separate ``local_*.cfg``-file. You create a *symlink*  called ``local.cfg`` to one of these files depending on your environment.

``base.cfg``
    This remote file conatains most of the commonly used logic used for prodcution. It also includes two version-files that are also hosted on github:

    * `pinned_versions.cfg <https://raw.githubusercontent.com/starzel/buildout/6.0.0/linkto/pinned_versions.cfg>`_: Pinns the Plone-version using http://dist.plone.org/release/6.0.0/versions.cfg
    * `floating_versions.cfg <https://raw.githubusercontent.com/starzel/buildout/6.0.0/linkto/floating_versions.cfg>`_: Pinns all commonly used addons of this buildout.

``pinned_versions_project.cfg``
    Here you pinn versions to overwrite or extend the hosted ``pinned_versions.cfg``. These eggs are usually pinned for a reason and are usually not safe to be upgraded.

``floating_versions_project.cfg``
    Here you overwrite and extend the hosted ``floating_versions.cfg``. These eggs should usually be safe to be upgraded. ``./bin/checkversions floating_versions_project.cfg`` will check pypi if there are newer releases for your pinned eggs.


Versions
--------

We support the following versions of Plone:

- `6.0.0 <https://raw.githubusercontent.com/starzel/buildout/6.0.0/linkto/base.cfg>`_ (Python 3)
- `6.0.0rc2 <https://raw.githubusercontent.com/starzel/buildout/6.0.0rc2/linkto/base.cfg>`_ (Python 3)
- `6.0.0rc1 <https://raw.githubusercontent.com/starzel/buildout/6.0.0rc1/linkto/base.cfg>`_ (Python 3)
- `6.0.0b3 <https://raw.githubusercontent.com/starzel/buildout/6.0.0b3/linkto/base.cfg>`_ (Python 3)
- `6.0.0b2 <https://raw.githubusercontent.com/starzel/buildout/6.0.0b2/linkto/base.cfg>`_ (Python 3)
- `6.0.0b1 <https://raw.githubusercontent.com/starzel/buildout/6.0.0b1/linkto/base.cfg>`_ (Python 3)
- `6.0.0a6 <https://raw.githubusercontent.com/starzel/buildout/6.0.0a6/linkto/base.cfg>`_ (Python 3)
- `6.0.0a4 <https://raw.githubusercontent.com/starzel/buildout/6.0.0a4/linkto/base.cfg>`_ (Python 3)
- `6.0.0a3 <https://raw.githubusercontent.com/starzel/buildout/6.0.0a3/linkto/base.cfg>`_ (Python 3)
- `6.0.0a2 <https://raw.githubusercontent.com/starzel/buildout/6.0.0a2/linkto/base.cfg>`_ (Python 3)
- `6.0.0a1 <https://raw.githubusercontent.com/starzel/buildout/6.0.0a2/linkto/base.cfg>`_ (Python 3)
- `5.2.10 <https://raw.githubusercontent.com/starzel/buildout/5.2.10/linkto/base.cfg>`_ (Python 2 and 3)
- `5.2.9 <https://raw.githubusercontent.com/starzel/buildout/5.2.9/linkto/base.cfg>`_ (Python 2 and 3)
- `5.2.8 <https://raw.githubusercontent.com/starzel/buildout/5.2.8/linkto/base.cfg>`_ (Python 2 and 3)
- `5.2.7 <https://raw.githubusercontent.com/starzel/buildout/5.2.7/linkto/base.cfg>`_ (Python 2 and 3)
- `5.2.6 <https://raw.githubusercontent.com/starzel/buildout/5.2.6/linkto/base.cfg>`_ (Python 2 and 3)
- `5.2.5 <https://raw.githubusercontent.com/starzel/buildout/5.2.5/linkto/base.cfg>`_ (Python 2 and 3)
- `5.2.4 <https://raw.githubusercontent.com/starzel/buildout/5.2.4/linkto/base.cfg>`_ (Python 2 and 3)
- `5.2.3 <https://raw.githubusercontent.com/starzel/buildout/5.2.3/linkto/base.cfg>`_ (Python 2 and 3)
- `5.2.2 <https://raw.githubusercontent.com/starzel/buildout/5.2.2/linkto/base.cfg>`_ (Python 2 and 3)
- `5.2.1 <https://raw.githubusercontent.com/starzel/buildout/5.2.1/linkto/base.cfg>`_ (Python 2 and 3)
- `5.2 <https://raw.githubusercontent.com/starzel/buildout/5.2/linkto/base.cfg>`_ (Python 2 and 3)
- `5.1.7 <https://raw.githubusercontent.com/starzel/buildout/5.1.7/linkto/base.cfg>`_
- `5.1.6 <https://raw.githubusercontent.com/starzel/buildout/5.1.6/linkto/base.cfg>`_
- `5.1.5 <https://raw.githubusercontent.com/starzel/buildout/5.1.5/linkto/base.cfg>`_
- `5.1.4 <https://raw.githubusercontent.com/starzel/buildout/5.1.4/linkto/base.cfg>`_
- `5.1.3 <https://raw.githubusercontent.com/starzel/buildout/5.1.3/linkto/base.cfg>`_
- `5.1.2 <https://raw.githubusercontent.com/starzel/buildout/5.1.2/linkto/base.cfg>`_
- `5.1.1 <https://raw.githubusercontent.com/starzel/buildout/5.1.1/linkto/base.cfg>`_
- `5.1 <https://raw.githubusercontent.com/starzel/buildout/5.1/linkto/base.cfg>`_
- `5.0.10 <https://raw.githubusercontent.com/starzel/buildout/5.0.10/linkto/base.cfg>`_
- `5.0.9 <https://raw.githubusercontent.com/starzel/buildout/5.0.9/linkto/base.cfg>`_
- `5.0.8 <https://raw.githubusercontent.com/starzel/buildout/5.0.8/linkto/base.cfg>`_
- `5.0.7 <https://raw.githubusercontent.com/starzel/buildout/5.0.7/linkto/base.cfg>`_
- `5.0.6 <https://raw.githubusercontent.com/starzel/buildout/5.0.6/linkto/base.cfg>`_
- `5.0.5 <https://raw.githubusercontent.com/starzel/buildout/5.0.5/linkto/base.cfg>`_
- `5.0.4 <https://raw.githubusercontent.com/starzel/buildout/5.0.4/linkto/base.cfg>`_
- `5.0.3 <https://raw.githubusercontent.com/starzel/buildout/5.0.3/linkto/base.cfg>`_
- `5.0.2 <https://raw.githubusercontent.com/starzel/buildout/5.0.2/linkto/base.cfg>`_
- `5.0 <https://raw.githubusercontent.com/starzel/buildout/5.0/linkto/base.cfg>`_
- `4.3.20 <https://raw.githubusercontent.com/starzel/buildout/4.3.20/linkto/base.cfg>`_
- `4.3.19 <https://raw.githubusercontent.com/starzel/buildout/4.3.19/linkto/base.cfg>`_
- `4.3.18 <https://raw.githubusercontent.com/starzel/buildout/4.3.18/linkto/base.cfg>`_
- `4.3.17 <https://raw.githubusercontent.com/starzel/buildout/4.3.17/linkto/base.cfg>`_
- `4.3.15 <https://raw.githubusercontent.com/starzel/buildout/4.3.15/linkto/base.cfg>`_
- `4.3.14 <https://raw.githubusercontent.com/starzel/buildout/4.3.14/linkto/base.cfg>`_
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

To use this buildout with a version of Plone that is currently in development (a.k.a. the `Coredev <https://github.com/plone/buildout.coredev/>`_) please use:

- ``local_coredev.cfg`` for `Plone 6.0.x <https://github.com/plone/buildout.coredev/tree/6.0>`

Please note that new features are not always introduced to old versions.

* Tags for development-versions (alpha, beta and rc) will exists but will be removed after the final release of that version.





Configuring a project
---------------------

``buildout.cfg`` contains the general project settings. Here you configure the name of the project, the eggs, source-checkouts and languages Plone will use.


Use in development
------------------

Symlink to the development-config:

.. code-block:: bash

    ln -s local_develop.cfg local.cfg

The development-setup will build a simple instance with some useful tools (see below). The setup assumes that zeo, varnish and loadbalancing are only configured on production.

Install git pre-commit hooks using the pre-commit tool that was installed via requirements.txt:

.. code-block:: bash

    ./bin/pre-commit install


Use in production
-----------------

Symlink to the production-config:

.. code-block:: bash

    ln -s local_production.cfg local.cfg

A average project could use this stack pipeline::

    nginx > varnish > nginx (for load-balancing) > at least 2 zeoclients > zeoserver

In ``local_production.cfg`` select the parts you really need.

.. code-block:: ini

    parts +=
        zeoserver
        ${buildout:zeoclients}
        zeoclient_debug
        ${buildout:cron-parts}
        varnish-config
        backup
        precompiler
        nginx-config
        site_unit

Note that ``site_unit`` is a part that creates a systemd service unit which
pulls in service units for zeoserver and any zeoclients you set up (see
below). Starting, restarting and stopping the site unit will start, restart
and stop, resp., the zeoserver and zeoclients. The site unit is the only
systemd unit in the deployment that needs to be enabled or disabled.

A note on security: The site unit may be used either as a system service or as
a user service. In the former case, you will want to set a service user and
group lest the service run as root, which it should never do. The unit
templates use the values of two buildout variables that you need to set in
your ``local_production.cfg``:

.. code-block::ini

    [buildout]
    service-user = plone
    service-group = plone

If you add any zeoclients, also add their partnames to buildout:zeoclients.
This is a list used in several places, e.g. to populate the dependencies of
the main systemd service for the site.

.. code-block:: ini

    zeoclients +=
        zeoclient2

A note on the execution environment of the processes: In order to have
zeoserver and zeoclients run in the environment of the service user they run
as, the systemd services need to be executed by a shell that has those
environments loaded. This is what the ``run.sh`` script is about; see the
comments within the script for details.


Activate the systemd services
+++++++++++++++++++++++++++++

The service units files are generated in ``etc/`` you can symlink all files to ``~/.config/systemd/user/`` and use ``systemctl --user daemon-reload``. Services can be managed with ``systemctl --user restart www-zeoserver.service``.


Server stack
++++++++++++

``Frontend webserver (Nginx)``
    The first Nginx manages the virtualhost, does url rewrites if needed and terminates the SSL (needs to be done before varnish).

    A full demo-config with ssl and redirects can be found in this repo in `/templates/demo_nginx.conf <https://github.com/starzel/buildout/blob/master/templates/demo_nginx.conf>`_.

    A minimal config without ssl can be found in the `demo.plone.de project <https://github.com/collective/demo.plone.de/blob/master/templates/demo.plone.de.conf>`_.

    More information can also be found in the `PloneDocs <https://docs.plone.org/manage/deploying/front-end/nginx.html#minimal-nginx-front-end-configuration-for-plone-on-ubuntu-debian-linux>`_

``Cache (Varnish)``
    After nginx we use varnish to cache the site. You can activate it like this:

    .. code-block:: ini

        parts +=
            ...
            varnish-config
            ...

    Take a look in ``linkto/base.cfg`` for the varnish-config part, there are several switches to configure.

    It is best practice to install varnish from your distribution repository.
    If you need to build varnish (e.g. because your system does not ship with the version you need), see `plone.recipe.varnish <https://github.com/collective/plone.recipe.varnish#build-varnish-from-sources/>`_.
    The same recipe that we use to configure varnish can also be used to build it.

    If you use the system-varnish only need the ``[varnish-config]`` part, it will generate the config (vcl) for you. In ``/etc/varnish/default.vcl`` include the generated vcl:

    .. code-block:: ini

        vcl 4.0;

        include "<path to your buildout>/etc/varnish.vcl";

    A ``systemctl restart varnish`` should activate the new config. To use one varnish installation with serveral vhosts, see the ``Varnish with multiple sites`` section below.

``Loadbalancer (Nginx)``
    Another Nginx spreads the requests to several Zeoclients, here is a minimal config. In production you can look at the `demo.plone.de project <https://github.com/collective/demo.plone.de/blob/master/templates/demo.plone.de.conf>`_

    .. code-block:: ini

        # starzel (zeoclients)
        upstream starzel_zeoclients {
            ip_hash;
            server 127.0.0.1:8082;
            server 127.0.0.1:8083;
            server 127.0.0.1:8084;
            }

    The ``ip_hash`` option is needed for multiple Zeoclients, more information can be found in this `issue <https://github.com/collective/plone.recipe.varnish/issues/37>`_

    The ip and port has to be the same as the settings for the zeoclients in then part ``[bindips]`` and ``[ports]``.

Varnish with multiple sites
+++++++++++++++++++++++++++

The generated varnish config works with a single vhost, for multiple sites/domains we need a custom varnish config. This configuration is not yet build into the buildout script/template, we need to do the changes manually in a copy of a varnish config file (just copy the varnis4.vcl over to /etc/varnish and include it in default.vcl).

In the varnish.vcl we need to add the additional backend, note the different loadbalancer port.

.. code-block:: ini

    backend 001 {
       .host = "localhost";
       .port = "8091";
       .connect_timeout = 0.4s;
       .first_byte_timeout = 300s;
       .between_bytes_timeout  = 60s;
    }

    backend 002 {
       .host = "localhost";
       .port = "8081";
       .connect_timeout = 0.4s;
       .first_byte_timeout = 300s;
       .between_bytes_timeout  = 60s;
    }

In ``sub vcl_recv`` we remove the backend (set req.backend_hint = backend_000;) and add this switch:

.. code-block:: ini

    if (req.http.host == "my_host") {
        set req.backend_hint = 001;
    }
    else {
        set req.backend_hint = 002;
    }

This does the vhost routing to the different backends. "my_host" is the upstream name of the cache, see the config of `demo.plone.de project <https://github.com/collective/demo.plone.de/blob/master/templates/nginx.conf>`_. The Varnish config can be tested with this command: ``varnishd -C -f /etc/varnish/default.vcl``



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

stacktrace
    The part ``stacktrace-script`` adds a bash-script ``./bin/stack.sh`` that will print the current stacktrace to stdout. Useful to find out what Plone is doing when it's busy.

    This was removed in 5.2.2 because it only works with ZServer (i.e. in Python 2). Use https://pypi.org/project/py-spy/ instead.

pre-commit
    This installs a pre-commit-hook that runs several code analysis tests including black.

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

Setup for gitlab-ci
    The config ``local_ci.cfg`` can be used by your ci-system to run the buildout.


Deployment
++++++++++

monitoring
    Change the settings for ``maxram`` to have memmon restart an instance when it uses up to much memory.

Sentry logging
    Configure zeoclients to send tracebacks to Sentry in ``local_production.cfg`` by uncommenting it and adding a dsn. You also need to enable the egg ``raven``. Repeat for each zeoclient.


Hotfixes
++++++++

This buildout automatically includes the correct Hotfixes for the version of Plone you use. E.g. the extends-file for Plone 5.0.6 https://raw.githubusercontent.com/starzel/buildout/5.0.6/linkto/base.cfg pulls in the file https://raw.githubusercontent.com/starzel/buildout/master/linkto/hotfixes/5.0.6.cfg which in turn contains the pinns and eggs for all HotFixes for that version.

By having the hotfixes-files in the master-branch we can easily update Hotfixes for each version without having to move any tags. The same day a Hotfix is published the corresponding extends-files will be updated. You simply have to rerun buildout and restart your site to include them.


Notes
-----

``local.cfg`` and ``secret.cfg`` must **never** be versioned. The file ``.gitignore`` in this buildout already prevent this.

It might feel weird that ``buildout.cfg`` loads ``local.cfg``, but this avoids some weird behavior of buildouts extends-feature.
