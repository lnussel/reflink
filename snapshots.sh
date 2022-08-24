#!/bin/bash

init_snapshots()
{
	if [ -n "$SNAPSHOT" ] && [ -n "$SUBVOL" ]; then
		return
	fi

	mountpoint -q /usr && [ -x /sbin/btrfs ] && [ "$(stat -f -c %T /usr)" = "btrfs" ] || return

	read -r SUBVOL < <(/sbin/btrfs subvol show /usr | head -1)
	SNAPSHOT="${SUBVOL##*@}"
}
