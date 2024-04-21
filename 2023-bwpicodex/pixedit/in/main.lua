import "CoreLibs/crank"
import "CoreLibs/graphics"

playdate.setCrankSoundsDisabled(true)

local preview_image = playdate.graphics.image.new(16, 16)

function create_text(text, w, h, ang)
  local textImage = playdate.graphics.image.new( w, h)
  playdate.graphics.pushContext( textImage )
  playdate.graphics.drawTextInRect( text, 1, 1, w, h)
  playdate.graphics.popContext()
  return textImage:rotatedImage( 90 )
end

local backup_len = 3
local t_picodex_editor = create_text("Picodex Editor - Alanxoc3", 200, 50, 90)

local pkmn_refs = playdate.graphics.imagetable.new("pkmn")
local did_edit = false
local filenames = {"000-063.p8", "064-127.p8", "128-191.p8", "192-255.p8"}
local pkmn_names = { [0]="Missing", "Bulsaur", "Ivysaur", "Vensaur", "Charman", "Charmel", "Charzar", "Squirtl", "Wartort", "Blstois", "Catrpie", "Metapod", "Butfree", "Weedle", "Kakuna", "Beedril", "Pidgey", "Pidgeto", "Pidgeot", "Rattata", "Raticat", "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sndshrw", "Sndslas", "NidranF", "Nidrina", "Nidquen", "NidranM", "Nidrino", "Nidking", "Clfairy", "Clfable", "Vulpix", "Nintale", "Jigpuff", "Wigtuff", "Zubat", "Golbat", "Oddish", "Gloom", "Vilplum", "Paras", "Parsect", "Venonat", "Venmoth", "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primape", "Growlth", "Arcanin", "Poliwag", "Polwirl", "Polrath", "Abra", "Kadabra", "Alkazam", "Machop", "Machoke", "Machamp", "Belsprt", "Weepbel", "Victbel", "Tntcool", "Tntcrul", "Geodude", "Gravler", "Golem", "Ponyta", "Rapdash", "Slowpok", "Slowbro", "Magnmit", "Magnton", "FafetcD", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk", "Shelder", "Clyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno", "Krabby", "Kingler", "Voltorb", "Elcrode", "Eggcute", "Eggutor", "Cubone", "Marowak", "Hitmlee", "Hitmchn", "Liktung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey", "Tangela", "Kangkan", "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie", "MrMime", "Scyther", "Jynx", "Elcabuz", "Magmar", "Pinsir", "Tauros", "Magkarp", "Gyardos", "Lapras", "Ditto", "Eevee", "Vapreon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar", "Kabuto", "Kabtops", "Aerodac", "Snorlax", "Artcuno", "Zapdos", "Moltres", "Dratini", "Dragair", "Dragite", "Mewtwo", "Mew", "Chikita", "Bayleef", "Megnium", "Cyndqil", "Quilava", "Typhlos", "Totodil", "Crocnaw", "Frlgatr", "Sentret", "Furret", "Hootoot", "Noctowl", "Ledyba", "Ledian", "Spinrak", "Ariados", "Crobat", "Chinchu", "Lanturn", "Pichu", "Cleffa", "Iggbuff", "Togepi", "Togetic", "Natu", "Xatu", "Mareep", "Flaaffy", "Amphros", "Belosom", "Marill", "Azmaril", "Sudwood", "Poltoed", "Hoppip", "Skiplom", "Jumpluf", "Aipom", "Sunkern", "Sunflor", "Yanma", "Wooper", "Quagsir", "Espeon", "Umbreon", "Murkrow", "Slowkng", "Misdvus", "Unown", "Wobufet", "Gifarig", "Pineco", "Fortres", "Dunspar", "Gligar", "Steelix", "Snubbul", "Granbul", "Qilfish", "Scizor", "Shuckle", "Hercros", "Sneasel", "Tediurs", "Ursring", "Slugma", "Macargo", "Swinub", "Pilswin", "Corsola", "Remraid", "Octlery", "Delbird", "Mantine", "Skarmry", "Hondour", "Hondoom", "Kingdra", "Phanpy", "Donphan", "Porygn2", "Stantlr", "Smeargl", "Tyrogue", "Hitmtop", "Smoochm", "Elekid", "Magby", "Miltank", "Blissey", "Raikou", "Entei", "Suicune", "Larvtar", "Pupitar", "Tyratar", "Lugia", "HoOh", "Celebi", "Extra-1", "Extra-2", "Extra-3", "Extra-4", }
local state = { cur = 0, x = 0, y = 0, }

function loadStore()
  state = playdate.datastore.read() or {}
  state.cur = state.cur or 0
  state.x   = state.x or 0
  state.y   = state.y or 0
end

function load_pico8_files()
  local images = {}

  for i=0,255 do
    images[i] = playdate.graphics.image.new(16, 16, playdate.graphics.kColorBlack)
  end

  for sheet_num=0,3 do
    local filename = filenames[sheet_num+1]
    local f = playdate.file.open(filename, playdate.file.kFileRead)
    local line_num = nil

    while true do
      local line = f:readline()
      if line == nil then break end

      if not line_num then
        if line:sub(1,7) == "__gfx__" then
          line_num = 0
        end
      else
        if line:sub(1,2) == "__" or line_num >= 128 then break end
        for char_num=1, math.min(#line, 128) do
          local sind = (line_num//16+sheet_num*8)*8 + (char_num-1)%128//16
          if line:sub(char_num,char_num) ~= "0" then
            playdate.graphics.pushContext( images[sind] )
            playdate.graphics.setColor(playdate.graphics.kColorWhite)
            playdate.graphics.fillRect((char_num-1)%16, line_num%16, 1, 1)
            playdate.graphics.popContext()
          end
        end
        line_num += 1
      end
    end
    f:close()
  end

  return images
end

function load_sprite(ind)
  ind = ind//1 % 256
  local image = playdate.datastore.readImage("pkmn-"..ind..".pdi")
  if not image then
    image = playdate.datastore.readImage("images/og/pkmn-"..ind..".pdi")

    if not image then
      image = playdate.graphics.image.new(16, 16, playdate.graphics.kColorBlack)
    end
  end
  return image
end

function save_sprite(image, ind)
  local filename = "pkmn-"..ind..".pdi"
  for i=backup_len,1,-1 do playdate.file.rename("images/"..filename..".bak"..i, "images/"..filename..".bak"..(i+1)) end
  playdate.file.rename("images/"..filename, "images/"..filename..".bak1")
  playdate.datastore.writeImage(image, filename)
end

local g_bak_count = 0
local g_cur_sprite = playdate.graphics.image.new(16, 16, playdate.graphics.kColorBlack)
function load_cur_spr(ind, mid_func)
  g_cur_sprite = load_sprite(ind)
  calc_backup(ind)
end

function flipSpr()
  g_cur_sprite = g_cur_sprite:scaledImage(-1, 1)
end

function calc_backup(ind)
  g_bak_count = 0
  local bak_filename = "pkmn-"..ind..".pdi"
  for _, f in ipairs(playdate.file.listFiles("images")) do
    if f:sub(1,#bak_filename) == bak_filename then
      g_bak_count += 1
    end
  end
end

function save_state_and_sprite(sprite_to_save)
  sprite_to_save = sprite_to_save//1 % 256
  pix_entered = {}

  if did_edit then
    save_sprite(g_cur_sprite, sprite_to_save)
    did_edit = false
  end

  playdate.datastore.write(state)
end

function save_to_pico8()
end

function draw_workspace(ox, oy)
  local w, aw = 12/2, 14/2

  playdate.graphics.setColor(playdate.graphics.kColorBlack)
  playdate.graphics.fillRect(ox-3, oy-3, aw*16+4, aw*16+4)
  playdate.graphics.setColor(playdate.graphics.kColorWhite)
  g_cur_sprite:drawScaled(ox-1, oy-1, aw)

  local indent = 0

  playdate.graphics.setColor(playdate.graphics.kColorXOR)
  playdate.graphics.drawRect(ox+state.x*aw-2, oy+state.y*aw-2, w+4, w+4)
  playdate.graphics.drawRect(ox+state.x*aw-3, oy+state.y*aw-3, w+6, w+6)

  playdate.graphics.setColor(g_cur_sprite:sample(state.x, state.y) == playdate.graphics.kColorWhite and playdate.graphics.kColorBlack or playdate.graphics.kColorWhite)
  playdate.graphics.drawLine(ox+state.x*aw+1+indent,   oy+state.y*aw+1+indent, ox+state.x*aw+w-2-indent, oy+state.y*aw+w-2-indent)
  playdate.graphics.drawLine(ox+state.x*aw+w-2-indent, oy+state.y*aw+1+indent, ox+state.x*aw+1+indent,   oy+state.y*aw+w-2-indent)

  playdate.graphics.setColor(playdate.graphics.kColorBlack)
end

function draw_preview(ox, oy, w)
  local spr_copy = g_cur_sprite:copy()
  spr_copy:setMaskImage(spr_copy)

  -- draw workspace
  playdate.graphics.drawRect(ox-w*2-1, oy-w*2-1, w*16+w*4+2, w*16+w*4+2)

  local f = function(ox, oy, invert)
    spr_copy:drawScaled(ox, oy, w)
  end

  playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeInverted)
  for xx=-1,1 do
    for yy=-1,1 do
      if not (xx == 0 and yy == 0) then
        f(ox+xx*w, oy+yy*w)
      end
    end
  end
  playdate.graphics.setImageDrawMode(playdate.graphics.kDrawModeCopy)

  f(ox, oy, false)
  spr_copy.removeMask(spr_copy) -- maybe for memory allocation? Maybe not needed
end

local dpadx = false
local dpady = false
local button_hold = 10
local pix_entered = {}

function dpad_helper(button, s)
  return playdate.buttonJustPressed(button) or (s and s >= button_hold) and playdate.buttonIsPressed(button)
end

function update()
  if not (playdate.buttonIsPressed(playdate.kButtonLeft) or playdate.buttonIsPressed(playdate.kButtonRight)) then dpadx = false elseif not dpadx then dpadx = 0 end
  if not (playdate.buttonIsPressed(playdate.kButtonUp)   or playdate.buttonIsPressed(playdate.kButtonDown))  then dpady = false elseif not dpady then dpady = 0 end

  -- process movement before button press, to get rid of tiny lag
  local xb = (dpad_helper(playdate.kButtonLeft, dpadx) and -1 or 0) + (dpad_helper(playdate.kButtonRight, dpadx) and 1 or 0)
  local yb = (dpad_helper(playdate.kButtonUp,   dpady) and -1 or 0) + (dpad_helper(playdate.kButtonDown,  dpady) and 1 or 0)
  local ab = playdate.buttonIsPressed(playdate.kButtonA)
  local bb = playdate.buttonIsPressed(playdate.kButtonB)
  local abj = playdate.buttonJustPressed(playdate.kButtonA)

  if dpadx and dpadx < button_hold then dpadx += 1 end
  if dpady and dpady < button_hold then dpady += 1 end

  local tickcount = playdate.getCrankTicks(12)
  if bb then
    pix_entered = {}

    if abj then
      flipSpr()
      did_edit = true
    elseif xb ~= 0 or yb ~= 0 then
      local image_copy = g_cur_sprite:copy()
      playdate.graphics.pushContext(g_cur_sprite)
      image_copy:draw(xb, 0)
      image_copy:draw(-15*xb, 0)
      playdate.graphics.popContext()

      image_copy = g_cur_sprite:copy()
      playdate.graphics.pushContext(g_cur_sprite)
      image_copy:draw(0, yb)
      image_copy:draw(0, -15*yb)
      playdate.graphics.popContext()

      did_edit = true
    elseif not playdate.isCrankDocked() then
      local prevstate = state.cur
      state.cur = math.min(255, math.max(0, state.cur+tickcount))
      if prevstate ~= state.cur then
        save_state_and_sprite(prevstate)
        load_cur_spr(state.cur)
      end
    end
  else
    state.x = math.min(15, math.max(0, state.x+xb))
    state.y = math.min(15, math.max(0, state.y+yb))

    if ab and not pix_entered[state.y*16+state.x] then
      playdate.graphics.pushContext( g_cur_sprite )
      playdate.graphics.setColor(g_cur_sprite:sample(state.x, state.y) == playdate.graphics.kColorWhite and playdate.graphics.kColorBlack or playdate.graphics.kColorWhite)
      playdate.graphics.fillRect(state.x, state.y, 1, 1)
      playdate.graphics.popContext()

      did_edit = true
      pix_entered[state.y*16+state.x] = true
    elseif not ab then
      pix_entered = {}
    end
  end

  -- DRAWING FUNCS
  local aox = 15
  playdate.graphics.clear()
  draw_workspace(9+aox,         121)

  playdate.graphics.drawRect(240+aox, 116, 56*2+6, 56*2+6)
  local reference = pkmn_refs:getImage(state.cur)
  if reference then
    reference:draw(240+3+aox, 116+3, playdate.graphics.kImageFlippedX)
  end

  local dp = function(offy, par)
    draw_preview(249-100-10+2+aox, 161-offy+100-10-1+10+2, 5, par)
  end

  dp(125, false)

  local numstr = tostring(state.cur)
  while #numstr < 3 do numstr = "0"..numstr end

  g_font:drawText("Alanxoc3 - Picodex Editor - "..numstr.." - "..pkmn_names[state.cur].." - "..g_bak_count, 9+aox, 90)

  -- t_picodex_editor:draw(350-3, 9)
end

g_font = playdate.graphics.getSystemFont(normal)

-- game should keep 3 backups of images. menu should be able to restore a backup.
playdate.update = update

loadStore()
load_cur_spr(state.cur)

playdate.getSystemMenu():addMenuItem("Pop Save", function()
  local filename = "pkmn-"..state.cur..".pdi"
  load_cur_spr(state.cur)
  playdate.file.delete("images/"..filename)
  playdate.file.rename("images/"..filename..".bak1", "images/"..filename)
  for i=1,backup_len do playdate.file.rename("images/"..filename..".bak"..(i+1), "images/"..filename..".bak"..i) end
  calc_backup(state.cur)
end)

-- TBH, this isn't really needed practically, keeping it here for reference though
-- playdate.getSystemMenu():addMenuItem("import pico8", function()
--   print("loading pico8 files")
--   local images = load_pico8_files()
--   print("load complete")
--
--   for i=0,255 do
--     print("saving sprite #"..i)
--     save_sprite(images[i], i)
--   end
--
--   print("savings complete")
--
--   playdate.update = function()
--     g_font:drawText("pico8-to-pics complete!", 50, 50)
--   end
-- end)

local save_callback = function()
  save_state_and_sprite(state.cur)
  calc_backup(state.cur)
end

playdate.getSystemMenu():addMenuItem("Push Save", save_callback)

playdate.getSystemMenu():addMenuItem("export pico8", function()
  playdate.update = function()
    local images = {}
    for i=0,255 do
      images[i] = load_sprite(i)
    end

    for sheet_num, filename in ipairs(filenames) do
      local f = playdate.file.open(filename, playdate.file.kFileWrite)
      local s = "pico-8 cartridge // http://www.pico-8.com\n"
      s = s.."version 41\n"
      s = s.."__gfx__\n"
      f:write(s)

      for yy=0,127 do
        s = ""
        for xx=0,127 do
          s = s..(images[(sheet_num-1)*64+yy//16*8+xx//16]:sample(xx%16, yy%16) == playdate.graphics.kColorWhite and "6" or "0")
        end
        s = s.."\n"
        f:write(s)
        print("saved row #"..(yy+sheet_num*128).." of 512")

        if yy % 32 == 0 then
          coroutine.yield() -- this function is very slow.
        end
      end
      print("")
      f:close()
    end

    playdate.graphics.clear()
    g_font:drawText("pics-to-pico8 complete! press b to continue", 50, 50)

    playdate.update = function()
      local abj = playdate.buttonJustPressed(playdate.kButtonB)
      if abj then
        playdate.update = update
      end
    end
  end
end)

playdate.gameWillTerminate = save_callback
playdate.deviceWillSleep = save_callback
playdate.deviceWillLock  = save_callback
