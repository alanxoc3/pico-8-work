#!/bin/sh
# Hits pokeapi to get moves for all pokemon.

for i in $(seq 1 151); do
    echo PKMN "$i"
    curl https://pokeapi.co/api/v2/pokemon/"$i" 2>/dev/null | jq -c '.moves[] | select(.version_group_details[] | select(.version_group.name == "red-blue" or .version_group.name == "yellow")) | {move: .move.name, method: .version_group_details[] | select(.version_group.name == "red-blue" or .version_group.name == "yellow")} | {move: .move, level: .method.level_learned_at, method: .method.move_learn_method.name}'
    echo
done
