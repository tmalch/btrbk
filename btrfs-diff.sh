#!/bin/bash
usage() { echo $@ >&2; echo "Usage: $0 <older-snapshot> <newer-snapshot>" >&2; exit 1; }

[ $# -eq 2 ] || usage "Incorrect invocation";
SNAPSHOT_OLD=$1;
SNAPSHOT_NEW=$2;

[ -d $SNAPSHOT_OLD ] || usage "$SNAPSHOT_OLD does not exist";
[ -d $SNAPSHOT_NEW ] || usage "$SNAPSHOT_NEW does not exist";

OLD_TRANSID=`btrfs subvolume find-new "$SNAPSHOT_OLD" 9999999`
OLD_TRANSID=${OLD_TRANSID#transid marker was }
[ -n "$OLD_TRANSID" -a "$OLD_TRANSID" -gt 0 ] || usage "Failed to find generation for $SNAPSHOT_NEW"

btrfs subvolume find-new "$SNAPSHOT_NEW" $OLD_TRANSID | sed '$d' | cut -f17- -d' ' | sort | uniq
