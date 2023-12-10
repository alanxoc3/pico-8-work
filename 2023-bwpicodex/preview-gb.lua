cls()
poke(0x5f2c, 3) -- enable 64x64
poke(0x5f5c, 8)
poke(0x5f5d, 1)

-- d7040000 this is the sfx prefix to:
-- - set dampen/reverb/buzz/noise to max
-- - get rid of loops
-- - set speed to 4

function minisfx(num) -- plays a sfx with len of 4
  -- d7040000 this is the sfx prefix to:
  -- - set dampen/reverb/buzz/noise to max
  -- - get rid of loops
  -- - set speed to 4

  sfx(num%63, 0, num\63*8, 8)
end

pkmn_names = split"missing,bulsaur,ivysaur,vensaur,charman,charmel,charzar,squirtl,wartort,blstois,catrpie,metapod,btrfree,weedle,kakuna,beedril,pidgey,pidgeto,pidgeot,rattata,raticat,spearow,fearow,ekans,arbok,pikachu,raichu,sndshrw,sndslas,nidranf,nidrina,nidquen,nidranm,nidrino,nidking,clfairy,clfable,vulpix,nintale,jigpuff,wigtuff,zubat,golbat,oddish,gloom,vilplum,paras,parsect,venonat,venmoth,diglett,dugtrio,meowth,persian,psyduck,golduck,mankey,primape,growlth,arcanin,poliwag,polwirl,polrath,abra,kadabra,alkazam,machop,machoke,machamp,belsprt,weepbel,victbel,tntcool,tntcrul,geodude,gravler,golem,ponyta,rapdash,slowpok,slowbro,magnmit,magnton,fafetch,doduo,dodrio,seel,dewgong,grimer,muk,shelder,clyster,gastly,haunter,gengar,onix,drowzee,hypno,krabby,kingler,voltorb,elcrode,eggcute,eggutor,cubone,marowak,hitmlee,hitmchn,liktung,koffing,weezing,rhyhorn,rhydon,chansey,tangela,kangkan,horsea,seadra,goldeen,seaking,staryu,starmie,mrmime,scyther,jynx,elcabuz,magmar,pinsir,tauros,magkarp,gyardos,lapras,ditto,eevee,vapreon,jolteon,flareon,porygon,omanyte,omastar,kabuto,kabtops,aerodac,snorlax,artcuno,zapdos,moltres,dratini,dragair,dragite,mewtwo,mew,chikita,bayleef,megnium,cyndqil,quilava,typhlos,totodil,crocnaw,frlgatr,sentret,furret,hootoot,noctowl,ledyba,ledian,spinrak,ariados,crobat,chinchu,lanturn,pichu,cleffa,iggbuff,togepi,togetic,natu,xatu,mareep,flaaffy,amphros,belosom,marill,azmaril,sudwood,poltoed,hoppip,skiplom,jumpluf,aipom,sunkern,sunflor,yanma,wooper,quagsir,espeon,umbreon,murkrow,slowkng,misdvus,unown,wobufet,gifarig,pineco,fortres,dunspar,gligar,steelix,snubbul,granbul,qilfish,scizor,shuckle,hercros,sneasel,tediurs,ursring,slugma,macargo,swinub,pilswin,corsola,remraid,octlery,delbird,mantine,skarmry,hondour,hondoom,kingdra,phanpy,donphan,porygn2,stantlr,smeargl,tyrogue,hitmtop,smoochm,elekid,magby,miltank,blissey,raikou,entei,suicune,larvtar,pupitar,tyratar,lugia,hooh,celebi"
pkmn_types = {{"bird","normal"}, {"grass","poison"}, {"grass","poison"}, {"grass","poison"}, {"fire",""}, {"fire",""}, {"fire","flying"}, {"water",""}, {"water",""}, {"water",""}, {"bug",""}, {"bug",""}, {"bug","flying"}, {"bug","poison"}, {"bug","poison"}, {"bug","poison"}, {"flying","normal"}, {"flying","normal"}, {"flying","normal"}, {"normal",""}, {"normal",""}, {"flying","normal"}, {"flying","normal"}, {"poison",""}, {"poison",""}, {"electr",""}, {"electr",""}, {"ground",""}, {"ground",""}, {"poison",""}, {"poison",""}, {"poison","ground"}, {"poison",""}, {"poison",""}, {"poison","ground"}, {"normal",""}, {"normal",""}, {"fire",""}, {"fire",""}, {"normal",""}, {"normal",""}, {"poison","flying"}, {"poison","flying"}, {"grass","poison"}, {"grass","poison"}, {"grass","poison"}, {"bug","grass"}, {"bug","grass"}, {"poison","bug"}, {"poison","bug"}, {"ground",""}, {"ground",""}, {"normal",""}, {"normal",""}, {"water",""}, {"water",""}, {"fightg",""}, {"fightg",""}, {"fire",""}, {"fire",""}, {"water",""}, {"water",""}, {"water","fightg"}, {"psychc",""}, {"psychc",""}, {"psychc",""}, {"fightg",""}, {"fightg",""}, {"fightg",""}, {"grass","poison"}, {"grass","poison"}, {"grass","poison"}, {"water","poison"}, {"water","poison"}, {"rock","ground"}, {"rock","ground"}, {"rock","ground"}, {"fire",""}, {"fire",""}, {"psychc","water"}, {"psychc","water"}, {"steel","electr"}, {"steel","electr"}, {"flying","normal"}, {"flying","normal"}, {"flying","normal"}, {"water",""}, {"water","ice"}, {"poison",""}, {"poison",""}, {"water",""}, {"water","ice"}, {"ghost","poison"}, {"ghost","poison"}, {"ghost","poison"}, {"rock","ground"}, {"psychc",""}, {"psychc",""}, {"water",""}, {"water",""}, {"electr",""}, {"electr",""}, {"grass","psychc"}, {"grass","psychc"}, {"ground",""}, {"ground",""}, {"fightg",""}, {"fightg",""}, {"normal",""}, {"poison",""}, {"poison",""}, {"ground","rock"}, {"ground","rock"}, {"normal",""}, {"grass",""}, {"normal",""}, {"water",""}, {"water",""}, {"water",""}, {"water",""}, {"water",""}, {"water","psychc"}, {"psychc",""}, {"bug","flying"}, {"psychc","ice"}, {"electr",""}, {"fire",""}, {"bug",""}, {"normal",""}, {"water",""}, {"water","flying"}, {"water","ice"}, {"normal",""}, {"normal",""}, {"water",""}, {"electr",""}, {"fire",""}, {"normal",""}, {"rock","water"}, {"rock","water"}, {"rock","water"}, {"rock","water"}, {"rock","flying"}, {"normal",""}, {"ice","flying"}, {"electr","flying"}, {"fire","flying"}, {"dragon",""}, {"dragon",""}, {"dragon","flying"}, {"psychc",""}, {"psychc",""}, {"grass",""}, {"grass",""}, {"grass",""}, {"fire",""}, {"fire",""}, {"fire",""}, {"water",""}, {"water",""}, {"water",""}, {"normal",""}, {"normal",""}, {"flying","normal"}, {"flying","normal"}, {"bug","flying"}, {"bug","flying"}, {"bug","poison"}, {"bug","poison"}, {"poison","flying"}, {"electr","water"}, {"electr","water"}, {"electr",""}, {"normal",""}, {"normal",""}, {"normal",""}, {"normal","flying"}, {"psychc","flying"}, {"psychc","flying"}, {"electr",""}, {"electr",""}, {"electr",""}, {"grass",""}, {"water",""}, {"water",""}, {"rock",""}, {"water",""}, {"grass","flying"}, {"grass","flying"}, {"grass","flying"}, {"normal",""}, {"grass",""}, {"grass",""}, {"bug","flying"}, {"water","ground"}, {"water","ground"}, {"psychc",""}, {"dark",""}, {"dark","flying"}, {"psychc","water"}, {"ghost",""}, {"psychc",""}, {"psychc",""}, {"psychc","normal"}, {"bug",""}, {"bug","steel"}, {"normal",""}, {"ground","flying"}, {"steel","ground"}, {"normal",""}, {"normal",""}, {"water","poison"}, {"steel","bug"}, {"bug","rock"}, {"bug","fightg"}, {"dark","ice"}, {"normal",""}, {"normal",""}, {"fire",""}, {"fire","rock"}, {"ground","ice"}, {"ground","ice"}, {"rock","water"}, {"water",""}, {"water",""}, {"flying","ice"}, {"water","flying"}, {"steel","flying"}, {"dark","fire"}, {"dark","fire"}, {"water","dragon"}, {"ground",""}, {"ground",""}, {"normal",""}, {"normal",""}, {"normal",""}, {"fightg",""}, {"fightg",""}, {"psychc","ice"}, {"electr",""}, {"fire",""}, {"normal",""}, {"normal",""}, {"electr",""}, {"fire",""}, {"water",""}, {"rock","ground"}, {"rock","ground"}, {"dark","rock"}, {"psychc","flying"}, {"fire","flying"}, {"grass","psychc"}}

