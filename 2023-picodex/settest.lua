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
    if g_select == 5 then
        memset(0x5e00, 0, 0x100)
    end

    if g_select == 3 then
        for i=0,151 do poke(s_pokemon+i, 1) end
    end

    if g_select == 4 then
        poke(s_story,40)
    end

    if g_select <= 2 then
        poke(s_new,1)

        local mem=s_party1
        local cur_move = 72*g_select
        for i=0,17 do
            if cur_move < 164 then -- works perfectly since 164 is divisible by 4 (4 move slots, 164 total moves in game besides struggle)
                poke(mem, g_select*18+i+1) mem+=1
                poke(mem, cur_move%164+1)  mem+=1 cur_move+=1
                poke(mem, cur_move%164+1)  mem+=1 cur_move+=1
                poke(mem, cur_move%164+1)  mem+=1 cur_move+=1
                poke(mem, cur_move%164+1)  mem+=1 cur_move+=1
            else
                poke(mem, 0) mem+=1
                poke(mem, 0) mem+=1
                poke(mem, 0) mem+=1
                poke(mem, 0) mem+=1
                poke(mem, 0) mem+=1
            end
        end
    end
end

function _update60()
    g_select = mid(0,5,g_select+ybtnp())

    if btnp(4) or btnp(5) then
        updatesavedata()
        stop()
    end
end

function _draw()
    cls()
    print("picodex test suite",     5, 5, 6)
    print("press x/z to load test", 5, 13, 6)
    camera(-20,-40)
    print("->", 1-5, 5+8*g_select, 8)
    print("load test party 1", 5,  5, 7)
    print("load test party 2", 5, 13, 7)
    print("load test party 3", 5, 21, 7)
    print("unlock pokemon",    5, 29, 7)
    print("unlock trainers",   5, 37, 7)
    print("factory reset",     5, 45, 7)
    camera()
end
