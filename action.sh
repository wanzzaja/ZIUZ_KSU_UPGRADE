#!/system/bin/sh
MODDIR=${0%/*}
echo "ZIUZ STATUS"
echo "Model: $(getprop ro.product.model)"
echo "Brand: $(getprop ro.product.brand)"
echo "FP: $(getprop ro.build.fingerprint)"
echo "Serial: $(getprop ro.serialno)"
echo "Resolusi Script: $(cat $MODDIR/ziuz/resolution.txt 2>/dev/null)"
echo "Waktu Setup: $(cat $MODDIR/ziuz/.lastboot 2>/dev/null)"
