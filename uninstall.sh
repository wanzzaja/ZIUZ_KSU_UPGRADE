#!/system/bin/sh
MODDIR=${0%/*}
if [ -f "$MODDIR/.bak/ORIGINAL.prop" ]; then
    mkdir -p /data/adb/ziuz 2>/dev/null
    cp -f "$MODDIR/.bak/ORIGINAL.prop" /data/adb/ziuz/ORIGINAL.prop 2>/dev/null
fi
rm -f /data/adb/ziuz_moddir 2>/dev/null
exit 0