g_outline_in_progress = false
function outline(x, y, col1, col2, func)
  if not g_outline_in_progress then
    g_outline_in_progress = true

    for c=0,15 do pal(c,col2) end
    for c in all({{1, 1}, {1, -1}, {-1, -1}, {-1, 1}}) do
      func(x+c[1],y+c[2])
    end

    for c=0,15 do pal(c,col1) end
    for c in all({{0, 1}, {1, 0}, {-1, 0}, {0, -1}}) do
      func(x+c[1],y+c[2])
    end

    pal(0)

    g_outline_in_progress = false
  else
    for yy=-1,1 do
      for xx=-1,1 do
        if not (xx == 0 and yy == 0) then
          func(x+xx,y+yy)
        end
      end
    end
  end
end

g_loaded_row = 0
function load_pkmn(num)
  local row = num/8\1
  local col = num%8

  if row ~= g_loaded_row then
    g_loaded_row = row
    -- loaded_row for monochrome (row below is monochrome for current row)
    memcpy(0x0400, 0x2000+0x400*(row%8), 0x400)

    local shift = row\8
    local bits = 0b10001000 >> shift

    local col = 6 -- set all pixels to one color... this may not actually be needed, but whatever
    for i=0,0x400-1 do
      local loc = 0x400+i
      local val = (peek(loc) & bits) << shift
      if (val & 0b00001111) > 0 then val = (val & 0b11110000) | (col        & 0b00001111) end
      if (val & 0b11110000) > 0 then val = (val & 0b00001111) | ((col << 4) & 0b11110000) end
      poke(loc, val)
    end
  end
