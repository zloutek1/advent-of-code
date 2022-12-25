# trim
execute as @e[nbt={ArmorItems: [{ tag: { ascii: 10 } }]}] run kill @s
execute as @e[nbt={ArmorItems: [{ tag: { ascii: 0 } }]}] run kill @s

# store values in table
execute as @e[tag=input] store result score @s values run data get entity @s ArmorItems[3].tag.ascii
execute as @e[tag=input] run scoreboard players operation @s values -= ord('0') numbers

# calculate all the lows
execute as @e[tag=input] at @s run function part1:is_low

# calculate the total risk
scoreboard players set risk_total vars 0
execute as @e[tag=lowest] run scoreboard players operation risk_total vars += @s lows
execute as @e[tag=lowest] run scoreboard players operation risk_total vars += 1 numbers
execute as @e[tag=lowest] run effect give @s glowing 999 1

# print result
data merge block 8 4 8 {Text1:'["",{"text":"[Part1]","color":"gold"},{"text":" "},{"score":{"name":"risk_total","objective":"vars"}}]'}
data modify entity @e[tag=result_printer,limit=1] CustomName set from block 8 4 8 Text1
say @e[tag=result_printer,limit=1]