Changes

3.3
===
- Add 5.0.3-pending
- Add 4.3.8
- Add 5.0.2
- Add Hotfixes
- Add 5.0
- Add 5.0rc1 [pbauer]
- Test 5.0b4 [pbauer]
- Add tag for 5.0b3, bump some version [pbauer]
- Add branch for Plone 5 and tags for 5.0a3, 5.0b1 and 5.0b2-pending [pbauer]
- Add local_coredev.cfg to develop against the coredev for Plone 5 [pbauer]
- Rename omelette to packages [pbauer]
- Add part mrbob for mr.bob and bobtemplates.plone [pbauer]
- Move code-analysis to local_develop.cfg [pbauer]

3.2.2
=====
- Bugfixes for local_jenkins [pbauer]
- Use Plone 4.3.4 [pbauer]

3.2.1
=====
- Bugfix in jenkins test script. Update local_jenkins.cfg [do3cc]

3.2
===
- Add a jenkins bootstrap script. No more complex jenkins configs [do3cc]
- Renamed test to jenkins [do3cc]
- Added code-analysis to jenkins and develop. Update accordingly [do3cc]
- Add optional config for varnish 3.x [pbauer]
- Fix language-setting not being used (also backported to 4.3.3.x) [pbauer]
- Add documentation [pbauer]
- Add i18nize-all command to [do3cc]
- Documentation

3.1 (unreleased)
================
- No more auto-checkout
- Add Version information for the files that get copied [do3cc]

3.0 (unreleased)
================
- rearrange folder-structure to work ootb [pbauer]
- fix zcml- and egg-inheritance [pbauer]
- add empty pinned- and floating-versions to overwrite the hosted files [pbauer]

2.0 (unreleased)
================
- removed user feature. Zope won't sudo [do3cc]
- Added varnish haproxy [do3cc]

1.0 (unreleased)
================
- Initial import from the old repo, where it was meant to be imported [do3cc]
- WARNING: We use the new backup script, we activated some settings
  that make packing the database a requirement [do3cc]
- You can still set a user, but this is basically unsupported [do3cc]
- Production does not allow unpinned eggs any longer [do3cc]


Migration
---------
- Add the version file to the project.
- Ensure that starzel_buildout gets checked out, so that you can
  compare stock config with customized site-config
- The sentry settings are only in parts commented out. Double check
  that your configuration is complete.
