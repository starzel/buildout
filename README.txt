Usage
*****

This is a standard buildout to referenced via http url. It contains some reusable standards.

To start a new project check out the version you want from github. 

You can delete the "linkto" directory. It's files are used via links to github and can be deleted locally. 

You can either create symlink from local_production.cfg to local.cfg,
or you create a local.cfg which extends local_develop.cfg.
copy secret.cfg_tmpl to secret.cfg and modify as needed.
If you symlink local_production.cfg, you must still modify it to choose
the parts you really need. Especially if you want to use ha zeo or
single zeo client. Also, if you use local_production.cfg, you must
modify templates/supervisord.conf

local.cfg and secret.cfg must not be versioned.

project.cfg contains the project settings, equal for each environment. Please create a buildout.cfg symlink pointing to project.cfg

It feels weird that project.cfg loads local.cfg, but this avoids some weird extends behavior of buildout.
