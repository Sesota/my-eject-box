#!/bin/sh
# Get standard cali USER_ID variable
USER_ID=${HOST_USER_ID}
GROUP_ID=${HOST_GROUP_ID}
# Change 'me' uid to host user's uid
if [ ! -z "$USER_ID" ] && [ "$(id -u me)" != "$USER_ID" ]; then
    # Create the user group if it does not exist
    groupadd --non-unique -g "$GROUP_ID" group
    # Set the user's uid and gid
    usermod --non-unique --uid "$USER_ID" --gid "$GROUP_ID" me
fi
# Setting permissions on /home/me
chown -R me: /home/me
# exec /sbin/su-exec me tmux -u -2 "$@"
exec /sbin/su-exec me