end

function draw_pkmn(num, x, y, sw, sh, highlighted, is_draft)
  local row = num/8\1
  local col = num%8

  load_pkmn(num)

  sw = sw or 1
  sh = sh or 1

  local w, h = 16*sw, 16*sh
  local drawfunc = function(ix, iy)
    local yoff = is_draft and 32 or 0
    sspr(col*16, yoff + 16, 16, 16, ix-w/2, iy-h/2, w, h)
  end

  local colordrawfunc = function(ix, iy, c)
    pal(6, c)
    drawfunc(ix, iy)
    pal(6, 6)
  end

  if highlighted then
    roundrect(x, y, 10, 10, C_3)

    outline(x, y, C_2, C_2, drawfunc) -- dark outline
    colordrawfunc(x, y, C_4) -- sprite

  else
    outline(x, y, C_1, C_1, drawfunc)
    colordrawfunc(x, y, C_3)
  end
end

-- {dark, light}
function vget(offset, x, y)
  x = min(max(0, x), 127)\1
  y = y\1

  local val = peek(y*64+offset+x\2)
  if x%2 == 1 then return (val & 0xf0) >>> 4
  else             return (val & 0x0f) end
end

-- w=128, h=512 (4 spritesheets). 16x16 squares
-- this function will simply pack all the spritesheets one after another with a single bit per pixel.
-- better compression ratio to just save the data than trying rle or px9.
function store_pack(offset, vget)
  for y=0,127 do
    for x=0,127,2 do
      local col = 0

      col = (col << 1) | (vget(x+1, y+128*0) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+1, y+128*1) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+1, y+128*2) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+1, y+128*3) > 0 and 1 or 0)

      col = (col << 1) | (vget(x+0, y+128*0) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+0, y+128*1) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+0, y+128*2) > 0 and 1 or 0)
      col = (col << 1) | (vget(x+0, y+128*3) > 0 and 1 or 0)

      poke(offset, col)
      offset += 1
    end
  end
