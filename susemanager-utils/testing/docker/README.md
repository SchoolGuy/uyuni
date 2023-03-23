# Docker testing images

> When talking about OBS for Uyuni in this document we als see this as a synonym for the IBS.

## Architecture

The docker images are now maintained at OBS, at the subproject `:Docker` for the
corresponding codestream.

For example, for Uyuni they are available at:

https://build.opensuse.org/project/show/systemsmanagement:Uyuni:Master:Docker

The images are responsible for containing as much of the setup for a test run as possible. Their target is to test the
RPMs that we build in the OBS for the corresponding product.

Ideally the shell scripts present in the `scripts` subdirectory should just choose the right container and execute the
tests. The scripts are also responsible for mounting the reports folder to the correct location. 

## cobbler

This executes the Cobbler upstream pytest testsuite.

Images can be found at:

- `registry.suse.de/devel/galaxy/manager/head/docker/containers/suma-head-cobbler`
- `registry.opensuse.org/systemsmanagement/uyuni/master/docker/containers/uyuni-master-cobbler`
