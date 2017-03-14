[![Build Status](https://travis-ci.org/danvaida/ansible-role-deluge.svg?branch=master)](https://travis-ci.org/danvaida/ansible-role-deluge)
[![Galaxy](https://img.shields.io/ansible/role/14358.svg)](https://galaxy.ansible.com/danvaida/deluge/)

# Ansible Deluge role

Installs and configures Deluge BitTorrent client.

## Caveat

Deluge is saving its configuration to files. You should be aware that
templating these config files and then changing the configuration in a
different way (through Web UI or `deluge-console`), is breaking the
idempotence of this role.

## Requirements

* __salted_sha1__
  A simple Ansible filter plugin that outputs salted SHA1-encrypted passwords.

    {{ password | salted_sha1('salt_goes_here') }}

## Role Variables

Do not keep the passwords in plain-text. Use `ansible-vault` for encryption.

* __deluge_users_to_add:__
  List of users to add to the `auth` file of Deluge.
  <http://dev.deluge-torrent.org/wiki/UserGuide/Authentication>

* __deluge_users_to_remove:__
  List of users to remove from the `auth` file of Deluge.

* __deluge_config_dir:__
  Path to the dir holding the configuration files and directories.

* __deluge_web:__
  Binary switch for setting up and configuring Deluge's Web UI.

* __deluge_web_port:__
  Port on which Deluge's Web UI is listening.

* __deluge_web_log_level:__
  Log level for the UI. See available options with `deluge-web --help`.

* __deluge_web_daemon_args:__
  Arguments passed to the `deluge-web` binary that's running as a service.
  See available options with `deluge-web --help`.

* __deluge_web_password:__
  Password to be used for the Web UI.

* __deluge_web_password_salt:__
  Password salt used when generating the Web UI password.

The options above are more system-related, whereas the following options
are specific to how Deluge is operating. Check `defaults/main.yml` for
the default values and the [official docs](http://dev.deluge-torrent.org/wiki/UserGuide) to learn more.

* __deluge_allow_remote:__
* __deluge_autoadd_location:__
* __deluge_download_location:__
* __deluge_move_completed_path:__
* __deluge_prioritize_first_last_pieces:__
* __deluge_queue_new_to_top:__
* __deluge_torrentfiles_location:__

## Dependencies

None.

## Example playbook

    - hosts: raspberrypi
      gather_facts: False
      become: True
      roles:
        - role: deluge
          deluge_web: False
          deluge_users_to_add:
            - name: userone
              password: 12345
              access_level: 10
            - name: usertwo
              password: 67890
              access_level: 5
          deluge_users_to_remove:
            - usertwo
          deluge_download_location: '/mnt/storage/disk'

## Testing

If you want to run the tests on the provided Docker environment, run the
following commands:

    $ cd /path/to/ansible-role-deluge
    $ docker build -t ansible-role-deluge tests/support
    $ docker run -it -v $PWD:/role ansible-role-deluge
    $ docker run -it -v $PWD:/role --env EXTRA_VARS='deluge_web=False' ansible-role-deluge

## To do

* Add support for HTTPS
* Switch from init.d scripts to systemd
* Run the `deluged` and `deluge-web` services in Docker containers
* Refactor the `salted_sha1.py` filter plugin

## Contributing

Follow the "fork-and-pull" Git workflow.

1. Fork the repo on GitHub
2. Clone the project to your own machine
3. Commit changes to your own branch
4. Push your work back up to your fork
5. Submit a Pull request so that we can review your changes

NOTE: Be sure to merge the latest from "upstream" before making a pull request!

## License

BSD
