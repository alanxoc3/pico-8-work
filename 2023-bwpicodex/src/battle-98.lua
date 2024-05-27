|[f_create_active]| function(team, ind)
  return setmetatable(f_zobj([[
    spot,@,
    stages,#
  ]], ind), {__index=team[ind]})
end $$

|[f_create_player]| function(team, name)
  local active = nil -- active guaranteed to be set because we can't enter the battle without it.
  for i=1,6 do
    if team[i].valid then
      active = f_create_active(team, i)
      break
    end
  end

  return f_zobj([[
    active,@,
    team,@,
    name,@,
    actions,#
  ]], active, team, name)
end $$

-- This function creates the player objects that are considered as globals throughout the fight. Called at the beginning of a battle.
-- Team can be any length up to 252 (horde mode). First six slots must have at least 1 Pokemon.
|[f_start_battle]| function(team1_name, team2_name, team1, team2)
  p1 = f_create_player(team1, team1_name)
  p2 = f_create_player(team2, team2_name)
  p_self = p1
  p_other = p2
end $$
