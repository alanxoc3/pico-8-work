g_select = 0
cartdata"picodex"

function btn_helper(f, a, b) return f(a) and f(b) and 0 or f(a) and 0xffff or f(b) and 1 or 0 end
function ybtnp() return btn_helper(btnp, 2, 3) end

s_party1 =        0x5e00
s_pokemon =       0x5e5a
s_new =           0x5efc
s_story =         0x5efd
s_hoard =         0x5efe
s_swap_controls = 0x5eff


function updatesavedata()
    poke(s_new,1)
    poke(s_pokemon,0)
    poke(s_story,40)
    for i=1,151 do poke(s_pokemon+i, 1) end
    local mem=s_party1
    local cur_move = 72*g_select
    for i=0,17 do
        poke(mem, g_select*18+i+1) mem+=1
        poke(mem, cur_move%164+1)   mem+=1 cur_move+=1
        poke(mem, cur_move%164+1)   mem+=1 cur_move+=1
        poke(mem, cur_move%164+1)   mem+=1 cur_move+=1
        poke(mem, cur_move%164+1)   mem+=1 cur_move+=1
    end
end

function _update60()
    g_select = mid(0,2,g_select+ybtnp())

    if btnp(4) or btnp(5) then
        updatesavedata()
        stop()
    end
end

function _draw()
    cls()
    print("picodex test suite",     5, 5, 6)
    print("press x/z to load test", 5, 13, 6)
    camera(-40,-40)
    print(">", 1, 5+8*g_select, 8)
    print("<", 49, 5+8*g_select, 8)
    print("load test 1", 5,  5, 7)
    print("load test 2", 5, 13, 7)
    print("load test 3", 5, 21, 7)
    camera()
end
