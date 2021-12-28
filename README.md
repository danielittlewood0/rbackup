# rbackup
rsync-based backup scripts, [implementing a strategy from Anouar Adlani](https://anouar.adlani.com/2011/12/how-to-backup-with-rsync-tar-gpg-on-osx.html).

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

## Usage

The invocation of rbackup generally takes the form

```
rbackup <name> <action> args
```

where `<name>` is the name assigned in `rbackup.ini` (`home`) in the example
above, and `action` is one of the following.

* `rbackup <name> snapshot`: Produces an incremental snapshot of the config
  entry `name`.  When run for the first time, it will produce a full copy at
  the location `destination`.  On subsequent invocations, unchanged files will
  be referred to with a hard link.  Snapshots are stored in a directory
  `snapshots` relative to `destination`.

* `rbackup <name> archive`: Bundle all existing snapshots into an archive.  If
  a recipient is provided, it will be passed to gpg as the ID used for
  encryption.  Archives are stored in a directory `archives` relative to
  `destination`.

* `rbackup <name> push`: Push all archives to a location. This is expected to
  be remote, but can be a local directory (a mounted hard drive, for example).

* `rbackup <name> pull [$1]`: With no arguments, shows all the remote archives
  available.  If the relative path of an archive is provided as argument, that
  archive will be downloaded to the local `archives` directory.

* `rbackup <name> extract [$1]`: With no arguments, shows all archives
  available to be extracted.  If a relative path is provided as argument, it
  will extract the provided archive to `snapshots.restore`.  (this keeps any
  background processes from interfering with the restore).

* `rbackup <name> restore [$1]`: With no arguments, shows all snapshots in
  `snapshots` or `snapshots.restore`.  If a relative path is provided, the live
  directory will be refreshed from the snapshot.  The restore is only additive
  - if new files have been added, they won't be removed.

* `rbackup <name> clean [dir]`: With no arguments, cleans all snapshots and
  archives for `<name>` from the system. If a relative path is provided, then
  only that will be deleted. For example, to abort a restore, you can run
  `rbackup <name> clean snapshots.restore`.

Any remote data transfer will be done via ssh, so non-interactive access will
require paswordless authentication to be configured. Similarly with decryption,
it is expected that a passphrase will be used interactively for unpacking
archives.

## Scheduling

Scheduling has been tested with cron and anacron, in user mode. For help
setting up anacron in user mode, see [Alexander Keil's
article](http://akeil.net/posts/user-controlled-anacron.html).

As an example, I snapshot my home directory hourly, and push an archive once a week. Hence,
I have:

```
$ tree ~/.config/anacron/
/home/daniel/.config/anacron/
├── anacrontab
├── cron.daily
├── cron.hourly
│   └── rbackup-home
├── cron.monthly
└── cron.weekly
    └── rbackup-archive-home

$ cat ~/.config/anacron/cron.hourly/rbackup-home
#!/bin/bash

rbackup home snapshot

$ cat ~/.config/anacron/cron.weekly/rbackup-archive-home
#!/bin/bash

rbackup home archive && rbackup home push
```

### Disk usage

Given a source to back up of total size X, a snapshot directory consumes about
X, and each standalone archive also consumes X. So you naively need around 3X
space on your drive to avoid running out. By passing --remove-files to tar, we
can get away with somewhere between 2X and 3X.  Exactly how much depends on how
large your files are.

## Snapshot on file change

If you prefer, you can watch for certain events, and create a snapshot whenever
a directory changes. One could call the following in a loop, for example:

```
inotifywait -r -e modify -e move -e delete ~/bin && rbackup bin snapshot
```

A user interested in this approach should check out [incron](http://inotify.aiken.cz/?section=incron&page=about&lang=en).
