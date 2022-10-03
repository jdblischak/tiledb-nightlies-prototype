# Prototype for centralized nightly CI builds for TileDB

Name        | status  | version | last updated | downloads
----------- | ------- | ------- | ------------ | ---------
TileDB      | [![tiledb](https://github.com/jdblischak/tiledb-nightlies-prototype/workflows/tiledb/badge.svg)](https://github.com/jdblischak/tiledb-nightlies-prototype/actions/workflows/tiledb.yml) | [![version](https://anaconda.org/jdblischak/tiledb/badges/version.svg)](https://anaconda.org/jdblischak/tiledb) | ![last updated](https://anaconda.org/jdblischak/tiledb/badges/latest_release_date.svg) | ![downloads](https://anaconda.org/jdblischak/tiledb/badges/downloads.svg)
TileDB-Py   | [![tiledb-py](https://github.com/jdblischak/tiledb-nightlies-prototype/workflows/tiledb-py/badge.svg)](https://github.com/jdblischak/tiledb-nightlies-prototype/actions/workflows/tiledb-py.yml) | [![version](https://anaconda.org/jdblischak/tiledb-py/badges/version.svg)](https://anaconda.org/jdblischak/tiledb-py) | ![last updated](https://anaconda.org/jdblischak/tiledb-py/badges/latest_release_date.svg) | ![downloads](https://anaconda.org/jdblischak/tiledb-py/badges/downloads.svg)

## How it works

* The GitHub Actions workflows in the repository are scheduled run each night
  (they can also be manually triggered)

* The job clones both the TileDB-Inc fork of the feedstock repo and also the
  source repo

* The job updates the recipe (`meta.yaml`) to use the version string
  (X.X.X.YYYY_MM_DD), where X.X.X are derived from the source repo

* The job also updates the upload channels so that the conda binaries are
  uploaded to the tiledb channel on anaconda.org with the label "nightlies"
  (this prototype uploads to my personal channel
  [jdblischak][anaconda.org-tiledb]). It rerenders the feedstock with
  conda-smithy

    [anaconda.org-tiledb]: https://anaconda.org/jdblischak/tiledb/files?version=&channel=nightlies

* The job force pushes to the feedstock branch "nightly-build" to trigger Azure
  builds and uploads (this is made possible by manually configured SSH keys; see
  below)

## SSH keys

For each feedstock, generate a new SSH key pair:

1. Generate SSH keys on local machine. Hit enter twice to omit a password:

    ```sh
    mkdir /tmp/ssh-temp/
    ssh-keygen -t rsa -b 4096 -C "GitHub Actions for tiledb-nightlies" -f /tmp/ssh-temp/key
    head -n 1 /tmp/ssh-temp/key
    ## -----BEGIN RSA PRIVATE KEY-----
    ```

1. Add SSH private key (`/tmp/ssh-temp/key`) to tiledb-nightlies as a repository secret named
   `SSH_PRIVATE_KEY_<software>`:
    * Settings -> Secrets -> Actions -> New repository secret
    * Note: the name of the secret cannot included dashes (GitHub restriction)

1. Add SSH public key (`/tmp/ssh-temp/key.pub`) to TileDB-Inc fork of feedstock
   repository as a deploy key with write access:
    * Settings -> Deploy keys -> Add deploy key
    * Recommended to name it "tiledb-nightlies" to make the purpose of the key
      more obvious, but the name has no effect on functionality
    * Make sure to tick the box "Allow write access"!

1. Delete the keys locally. It's best practice to limit each key pair to only
   allow push access to a single repository, and regardless GitHub won't let you
   re-use them anyways

   ```sh
   rm -r /tmp/ssh-temp/
   ```
