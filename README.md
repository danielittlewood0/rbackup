# rbackup
rsync-based backup scripts

## Installation

In order to install, the scripts must all be accessible on your PATH.
Under the assumption that $HOME/bin is on your PATH, the included script
rbackup-install will set up hard links. For example,

```bash
git clone git@github.com:danielittlewood0/rbackup.git
cd rbackup
./rbackup -- install
```

Since it sets up hard links, you can remove the source dir now if you want.

## Configuration

In order to run rbackup, you have to provide some information.

* source: Location to be backed up.
* destination: Location to store snapshots.
* remote: Location to store archives.
* excludes: space-separated list of patterns to exclude from the snapshot.

`source` and `location` are presumed to be on the local filesystem (given
absolute paths). `destination` can be either local or remote. `excludes` is
optional, and present to keep backups lean - you can use it to exclude cache
files, for example. If the `source` contains `destination`, then that will be
excluded automatically (so you don't back up your backups).

The configuration file is created by `rbackup-install`, and the default
location is `$HOME/.config/rbackup/rbackup.ini`. You can change it in the main
`rbackup` script if you want.

```ini
[home]
source = /home/you
destination = /home/you/.data/rbackup/you
remote = cloud-storage.xyz:/home/private/you
recipient = you@email.com
excludes = node_modules .cache cache* Cache* tmp .rbenv .npm Trash
```

Usage:
* rbackup snapshot: Snapshot your directory $BACKUP_SRC
* rbackup archive: Bundle your existing snapshots into a tarball
* rbackup push: Push your existing archives to a remote
* rbackup pull [$1]: Pull down a specific archive (or list all remote archives)
* rbackup extract [$1]: Extract a tarball into snapshots (or list all local archives)
* rbackup restore [$1]: Restore a snapshot to $BACKUP_SRC (or list all available snapshots)
