#!/system/bin/sh
MODDIR=${0%/*}
[ -f "$MODDIR/disable" ] && exit 0
[ -f "$MODDIR/remove" ]  && exit 0

c=0
while [ "$(getprop sys.boot_completed)" != "1" ] && [ $c -lt 60 ]; do
    sleep 2
    c=$((c + 1))
done
sleep 5

RP=""
command -v resetprop >/dev/null 2>&1 && RP="resetprop"
[ -z "$RP" ] && [ -x /data/adb/ksu/bin/resetprop ] && RP="/data/adb/ksu/bin/resetprop"
[ -z "$RP" ] && [ -x /data/adb/magisk/magisk ]    && RP="/data/adb/magisk/magisk resetprop"

# Apply Screen Resolution (Fix Display Mismatch)
if [ -f "$MODDIR/ziuz/resolution.txt" ]; then
    RES=$(cat "$MODDIR/ziuz/resolution.txt")
    if [ "$RES" = "pix" ]; then
        wm size 1344x2992 >/dev/null 2>&1
        wm density 490 >/dev/null 2>&1
    elif [ "$RES" = "sam" ]; then
        wm size 1080x2340 >/dev/null 2>&1
        wm density 420 >/dev/null 2>&1
    else
        wm size reset >/dev/null 2>&1
        wm density reset >/dev/null 2>&1
    fi
fi

if [ -s "$MODDIR/system.prop" ] && [ -n "$RP" ]; then
    while IFS='=' read -r line; do
        case "$line" in ''|\#*) continue ;; esac
        k=${line%%=*}
        v=${line#*=}
        [ "$k" = "$line" ] && continue
        cur=$(getprop "$k" 2>/dev/null)
        [ "$cur" != "$v" ] && $RP "$k" "$v" >/dev/null 2>&1
    done < "$MODDIR/system.prop"
fi
exit 0
