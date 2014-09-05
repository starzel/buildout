Usage
*****

This is a standard buildout of starzel.de. It extends to files on github shared by all projects of the same version of Plone like this:

.. code-block:: ini

    extends =
        https://raw.githubusercontent.com/starzel/buildout/4.3.3/linkto/base.cfg

Features:

* It allows to update a project simply by changing the version it extends.
* It allows to update all projects of one version by changing remote files (very useful for HotFixes).
* It is minimal work to setup a new project.
* It has presets for development, testing, staging and production.
* It has all the nice development-helpers we use.


Setting up a new project
------------------------

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
    $ ./bin/pip install -U setuptools
    $ ./bin/python bootstrap.py
    $ ./bin/buildout


Configuring a project
---------------------

``buildout.cfg`` contains the project settings, equal for each environment.

Here you configure the name of the project, the eggs and checkouts Plone will use.


Use in production
-----------------

Symlink to the production-config:

.. code-block:: bash

    $ ln -s local_production.cfg local.cfg

In ``local_production.cfg`` to select the parts you really need. Especially if you want to use haproxy, zeo or
single zeo client.

Also modify ``templates/supervisord.conf`` to have supervisor manage the parts you want to use.

``local.cfg`` and ``secret.cfg`` must **never** be versioned.

Notes
-----

It feels weird that buildout.cfg loads local.cfg, but this avoids some weird extends behavior of buildout.

The configuration assumes that nginx is configured on production only and also contains configuration for the test environment

You can have different supervisor-configurations for test-servers by adding a file ``templates/supervisord-test.conf`` and referencing it in local_test.cfg:

.. code-block:: ini

    [supervisor-conf]
        input= ${buildout:directory}/templates/supervisord-test.conf
