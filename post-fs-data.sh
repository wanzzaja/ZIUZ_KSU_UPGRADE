#!/system/bin/sh
MODDIR=${0%/*}
[ -f "$MODDIR/disable" ] && exit 0
[ -f "$MODDIR/remove" ]  && exit 0

RP=""
command -v resetprop >/dev/null 2>&1 && RP="resetprop"
[ -z "$RP" ] && [ -x /data/adb/ksu/bin/resetprop ] && RP="/data/adb/ksu/bin/resetprop"
[ -z "$RP" ] && [ -x /data/adb/magisk/magisk ]    && RP="/data/adb/magisk/magisk resetprop"
[ -z "$RP" ] && exit 0

DF="--delete"
$RP --delete ziuz.probe.nonexistent >/dev/null 2>&1 || DF="-d"

scrub_file() {
    [ ! -f "$1" ] && return
    while IFS= read -r p; do
        case "$p" in ''|\#*) continue ;; esac
        p=$(echo "$p" | tr -d ' \t\r')
        [ -z "$p" ] && continue
        $RP $DF "$p" >/dev/null 2>&1 || $RP "$p" "" >/dev/null 2>&1
    done < "$1"
}

scrub_file "$MODDIR/ziuz/leaklist.txt"
scrub_file "$MODDIR/ziuz/extra_leaks.txt"

if [ -f "$MODDIR/ziuz/identity.prop" ]; then
    while IFS='=' read -r k v; do
        case "$k" in ''|\#*) continue ;; esac
        [ -z "$k" ] && continue
        [ "$k" = "$line" ] && continue
        $RP "$k" "$v" >/dev/null 2>&1
    done < "$MODDIR/ziuz/identity.prop"
fi

echo "$(date '+%Y-%m-%d %H:%M:%S' 2>/dev/null)" > "$MODDIR/ziuz/.lastboot" 2>/dev/null
exit 0