end

function reload_sprites()
  reload(0x8000, 0x0000, 0x2000, "./000-063.p8")
  reload(0xa000, 0x0000, 0x2000, "./064-127.p8")
  reload(0xc000, 0x0000, 0x2000, "./128-191.p8")
  reload(0xe000, 0x0000, 0x2000, "./192-255.p8")

  store_pack(0x2000, function(...) return vget(0x8000, ...) end)

  reload(0x3200, 0x3200, 0x1100, "./game.p8") -- for sfx

  for i=0,62 do
    for j=0,63 do
      poke(0x3200+i*68+j, peek(0x3200+i*68+j) & 0x3f) -- the & 3f part brings the max pitch down a bit
    end
    poke(0x3200+i*68+0+64, 0xd7)
    poke(0x3200+i*68+1+64, 0x06)
    poke(0x3200+i*68+2+64, 0x00)
    poke(0x3200+i*68+3+64, 0x00)
  end

  -- cstore(0x3200, 0x3200, 0x1100, "./testsfx.p8") -- for sfx

  g_loaded_row = -1
end

g_maxnum = 252

function _init()
  reload_sprites()
end

C_0=0 C_1=1 C_2=2
C_3=3 C_4=4 C_5=5
cols = {
  {[0]=129, 1,   131, 3,   139, 11},
  {[0]=129, 130, 132, 4,   143, 15},
  {[0]=129, 129, 1,   140, 12,  12},
  {[0]=129, 133, 5,   13,  6,   7 },
}

mock_ind = 0
cols_ind = 0
g_off = 0
g_scale = 1
view_y = 0
g_num  = 0
g_active = false
g_hpmod = 0
function _update60()
  local top = (g_maxnum-1)\3 -- 253, includes substitute/empty/?

  if btnp(0) then g_hpmod -= 1 g_num = mid(0,251,g_num-1) end
  if btnp(1) then g_hpmod += 1 g_num = mid(0,251,g_num+1) end
  if btnp(2) then g_active = not g_active g_num = mid(g_num%3,249+g_num%3,g_num-3) end
  if btnp(3) then g_active = not g_active g_num = mid(g_num%3,249+g_num%3,g_num+3) end

  if btnp(4) then
    -- cols_ind = (cols_ind - 1)%#cols
    minisfx(g_num)
  end

  if btnp(5) then
    mock_ind = (mock_ind + 1) % 6
  end

  if g_num\3-1 > view_y then view_y = (view_y+1)%(top) end
  if g_num\3   < view_y then view_y = (view_y-1)%(top) end
end

scannum = 0
scannum2 = 0

function f_zprint(text, x, y, color, align, control)
    text = ""..text
    if align == 0    then x -= #text*2
    elseif align > 0 then x -= #text*4+1 end

    print((control or "")..text, x, y, color)
end

function f_wobble_text(text, x, y, color, wob, align)
    local t1, t2 = "", ""
    for i=1,#text do
        local letter, switch = sub(text, i, i), i%2==(wob and 1 or 0)
        t1 ..= switch and " " or letter
        t2 ..= switch and letter or " "
    end

    f_zprint(t1, x, y,   color, align or 0)
    f_zprint(t2, x, y+1, color, align or 0)
