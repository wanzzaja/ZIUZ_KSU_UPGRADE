#!/system/bin/sh
MODDIR=${0%/*}
[ -f "$MODDIR/disable" ] && exit 0
RP=""
command -v resetprop >/dev/null 2>&1 && RP="resetprop"
[ -z "$RP" ] && [ -x /data/adb/ksu/bin/resetprop ] && RP="/data/adb/ksu/bin/resetprop"
[ -z "$RP" ] && exit 0
DF="--delete"
$RP --delete ziuz.probe.nonexistent >/dev/null 2>&1 || DF="-d"
for f in "$MODDIR/ziuz/leaklist.txt" "$MODDIR/ziuz/extra_leaks.txt"; do
    [ ! -f "$f" ] && continue
    while IFS= read -r p; do
        case "$p" in ''|\#*) continue ;; esac
        p=$(echo "$p" | tr -d ' \t\r')
        [ -n "$(getprop "$p" 2>/dev/null)" ] && { $RP $DF "$p" >/dev/null 2>&1 || $RP "$p" "" >/dev/null 2>&1; }
    done < "$f"
done
exit 0
