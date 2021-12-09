# count the basin size into TEMP
execute as @e[tag=visited] if score @s basins = count basin_counter run scoreboard players add TEMP basin_counter 1

# move the TEMP to lowest
execute as @e[tag=lowest] if score @s basins = count basin_counter run scoreboard players operation @s basin_counter = TEMP basin_counter

# cleanup
scoreboard players reset TEMP basin_counter
scoreboard players remove count basin_counter 1

# continue
execute if score count basin_counter > 0 numbers run function part2:count_basin_sizes
