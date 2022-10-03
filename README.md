# Prototype for centralized nightly CI builds for TileDB


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
