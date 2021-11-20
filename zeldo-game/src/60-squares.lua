-- power squares
function add_money(amount)
   g_money = min(g_money + amount, 99)
end

function remove_money(amount)
   if g_money - amount >= 0 then
      g_money -= amount
      return true
   end
end

function energy_update(refresh_rate)
   if g_energy_tired and g_energy <= 0 then
      g_energy_tired = false
   end

   if g_energy_amount > 0 then
      g_energy_amount = max(0, g_energy_amount-1)
      g_energy += 1
   elseif not g_energy_pause then
      g_energy = max(0, g_energy - refresh_rate)
   end

   if g_energy >= MAX_ENERGY then
      g_energy_tired = true
   end

   g_energy_pause = false
end

function pause_energy()
   g_energy_pause = true
end

function use_energy(amount)
   g_energy_amount += amount
end
