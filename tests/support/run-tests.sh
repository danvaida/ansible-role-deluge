#!/bin/bash

[ -z "$EXTRA_VARS" ] && export EXTRA_VARS='foo=bar'

IFS=','
vars=$(for var in $EXTRA_VARS; do echo -n "--extra-vars $var "; done)

cd /role/tests

set -e
command="ansible-playbook test_addition.yml `echo $vars`"
eval $command

# running a second time to verify playbook's idempotence
set +e
eval $command > /tmp/second_run.log
{
    cat /tmp/second_run.log | tail -n 5 | grep 'changed=0' &&
    echo 'Playbook is idempotent'
} || {
    cat /tmp/second_run.log
    echo 'Playbook is **NOT** idempotent'
    exit 1
}

set -e
command="ansible-playbook test_removal.yml `echo $vars`"
eval $command

# running a second time to verify playbook's idempotence
set +e
eval $command > /tmp/second_run.log
{
    cat /tmp/second_run.log | tail -n 5 | grep 'changed=0' &&
    echo 'Playbook is idempotent'
} || {
    cat /tmp/second_run.log
    echo 'Playbook is **NOT** idempotent'
    exit 1
}
