# rbackup
rsync-based backup scripts

Usage:
* Define environment in ./rbackup (later: move into config files)
* rbackup snapshot: Snapshot your directory $BACKUP_SRC
* rbackup archive: Bundle your existing snapshots into a tarball
* rbackup push: Push your existing archives to a remote
* rbackup pull [$1]: Pull down a specific archive (or list all remote archives)
* rbackup extract [$1]: Extract a tarball into snapshots (or list all local archives)
* rbackup restore [$1]: Restore a snapshot to $BACKUP_SRC (or list all available snapshots)
