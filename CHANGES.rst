Changes

1.0 (unreleased)
================
- Initial import from the old repo, where it was meant to be imported [do3cc]
- WARNING: We use the new backup script, we activated some settings
  that make packing the database a requirement [do3cc]
- You can still set a user, but this is basically unsupported [do3cc]
- Production does not allow unpinned eggs any longer [do3cc]

2.0 (unreleased)
================
- removed user feature. Zope won't sudo [do3cc]
- Added varnish haproxy [do3cc]

3.0 (unreleased)
================
- rearrange folder-structure to work ootb [pbauer]
- fix zcml- and egg-inheritance [pbauer]
- add empty pinned- and floating-versions to overwrite the hosted files [pbauer]

