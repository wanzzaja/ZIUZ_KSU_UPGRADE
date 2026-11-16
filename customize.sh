#!/system/bin/sh
SKIPMOUNT=false
PROPFILE=true
POSTFSDATA=true
LATESTARTSERVICE=true

ui_print "  ╔══════════════════════════════════════════╗"
ui_print "  ║   ZIUZ SPOOF ENGINE  •  v5.2 MAXED-OUT   ║"
ui_print "  ╚══════════════════════════════════════════╝"

set_perm_recursive "$MODPATH" 0 0 0755 0644
set_perm "$MODPATH/post-fs-data.sh"   0 0 0755
set_perm "$MODPATH/service.sh"        0 0 0755
set_perm "$MODPATH/boot-completed.sh" 0 0 0755
set_perm "$MODPATH/action.sh"         0 0 0755
set_perm "$MODPATH/uninstall.sh"      0 0 0755
set_perm "$MODPATH/system.prop"       0 0 0644

mkdir -p "$MODPATH/ziuz"
echo "$MODPATH" > /data/adb/ziuz_moddir 2>/dev/null
ui_print "  - Modul terpasang. Jalanin script buat spoof."
