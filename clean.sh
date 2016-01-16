#! /bin/bash 

cd $SERVER/tf2/tf/maps

MAPS_KEEP=("cp_badlands.bsp" "cp_gravelpit.bsp" "cp_granary.bsp" "cp_gullywash_final1.bsp" "cp_process_final.bsp" "cp_snakewater_final1.bsp" "cp_steel.bsp" "koth_lakeside_final.bsp" "pl_badwater.bsp" "pl_borneo.bsp" "pl_upward.bsp")
MAPS_ALL=( $(find -type f -name "*.bsp" -printf "%f\n") )

# MAPS_DELETE=($(diff MAPS_ALL[@] MAPS_KEEP[@]))
MAPS_DELETE=$(echo ${MAPS_ALL[@]} ${MAPS_KEEP[@]} | tr ' ' '\n' | sort | uniq -u)

rm ${MAPS_DELETE[@]}