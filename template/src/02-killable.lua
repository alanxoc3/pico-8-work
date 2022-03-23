zactor[[,killable|
    alive,     yes,
    destroyed, nop,

    kill,  %killable_kill,
    clean, %killable_clean,
]]

|killable_kill| function(a) a.alive = nil end $$
|killable_clean| function(a)
    if not a.alive then
        a:destroyed()
        a:delete()
    end
end $$