end

function roundrect(x, y, rx, ry, c)
  rectfill(x-rx, y-ry, x+rx-1, y+ry-1, c)
end

function roundrect_r(x1, y1, x2, y2, c)
  rectfill(x1, y1+1, x2, y2-1, c)
  if x2-x1 > 2 then -- if check is for the hp bar, so it looks good when small.
    rectfill(x1+1, y1, x2-1, y2, c)
  end
end

function _draw()
  memset(0x5f70, 0, 16) -- enable secondary pallette for all lines

  cls(C_1)
  --fillp(0b1010010110100101)
  roundrect(32,23,31,21,C_2)
  fillp()
  clip(1, 2, 62, 42)

  -- rectfill(0,scannum2-6,63,scannum2-2, C_3)
  -- rectfill(0,64-scannum+15,63,64-scannum+5,1)

  fillp(0b1111000011110000)
  rectfill(0,scannum2-5,63,scannum2-3,     (C_3 << 4) | C_2)
  fillp()

  fillp(0b0000111100001111)
  rectfill(0,64-scannum+12,63,64-scannum+8,(C_3 << 4) | C_2)
  fillp()

  if mock_ind == 0 then
    local yy = view_y*3
    local xo = 12
    local yo = 13
    for ii=0,2 do
      local ind = yy + ii
      draw_pkmn(ind, xo+ii*20, yo, g_scale, g_scale, ind == g_num)
    end

    yy = (view_y*3+3)%252
    for ii=0,2 do
      local ind = yy + ii
      draw_pkmn(ind, xo+ii*20, yo+20, g_scale, g_scale, ind == g_num)
    end

  elseif mock_ind == 1 then
    --rectfill(1,2,62,43,C_2)
    local ox, oy = 2, 8+7-7+7+7+1
    f_zprint("\^w\^tpicodex",  3+5-1-2, oy+3-19-2-1,    C_1, -1)
    f_zprint("\^wdual",  3+5-1-2+12, oy-3-19+12+1+3-1, C_1, -1)

    srand(t()\1)
    --draw_pkmn(rnd()*251\1+1, ox+9+20+1, oy-7-4-2, .25, .5, false)
    --srand(t()\1+1)
    --draw_pkmn(rnd()*251\1+1, ox+7+2+40+3-1, oy-7-4+1, -1, 1, false)
    --f_zprint("\^tdual",    1+4+5+5+2, oy-6+1+6, C_1, -1)
    local xx, yy = g_num%6%2*31, g_num%6\2*7
    rectfill(ox+xx-1, oy+yy, 29+ox+xx, oy+6+yy, C_3)

    local items = {
      "browse", "edit",
      "league", "versus",
      "horde", "credits",
    }
    for i=0,5 do
      local xx, yy = i%2*31, i\2*7
      local wob = i%2==0
      local col = C_1
      if i == g_num%6 then wob = t()\1%2==0 col = C_2 end
      f_zprint(items[i+1], 2+ox+xx-1, 1+oy+yy, col, -1)
    end

  elseif mock_ind >= 2 then
    local b = function(name, gender, status, x, y, bx, by, hi, hp, hpmax)
      local d, l = C_1, C_3
      if hi then
        d, l = C_2, C_4
      end

      roundrect_r(bx-1, by+1, bx+35, by+5, d)
      if hp > 0 then
        rectfill(bx, by+2, bx+mid(1, hp/hpmax*34, 34), by+4, l)
        pset(bx, by+2, d)
        pset(bx+34, by+2, d)
        pset(bx, by+4, d)
        pset(bx+34, by+4, d)
      end

      local tx, ty = x+15, y+8
      for i=0,5 do
        if i ~= 1 then
          if i == 0 then
            -- rect(tx+i%3*2-1, ty+i%2*2-1, tx+i%3*2+1, ty+i%2*2+1, l)
          elseif i == 5 then
            -- print("+", tx+i%3*2-1, ty+i%2*2-2, l)
          end
          pset(tx+i%3*2, ty+i%2*2, i == 5 and l or d)
        end
      end

      f_zprint(name,   x+0, y-5, d, -1)
      f_zprint(status,              x+0, y+7, d, -1)
      f_zprint(flr(hp), x+37, y+7, d, 1)
      f_zprint(gender, x+37, y-5, d, 1)
    end

    local myoff = (not g_active and 21 or 0)
    rectfill(1, 2+myoff, 62, 22+myoff, C_3)

    draw_pkmn(5, 52, 13 - (g_active and t()*2\1%2 or 0), -1, 1, g_active)        b("charmel", "M", "brn", 4, 9,  4, 9,  g_active,   80+g_hpmod, 90)
    draw_pkmn(5, 12, 33 + (not g_active and t()*2\1%2 or 0), 1, 1, not g_active) b("charmel",  "M", "",    25,30, 25,30,  not g_active, 100+g_hpmod, 100)
  end

  clip()

  local one, two = 0xaa, 0x55
  for i=0,7 do poke(0x5f70+i,0b10101010) end
  scannum += .75
  scannum %= 64+20+1
  scannum2 += .5
  scannum2 %= 64+8+1

  --rectfill(0, 43, 63, 63, C_1)

  local r, y, h = 31, 46, 15
  rectfill(31-r+1, y,   32+r-1, y+h,C_0)

  if mock_ind == 2 or mock_ind == 3 then
    local items = {"fight", "party", "auto", "forfeit"}
    if mock_ind == 3 then
      items = {"tackle", "tailwhp", "flmthwr", "flmweel"}
    end
    local xx, yy = g_num%4%2*30, g_num%4\2*7
    --rectfill(2, y+1, 31, y+7, C_1)
    rectfill(2+xx, y+1+yy, 31+xx, y+7+yy, g_num%4==0 and C_2 or C_2)

    for i=0,3 do
      xx, yy = i%2*31, i\2*7
      f_zprint(items[i+1], 3+xx, y+2+yy, i==g_num%4 and C_3 or C_2, -1)
    end

    -- f_zprint(items[1], 3, y+2, C_1, -1)
    -- if g_num%4 == 0 then
    --   f_zprint(items[1], 3, y+2, C_0, -1)
    -- end

  elseif mock_ind == 4 then
    local items = {"#3 flmthwr", "", "normal 17/20PP", ""}
    local xx, yy = g_num%4%2*30, g_num%4\2*7
    ----rectfill(2+xx, y+1+yy, 31+xx, y+7+yy, C_2)

    for i=0,3 do
      xx, yy = i%2*31, i\2*7

      f_zprint(items[i+1], 3+xx, y+2+yy, i == 0 and C_3 or C_2, -1)
    end

  elseif mock_ind == 5 then
    local items = {"charmel", "", "uses flmthwr", ""}
    local xx, yy = g_num%4%2*30, g_num%4\2*7
    ----rectfill(2+xx, y+1+yy, 31+xx, y+7+yy, C_2)

    for i=0,3 do
      xx, yy = i%2*31, i\2*7

      f_zprint(items[i+1], 3+xx, y+2+yy, i == 0 and C_3 or C_2, -1)
    end

  elseif mock_ind == 0 then
    local numstr = tostr(g_num)
    while #numstr < 3 do numstr = "0"..numstr end
    --rectfill(2, y+1, 61, y+7, C_2)
    print("#"..numstr.." "..pkmn_names[g_num+1],3, y+2,  C_3)
    local typstr = pkmn_types[g_num+1][1]
    if pkmn_types[g_num+1][2] ~= "" then
      typstr ..= "/"..pkmn_types[g_num+1][2]
    end
    print(typstr,3, y+8+1,C_2)
  end

  pal(cols[cols_ind+1], 1)
end
