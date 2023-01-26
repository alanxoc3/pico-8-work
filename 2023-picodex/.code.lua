g_zclass_constructors,g_zclass_entities,g_zclass_new_entities={},{},{}
function zclass(meta_and_att_str)
local meta,template,memloc,expected_memloc_value=unpack(split(meta_and_att_str,"|"))
local parents=split(meta)
local class=deli(parents,1)
g_zclass_entities[class]=g_zclass_entities[class]or{}
g_zclass_constructors[class]=function(inst,done,...)
foreach(parents,function(parent)
if not done[parent]then g_zclass_constructors[parent](inst,done)end
end)
done[class]=true
inst.parents[class]=true
add(g_zclass_new_entities,{class,inst})
return zobj_set(inst,template,...)
end
_g[class]=function(...)if not memloc or peek(memloc)==expected_memloc_value then return g_zclass_constructors[class]({id=class,parents={},ecs_exclusions={}},{},...)end end
end
function register_entities()
while #g_zclass_new_entities>0 do
local class,inst=unpack(deli(g_zclass_new_entities))
if not inst.ecs_exclusions[class]then add(g_zclass_entities[class],inst)end
end
end
function deregister_entity(inst,...)
for class,entities in pairs(g_zclass_entities)do
del(entities,inst)
end
end
function call_not_nil(table,key,...)
if table and table[key]then
return table[key](...)
end
end
function does_entity_exist(entity_name)
return #g_zclass_entities[entity_name]>0
end
function loop_entities(class,method_name,...)
for inst in all(g_zclass_entities[class])do
call_not_nil(inst,method_name,inst,...)
end
end
function clean_all_entities(...)
local objs_to_clean,exclusions={},{}
foreach({...},function(exclusion)exclusions[exclusion]=true end)
for class,entities in pairs(g_zclass_entities)do
for entity in all(entities)do
objs_to_clean[entity]=entity.id
end
end
for obj,id in pairs(objs_to_clean)do
if not exclusions[id]then
deregister_entity(obj)
end
end
g_zclass_new_entities={}
end
function nop()end
function zobj_eval(val,table,parameters)
if ord(val)==37 then return _g[sub(val,2)]
elseif val=="~"then return table
elseif ord(val)==126 then return table[sub(val,2)]
elseif val=="@"then return deli(parameters,1)
elseif val=="yes"or val=="no"then return val=="yes"
elseif val=="null"or val==""then return
elseif val=="nop"then return nop
end return val
end
function zobj_set(table,str,...)
local params,statements,dest={...},split(str,";"),table
foreach(statements,function(statement)
local tokens=split(statement)
if #tokens>1 then
if tokens[1]==""then
foreach(tokens,function(val)
add(dest,zobj_eval(val,table,params))
end)
else
for i=1,#tokens,2 do
dest[tokens[i]]=zobj_eval(tokens[i+1],table,params)
end
end
dest=table
else
if statement==""then statement=#dest+1 end
if type(dest[statement])~="table"then
dest[statement]={}
end
dest=dest[statement]
end
end)
return table
end
function zobj(...)
return zobj_set({},...)
end
_g=zobj([[actor_load,@,actor_loadlogic,@,actor_state,@,actor_is_alive,@,actor_kill,@,actor_clean,@,timer_reset_timer,@,timer_end_timer,@,timer_get_elapsed_percent,@,timer_is_active,@,timer_tick,@,menu_state_callback,@,modes_push,@,modes_pop,@,game_init,@,game_update,@,game_draw,@,main_update,@,main_draw1,@,main_draw3,@,main_draw2,@,gamefadein_init,@,closed_init,@,closed_update,@,closed_draw,@,closing_draw,@,light_init,@,opened_draw,@,opening_draw,@,browse_update,@,browse_draw1,@,browse_draw2,@,browse_draw3,@,browsestat_update,@,browsestat_draw1,@,credits_update,@,credits_draw1,@,editparty_update,@,editparty_draw1,@,editparty_draw2,@,editparty_draw3,@,partydel,@,partyaction_init,@,partyaction_update,@,partyaction_draw1,@,partyaction_draw3,@,partypkmn_init,@,partypkmn_update,@,partypkmn_draw1,@,partypkmn_draw2,@,partypkmn_draw3,@,partymoves_init,@,partymoves_update,@,partymoves_draw1,@,partymoves_draw2,@,partymoves_draw3,@,partymovesel_init,@,partymovesel_update,@,partymovesel_draw1,@,partymovesel_draw2,@,partymovesel_draw3,@,fightover_init,@,fightover_update,@,fightover_draw1,@,fightover_draw2,@,fightover_draw3,@,fight_select,@,fightsel_init,@,fightsel_update,@,fightsel_draw1,@,fightsel_draw2,@,fightsel_draw3,@,party_select,@,party_init,@,party_update,@,party_draw1,@,turn_init,@,turn_update,@,turn_draw1,@,turn_draw2,@,turn_draw3,@,psel_init,@,pselactions_update,@,pselactions_draw1,@,pselactions_draw2,@,pselactions_draw3,@,psel_forfeit,@,pselmove_init,@,pselmove_update,@,pselmove_draw1,@,pselmove_draw2,@,pselmove_draw3,@,fader_out_update,@,fader_in_update,@,logo_init,@,logo_draw,@,game_state_init,@]],function(a,stateName)
a.next_state=stateName or a.next
end,function(a,stateName)
a.next_state,a.isnew=nil
if stateName=="dead"then
a.alive=false
else
a:finit()
a:end_timer(a.curr)
a.next,a.duration=nil
for k,v in pairs(a.defaults)do a[k]=v end
for k,v in pairs(a[stateName])do a[k]=v end
a.curr=stateName
a:start_timer(a.curr,a.duration,a.duration and function()a:load(a.next or "dead")end)
a:init()
end
end,function(a)
if a.isnew then a:loadlogic(a.curr)end
while a.next_state do
a:loadlogic(a.next_state)
end
a:update()
a:stateless_update()
end,function(a)
return not a.effectively_dead and a:is_active"ending"==nil and a.alive
end,function(a)
a.effectively_dead=true
if a.ending then
if a.curr=="start"then
a.next="ending"
elseif a:is_active"ending"==nil then
a:load"ending"
end
else
a.alive=nil
end
end,function(a)if not a.alive then a:destroyed()deregister_entity(a)end end,function(a,timer_name,duration,callback)
a.timers[timer_name]={active=true,elapsed=false,duration=duration and 0+duration,callback=callback or function()end}
end,function(a,timer_name)
if a.timers[timer_name]then
a.timers[timer_name].elapsed=a.timers[timer_name].duration or a.timers[timer_name].elapsed
a.timers[timer_name].active=false
end
end,function(a,timer_name)
local timer=a.timers[timer_name]
if not timer then return 0
elseif not timer.duration then return 0
elseif timer.duration<=0 then return 1
end
return min(1,(timer.elapsed or 0)/timer.duration)
end,function(a,timer_name)
local timer=a.timers[timer_name]
return timer and timer.active
end,function(a)
local finished_timers={}
for name,timer in pairs(a.timers)do
if timer.active then
if timer.elapsed then
timer.elapsed=timer.elapsed+1/60
if timer.duration and timer.elapsed>=timer.duration then
add(finished_timers,timer)
end
elseif not timer.elapsed then
timer.elapsed=0
end
end
end
foreach(finished_timers,function(timer)
timer.active=false
timer.callback(a)
end)
end,function(a,game)
if a.state then
game:push(a.state)
else
game:pop()
end
end,function(a,newstate)
add(a.stack,newstate)
a:load(newstate)
end,function(a)
deli(a.stack)
a:load(a.stack[#a.stack]or "main")
end,function(a)
zcall(poke,[[;,0x5e5b,1;;,0x5e5e,1;;,0x5e61,1]])
g_cursors=zobj[[party,0,pselaction,0,fightsel,0,partymsel,0,partymoves,0,party_pkmn,0,partyaction,0,mode,0,browse,0]]
g_views=zobj[[party,0,pselaction,0,fightsel,0,partymsel,0,partymoves,0,party_pkmn,0,partyaction,0,mode,0,browse,0]]
a.modes=_g.modes()
sfx(61,0)
menuitem(1,"close picodex",function()
menuitem(1)
menuitem(2)
a:load"closing"
end)
menuitem(2,"swap 🅾️/❎",function()
poke(0x5efa,@0x5efa==0 and 1 or 0)
end)
end,function(a)
a.modes:state()
end,function(a)
cls()
draw_picodex(a:is_active"shaking",1,
function()a.modes:draw1()end,
function()a.modes:draw2()end,
function()a.modes:draw3()end,
4,false,g_cursors.mode,#a.modes.stack)
end,function(a)menu_update(a,"mode",c_modes)end,function(a)menu_draw1(a,"mode",c_modes)end,function(a)menu_draw3(a,"mode",c_modes)end,function(a)
rectfill(0,0,46,13,13)
pal(7,1)
local xx=0
for i,v in ipairs(g_picodex_div)do
sspr(6*8+xx,6*8,v,8,xx+3,3.5+cos((t()+i)/4))
xx+=v
end
pal()
end,function(a)
_g.fader_in()
sfx(-2,0)
end,function(a)
menuitem(1,"factory reset",function()
sfx(59,0)
memset(0x5e00,0,0x100)
a:start_timer("shaking",.5)
end)
end,function(a)
if not any_btn()and a.backbuttonheld then
a.backbuttonheld=false
a:load()
menuitem(1)
elseif any_btn()then
a.backbuttonheld=true
menuitem(1)
end
end,function(a)
draw_picodex(a:is_active"shaking",-1,nop,nop,nop,a.light,a.backbuttonheld)
end,function(a)
draw_picodex(a:is_active"shaking",cos(a:get_elapsed_percent"closing"/2),nop,nop,nop)
end,function(a)
sfx(60,0)
end,function(a)
draw_picodex(a:is_active"shaking",1,nop,nop,nop,a.light)
end,function(a)
draw_picodex(a:is_active"shaking",-cos(a:get_elapsed_percent"opening"/2),nop,nop,nop)
end,function(a)
browse_update(a,"browse")
if g_bpx then a:push"browsestat" end
end,function(a)
browse_draw1(a,"browse")
end,function()draw2_pokeinfo(get_browse_pokemon(g_cursors.browse))end,function()draw3_pokeinfo(get_browse_pokemon(g_cursors.browse))end,function(a)
browseupdate_shared(a,"browse")
if g_bpu then poke(0x5ef5,max(0,@0x5ef5-1))end
if g_bpd then poke(0x5ef5,min(1,@0x5ef5+1))end
if g_bpx then sfx(flr(rnd(9)))end
end,function(a)
local pkmn=get_browse_pokemon(g_cursors.browse)
local style=c_bg_styles[c_types[pkmn.type1].bg]
rectfill(0,0,39,39,style.bg)
if@0x5ef5==0 then
rectfill(0,32,39,39,style.aa)
pkmn.draw(20,20,style.aa,2,2)
elseif@0x5ef5==1 then
rectfill(0,16,39,39,style.aa)
pkmn.draw(20,10,style.aa)
rectfill(0,21,39,39,1)
rectfill(6,21,33,39,7)
zcall(print,[[;,a,1,22,13;;,h,36,22,13;;,d,1,28,13;;,s,36,28,13;;,*,1,34,13;;,t,36,34,13]])
rectfill(19,20,20,39,1)
rectfill(0,20,39,20,1)
local total=pkmn.attack+pkmn.hp+pkmn.defence+pkmn.speed+pkmn.special
print(pkmn.attack,7,2+20,13)zprint(pkmn.hp,35,2+20,13,1)
print(pkmn.defence,7,8+20,13)zprint(pkmn.speed,35,8+20,13,1)
print(pkmn.special,7,14+20,13)zprint(total,35,14+20,13,1)
end
end,function(a)
if g_bpo then a:pop()end
if g_bu then a.credits_offset-=1/6 end
if g_bd then a.credits_offset+=1/6 end
a.credits_offset=a.credits_offset%#c_creditlist
end,function(a)
rectfill(0,0,39,39,1)
for i,txt in ipairs(c_creditlist)do
zprint(txt,20,(i-a.credits_offset)*6,13,0)
end
end,function(a)
if g_bpu then poke(0x5ef3,(@0x5ef3-3)%6)end
if g_bpd then poke(0x5ef3,(@0x5ef3+3)%6)end
if g_bpl then poke(0x5ef3,(@0x5ef3-1)%6)end
if g_bpr then poke(0x5ef3,(@0x5ef3+1)%6)end
if g_bpo then a:pop()end
if g_bpx then a:push"partyaction" end
end,function(a)
local party=get_party(@0x5ef4)
local xw,yw=.5,.5
local xp=13
local xo,yo=7,20
rectfill(0,0,39,39,1)
rectfill(-1,13,40,39,13)
for i=1,6 do
get_pokemon(party[i]and party[i].num or-2).draw(xo+(i-1)%3*xp,yo+(i-1)\3*xp,5,xw,yw)
end
zprint("team #"..@0x5ef4+1,20,3,13,0)
local row,col=@0x5ef3\3,@0x5ef3%3
rectfill(xo+col*xp-9,yo+row*xp-9,xo+col*xp+8,yo+row*xp+8,5)
rectfill(xo+col*xp-8,yo+row*xp-8,xo+col*xp+7,yo+row*xp+7,1)
rectfill(xo+col*xp-7,yo+row*xp-7,xo+col*xp+6,yo+row*xp+6,6)
get_pokemon(party[@0x5ef3+1]and party[@0x5ef3+1].num or-2).draw(xo+col*xp,yo+row*xp,13,.625,.625)
end,function(a)
local pkmn=get_party(@0x5ef4)[@0x5ef3+1]
if pkmn then
draw2_pokeinfo(get_pokemon(pkmn.num))
else
zprint("spot #"..(@0x5ef3+1),46/2,4,1,0)
end
end,function(a)
print_draw3_message("now","pick a","spot")
end,function(a,game)
local party=get_party(@0x5ef4)
party[@0x5ef3+1]=nil
save_party(@0x5ef4,party)
game:pop()
end,function(a)a.available_actions=get_partyactions()end,function(a)menu_update(a,"partyaction",a.available_actions)end,function(a)menu_draw1(a,"partyaction",a.available_actions)end,function(a)menu_draw3(a,"partyaction",a.available_actions)end,function(a)
g_cursors.party_pkmn=flr_rnd(#g_available_pokemon)+1
end,function(a)
browse_update(a,"party_pkmn")
if g_bpx then
save_party(@0x5ef4,set_default_party_pkmn(get_party(@0x5ef4),@0x5ef3+1,g_available_pokemon[g_cursors.party_pkmn]))
a:pop()a:pop()
end
end,function(a)browse_draw1(a,"party_pkmn")end,function()draw2_pokeinfo(get_browse_pokemon(g_cursors.party_pkmn))end,function()draw3_pokeinfo(get_browse_pokemon(g_cursors.party_pkmn))end,function(a)
a.moveset={}
local movedict={}
local party=get_party(@0x5ef4)
local partypkmn=party[@0x5ef3+1]
for i=1,4 do
add(a.moveset,{
name=partypkmn.moves[i]and c_moves[partypkmn.moves[i]].name or "<empty>",
func=function(a,game)
game:push"partymovesel"
end
})
end
end,function(a)menu_update(a,"partymoves",a.moveset)end,function(a)menu_draw1(a,"partymoves",a.moveset)end,function(a)
end,function(a)
end,function(a)
a.movelist={}
local movedict={}
local party=get_party(@0x5ef4)
local partypkmn=party[@0x5ef3+1]
local pkmn=c_pokemon[partypkmn.num]
for m in all(pkmn.moves)do
if not movedict[m.num]then
movedict[m.num]=true
add(a.movelist,{
name=c_moves[m.num].name,
ref=m.ref,
func=function(a,game)
save_party(@0x5ef4,set_party_pkmn_move(get_party(@0x5ef4),@0x5ef3+1,g_cursors.partymoves+1,m.num))
game:pop()
end
})
end
end
g_cursors.partymsel,g_views.partymsel=flr_rnd(#a.movelist),0
end,function(a)menu_update(a,"partymsel",a.movelist)end,function(a)menu_draw1(a,"partymsel",a.movelist)end,function(a)
local move=a.movelist[g_cursors.partymsel+1]
if move then
print(move.ref,3,3,1)
end
end,function(a)end,function(game)game.p0.winlogic()end,function(game)
if g_bpo or g_bpx then
game:pop()
end
end,function(game)print("todo",5,5,1)end,function(game)zprint("match over",23,4,1,0)end,function(game)print_draw3_message(game.p0.name,"is the","winner")end,function(a)
local party=get_party(@0x5ef4)
for i=1,6 do
if party[i]then
a:push"fightsel"
return
end
end
sfx"60"
end,function(a)
a.available_actions={
{name="bugcatcher",func=function(a,game)
local cpu_party_draft={}
for i=1,6 do
local num=flr_rnd(151)+1
add(cpu_party_draft,{num=num,moves=c_pokemon[num].get_natural_moveset(100)})
end
begin_fight(game,100,get_party(@0x5ef4),cpu_party_draft,"player 1","bugcatcher",false,true)
end,desc="i|like|bugs"}
}
end,function(a)menu_update(a,"fightsel",a.available_actions)end,function(a)menu_draw1(a,"fightsel",a.available_actions)end,function(a)end,function(a)menu_draw3(a,"fightsel",a.available_actions)end,function(game)
game:push"editparty"
end,function(game)
game.available_actions={}
for i=1,3 do
add(game.available_actions,{name="team #"..i,func=function()
poke(0x5ef4,i-1)
game:select_func()
end})
end
end,function(a)menu_update(a,"party",a.available_actions)end,function(a)menu_draw1(a,"party",a.available_actions)end,function(game)
for p in all{game.p1,game.p2}do
if #p.actions==0 then
select_move(p,select_random_move_slot(p.active))
end
end
local p1,p2=game.p1,game.p2
if p1.priority==p2.priority then p2.priority+=sgn(rnd"2"-1)end
game.p0=p1.priority>p2.priority and p1 or p2
end,function(game)
if g_bpx or g_bpo or not game.cur_action then
for p in all{game.p1,game.p2}do
if not get_next_active(p.party)then
game.p0=get_other_pl(game,p)
game:load"fightover"
return
end
end
local action=pop_next_action(game)
if action then
game.cur_action=action
local actionpl=game.cur_action.active==game.p1.active and game.p1 or game.p2
action.logic(actionpl,get_other_pl(game,actionpl),game)
else
game:load()
end
end
end,function(game)
local a1,a2,active=game.p1.active,game.p2.active,game.cur_action.active
draw_hp(38,30,a1.shared.hp,a1.shared.maxhp,a1.shared.major,1,active==game.p1.active and 6 or 1)
draw_hp(1,9,a2.shared.hp,a2.shared.maxhp,a2.shared.major,-1,active==game.p2.active and 6 or 1)
c_pokemon[a1.shared.num].draw(10,40-10-t()%2\1,5)
c_pokemon[a2.shared.num].draw(40-10,10+t()%2\1,5,-1)
end,function(game)
zprint(game.cur_action.pl.name,23,4,1,0)
end,function(game)
local message_tbl=split(game.cur_action.message)
if message_tbl[1]=="#"then message_tbl[1]=c_pokemon[game.cur_action.active.shared.num].name end
print_draw3_message(unpack(message_tbl))
end,function(game)
game.p0=game[game.p0key]
g_cursors.pselaction=0
if game.p0.iscpu or #game.p0.actions>0 then
game:load()
else
game.cur_action=newaction(game.p0,"")
game:push"pselactions"
end
end,function(game)menu_update(game,"pselaction",c_pselactions,true)end,function(game)menu_draw1(game,"pselaction",c_pselactions)end,function(game)end,function(game)end,function(a,game)
game:pop()
game.p0=get_other_pl(game,game.p0)
game:load"fightover"
end,function(game)
game.available_actions={}
local possible_moves=get_possible_move_slots(game.p0.active)
for move_slot in all(possible_moves)do
add(game.available_actions,{
name=c_moves[game.p0.active.moveids[move_slot]].name,
desc="todo",
func=function()
game:pop()
game:pop()
select_move(game.p0,move_slot)
end
})
end
end,function(game)menu_update(game,"pselaction",game.available_actions)end,function(game)menu_draw1(game,"pselaction",game.available_actions)end,function(game)end,function(game)end,function(a)
poke(0x5f43,0xff)
g_fade=a:get_elapsed_percent"start"
end,function(a)
g_fade=1-a:get_elapsed_percent"start"
end,function()sfx(63,1)end,function(a)
g_fade=cos(a:get_elapsed_percent"logo")+1
camera(g_fade>.5 and rnd_one())
zspr(108,64,64,4,2)
camera()
end,function(state)
clean_all_entities("game_state","fader_in")
state:sinit()
end)
function zspr(sind,x,y,sw,sh,...)
sw,sh=sw or 1,sh or 1
spr(sind,x-sw*4,y-sh*4,sw,sh,...)
end
function flr_rnd(x)
return flr(rnd(x))
end
function rnd_one(val)
return(flr_rnd"3"-1)*(val or 1)
end
function zcall_tbl(func,tbl)
foreach(tbl,function(params)
func(unpack(params))
end)
end
function zcall(func,text,...)
zcall_tbl(func,zobj(text,...))
end
function zcls(col)
rectfill(0x8000,0x8000,0x7fff,0x7fff,col or 0)
end
zclass[[actor,timer|load,%actor_load,loadlogic,%actor_loadlogic,state,%actor_state,kill,%actor_kill,clean,%actor_clean,is_alive,%actor_is_alive,alive,yes,duration,null,curr,start,next,null,isnew,yes,init,nop,finit,nop,stateless_update,nop,update,nop,destroyed,nop;]]
zclass[[drawlayer_50|]]
zclass[[timer|timers;,;start_timer,%timer_reset_timer,end_timer,%timer_end_timer,is_active,%timer_is_active,get_elapsed_percent,%timer_get_elapsed_percent,tick,%timer_tick,]]
c_pokemon=zobj[[0;,0,missingno,0,1,33,136,0,29,6,1,1;;,0,bulbasaur,8,5,45,49,49,45,65,1,1,7,13,20,27,34,41,48;;,1,ivysaur,8,5,60,62,63,60,80,1,1,7,13,22,30,38,46,54;;,1,venusaur,8,5,80,82,83,80,100,1,1,7,13,22,30,43,55,65;;,0,charmander,2,no,39,52,43,65,50,1,1,9,15,22,30,38,46;;,1,charmeleon,2,no,58,64,58,80,65,1,1,9,15,24,33,42,56;;,1,charizard,2,9,78,84,78,100,85,1,1,9,15,24,36,46,55;;,0,squirtle,4,no,44,48,65,43,50,1,1,8,15,22,28,35,42;;,1,wartortle,4,no,59,63,80,58,65,1,1,8,15,24,31,39,47;;,1,blastoise,4,no,79,83,100,78,85,1,1,8,15,24,31,42,52;;,0,caterpie,11,no,45,30,35,45,20,1,1;;,1,metapod,11,no,50,20,55,30,25,1;;,1,butterfree,11,9,60,45,50,70,80,1,15,16,17,21,26,28,34;;,0,weedle,11,5,40,35,30,50,20,1,1;;,1,kakuna,11,5,45,25,50,35,25,1;;,1,beedrill,11,5,65,80,40,75,45,1,16,20,25,30,35;;,0,pidgey,1,9,40,45,40,56,35,1,5,12,19,28,36,44;;,1,pidgeotto,1,9,63,60,55,71,50,1,5,12,21,31,40,49;;,1,pidgeot,1,9,83,80,75,91,70,1,5,12,21,31,44,54;;,0,rattata,1,no,30,56,35,72,25,1,1,7,14,23,34;;,1,raticate,1,no,55,81,60,97,50,1,1,7,14,27,41;;,0,spearow,1,9,40,60,30,70,31,1,1,9,15,22,29,36;;,1,fearow,1,9,65,90,65,100,61,1,1,9,15,25,34,43;;,0,ekans,5,no,35,60,44,55,40,1,1,10,17,24,31,38;;,1,arbok,5,no,60,85,69,80,65,1,1,10,17,27,36,47;;,0,pikachu,6,no,35,55,30,90,50,1,1,6,9,15,16,20,26,26,33,43,50;;,1,raichu,6,no,60,90,55,100,90,1,1,1;;,0,sandshrew,7,no,50,75,85,40,30,1,10,17,24,31,38;;,1,sandslash,7,no,75,100,110,65,55,1,10,17,27,36,47;;,0,nidoran?,5,no,55,47,52,41,40,1,1,8,17,23,30,38,43;;,1,nidorina,5,no,70,62,67,56,55,1,1,8,19,27,36,46,50;;,1,nidoqueen,5,7,90,82,87,76,75,1,1,8,12,14,23;;,0,nidoran!,5,no,46,57,40,50,40,1,1,8,17,23,30,38,43;;,1,nidorino,5,no,61,72,57,65,55,1,1,8,19,27,36,46,50;;,1,nidoking,5,7,81,92,77,85,75,1,8,12,14,23;;,0,clefairy,1,no,70,45,48,35,60,1,1,13,18,24,31,39,48;;,1,clefable,1,no,95,70,73,60,85,1,1,1,1;;,0,vulpix,2,no,38,41,40,65,65,1,1,16,21,28,35,42;;,1,ninetales,2,no,73,76,75,100,100,1,1,1,1;;,0,jigglypuff,1,no,115,45,20,20,25,1,9,14,19,24,29,34,39;;,1,wigglytuff,1,no,140,70,45,45,50,1,1,1,1;;,0,zubat,5,9,40,45,35,55,40,1,10,15,21,28,36;;,1,golbat,5,9,75,80,70,90,75,1,1,10,15,21,32,43;;,0,oddish,8,5,45,50,55,30,75,1,15,17,19,24,33,46;;,1,gloom,8,5,60,65,70,40,85,1,15,17,19,28,38,52;;,1,vileplume,8,5,75,80,85,50,100,1,1,15,17,19;;,0,paras,11,8,35,70,55,25,55,1,13,20,27,34,41;;,1,parasect,11,8,60,95,80,30,80,1,13,20,30,39,48;;,0,venonat,11,5,60,55,50,45,40,1,1,11,19,24,27,30,35,38,43;;,1,venomoth,11,5,70,65,60,90,90,1,1,1,1,24,27,30,38,43,50;;,0,diglett,7,no,10,55,25,95,45,1,15,19,24,31,40;;,1,dugtrio,7,no,35,80,50,120,70,1,15,19,24,35,47;;,0,meowth,1,no,40,45,35,90,40,1,1,12,17,24,33,44;;,1,persian,1,no,65,70,60,115,65,1,1,12,17,24,37,51;;,0,psyduck,4,no,50,52,48,55,50,1,28,31,36,43,52;;,1,golduck,4,no,80,82,78,85,80,1,28,31,39,48,59;;,0,mankey,3,no,40,80,35,70,35,1,1,9,15,21,27,33,39,45;;,1,primeape,3,no,65,105,60,95,60,1,1,9,15,21,27,28,37,45,46;;,0,growlithe,2,no,55,70,45,60,50,1,1,18,23,30,39,50;;,1,arcanine,2,no,90,110,80,95,80,1,1,1,1;;,0,poliwag,4,no,40,50,40,90,40,1,16,19,25,31,38,45;;,1,poliwhirl,4,no,65,65,65,90,50,1,16,19,26,33,41,49;;,1,poliwrath,4,3,90,85,95,70,70,1,1,16,19;;,0,abra,12,no,25,20,15,90,105,1;;,1,kadabra,12,no,40,35,30,105,120,1,1,16,20,27,31,38,42;;,1,alakazam,12,no,55,50,45,120,135,1,1,16,20,27,31,38,42;;,0,machop,3,no,70,80,50,35,35,1,20,25,32,39,46;;,1,machoke,3,no,80,100,70,45,50,1,20,25,36,44,52;;,1,machamp,3,no,90,130,80,55,65,1,20,25,36,44,52;;,0,bellsprout,8,5,50,75,35,40,70,1,1,13,15,18,21,26,33,42;;,1,weepinbell,8,5,65,90,50,55,85,1,1,13,15,18,23,29,38,49;;,1,victreebel,8,5,80,105,65,70,100,1,1,1,13,15,18;;,0,tentacool,4,5,40,40,35,70,100,1,7,13,18,22,27,33,40,48;;,1,tentacruel,4,5,80,70,65,100,120,1,7,13,18,22,27,35,43,50;;,0,geodude,13,7,40,80,100,20,30,1,11,16,21,26,31,36;;,1,graveler,13,7,55,95,115,35,45,1,11,16,21,29,36,43;;,1,golem,13,7,80,110,130,45,55,1,11,16,21,29,36,43;;,0,ponyta,2,no,50,85,55,90,65,1,30,32,35,39,43,48;;,1,rapidash,2,no,65,100,70,105,80,1,30,32,35,39,47,55;;,0,slowpoke,4,12,90,65,65,15,40,1,18,22,27,33,40,48;;,1,slowbro,4,12,95,75,110,30,80,1,18,22,27,33,37,44,55;;,0,magnemite,6,no,25,35,70,45,95,1,21,25,29,35,41,47;;,1,magneton,6,no,50,60,95,70,120,1,21,25,29,38,46,54;;,0,farfetchd,1,9,52,65,55,60,58,1,1,7,15,23,31,39;;,0,doduo,1,9,35,85,45,75,35,1,20,24,30,36,40,44;;,1,dodrio,1,9,60,110,70,100,60,1,20,24,30,39,45,51;;,0,seel,4,no,65,45,55,45,70,1,30,35,40,45,50;;,1,dewgong,4,10,90,70,80,70,95,1,30,35,44,50,56;;,0,grimer,5,no,80,80,50,25,40,1,1,30,33,37,42,48,55;;,1,muk,5,no,105,105,75,50,65,1,1,30,33,37,45,53,60;;,0,shellder,4,no,30,65,100,40,45,1,1,18,23,30,39,50;;,1,cloyster,4,10,50,95,180,70,85,1,1,1,1,50;;,0,gastly,15,5,30,35,30,80,100,1,1,1,27,35;;,1,haunter,15,5,45,50,45,95,115,1,1,1,29,38;;,1,gengar,15,5,60,65,60,110,130,1,1,1,29,38;;,0,onix,13,7,35,45,160,70,30,1,1,15,19,25,33,43;;,0,drowzee,12,no,60,48,45,42,90,1,1,12,17,24,29,32,37;;,1,hypno,12,no,85,73,70,67,115,1,1,12,17,24,33,37,43;;,0,krabby,4,no,30,105,90,50,25,1,1,20,25,30,35,40;;,1,kingler,4,no,55,130,115,75,50,1,1,20,25,34,42,49;;,0,voltorb,6,no,40,30,50,100,55,1,1,17,22,29,36,43;;,1,electrode,6,no,60,50,70,140,80,1,1,17,22,29,40,50;;,0,exeggcute,8,12,60,40,80,40,60,1,1,25,28,32,37,42,48;;,1,exeggutor,8,12,95,95,85,55,125,1,1,28;;,0,cubone,7,no,50,50,95,35,40,1,10,13,18,25,31,38,43,46;;,1,marowak,7,no,60,80,110,45,50,1,10,13,18,25,33,41,48,55;;,0,hitmonlee,3,no,50,120,53,87,35,1,1,33,38,43,48,53;;,0,hitmonchan,3,no,50,105,79,76,35,1,1,33,38,43,48,53;;,0,lickitung,1,no,90,55,75,30,60,1,1,7,15,23,31,39;;,0,koffing,5,no,40,65,95,35,60,1,1,32,37,40,45,48;;,1,weezing,5,no,65,90,120,60,85,1,1,32,39,43,49,53;;,0,rhyhorn,7,13,80,85,95,25,30,1,30,35,40,45,50,55;;,1,rhydon,7,13,105,130,120,40,45,1,30,35,40,48,55,64;;,0,chansey,1,no,250,5,5,50,105,1,1,12,24,30,38,44,48,54;;,0,tangela,8,no,65,55,115,60,100,1,24,29,29,32,36,39,45,49;;,0,kangaskhan,1,no,105,95,80,90,40,1,1,26,31,36,41,46;;,0,horsea,4,no,30,40,70,60,70,1,19,24,30,37,45;;,1,seadra,4,no,55,65,95,85,95,1,19,24,30,41,52;;,0,goldeen,4,no,45,67,60,63,50,1,1,19,24,30,37,45,54;;,1,seaking,4,no,80,92,65,68,80,1,1,19,24,30,39,48,54;;,0,staryu,4,no,30,45,55,85,70,1,17,22,27,32,37,42,47;;,1,starmie,4,12,60,75,85,115,100,1,1,1;;,0,mr mime,12,no,40,45,65,90,100,1,15,23,31,39,47;;,0,scyther,11,9,70,110,80,105,55,1,17,20,24,29,35,42,50;;,0,jynx,10,12,65,50,35,95,95,1,1,18,23,31,39,47,58;;,0,electabuzz,6,no,65,83,57,105,85,1,1,34,37,42,49,54;;,0,magmar,2,no,65,95,57,93,85,1,36,39,43,48,52,55;;,0,pinsir,11,no,65,125,100,85,55,1,21,25,30,36,43,49,54;;,0,tauros,1,no,75,100,95,110,70,1,21,28,35,44,51;;,0,magikarp,4,no,20,10,55,80,20,1,15;;,1,gyarados,4,9,95,125,79,81,100,1,20,25,32,41,52;;,0,lapras,4,10,130,85,80,60,95,1,1,16,20,25,31,38,46;;,0,ditto,1,no,48,48,48,48,48,1;;,0,eevee,1,no,55,55,50,55,65,1,8,16,27,31,36,37,45;;,1,vaporeon,4,no,130,65,60,65,110,1,8,27,31,36,37,40,44,47,48,54;;,2,jolteon,6,no,65,65,60,130,110,1,8,27,31,37,42,42,47,48,54;;,3,flareon,2,no,65,130,60,65,110,1,8,27,31,37,40,42,44,47,48,54;;,0,porygon,1,no,65,60,70,40,75,1,1,1,23,28,35,42;;,0,omanyte,13,4,35,40,100,35,90,1,1,34,39,46,53;;,1,omastar,13,4,70,60,125,55,115,1,1,34,39,44,49;;,0,kabuto,13,4,30,80,90,55,45,1,1,34,39,44,49;;,1,kabutops,13,4,60,115,105,80,70,1,1,34,39,46,53;;,0,aerodactyl,13,9,80,105,65,130,60,1,1,33,38,45,54;;,0,snorlax,1,no,160,110,65,30,65,1,1,1,35,41,48,56;;,0,articuno,10,9,90,85,100,85,125,1,1,51,55,60;;,0,zapdos,6,9,90,90,85,100,125,1,1,51,55,60;;,0,moltres,2,9,90,100,90,90,125,1,1,51,55,60;;,0,dratini,14,no,41,64,45,50,50,1,1,10,20,30,40,50;;,1,dragonair,14,no,61,84,65,70,70,1,1,10,20,35,45,55;;,1,dragonite,14,9,91,134,95,80,100,1,1,10,20,35,45,60;;,0,mewtwo,12,no,106,110,90,130,154,1,1,1,63,66,70,75,81;;,0,mew,12,no,100,100,100,100,100,1,10,20,30,40]]
c_types=zobj[[0;bg,0,name,bird;0;good;,;0;null;,;0;weak;,;1;bg,0,name,normal;1;good;,;1;null;,15;1;weak;,13;2;bg,5,name,fire;2;good;,8,10,11;2;null;,;2;weak;,2,4,13,14;3;bg,2,name,fighting;3;good;,10,1,13;3;null;,15;3;weak;,11,9,5,12;4;bg,4,name,water;4;good;,2,7,13;4;null;,;4;weak;,14,8,4;5;bg,1,name,poison;5;good;,11,8;5;null;,;5;weak;,15,7,5,13;6;bg,6,name,electric;6;good;,9,4;6;null;,7;6;weak;,14,6,8;7;bg,2,name,ground;7;good;,6,2,5,13;7;null;,9;7;weak;,11,8;8;bg,3,name,grass;8;good;,7,13,4;8;null;,;8;weak;,11,14,2,9,8,5;9;bg,0,name,flying;9;good;,11,3,8;9;null;,;9;weak;,6,13;10;bg,4,name,ice;10;good;,14,9,8;10;null;,;10;weak;,2,10,4;11;bg,3,name,bug;11;good;,8,12;11;null;,;11;weak;,3,2,9,15,5;12;bg,1,name,psychic;12;good;,3,5;12;null;,;12;weak;,12;13;bg,0,name,rock;13;good;,11,2,9,10;13;null;,;13;weak;,3,7;14;bg,0,name,dragon;14;good;,14;14;null;,;14;weak;,;15;bg,1,name,ghost;15;good;,15;15;null;,1,12;15;weak;,]]
c_bg_styles=zobj[[0;bg,6,aa,13;;bg,13,aa,5;;bg,9,aa,4;;bg,11,aa,3;;bg,12,aa,5;;bg,8,aa,2;;bg,10,aa,4]]
c_zmovetype=zobj[[0;name,status;;name,physical;;name,special;]]
c_moves=zobj[[0;,struggle,1,0,50,1;;,megapunch,1,20,80,.85;;,razorwind,1,10,80,1;;,swordance,1,20,0,0;;,whirlwind,1,20,0,0;;,megakick,1,5,120,.75;;,toxic,5,10,0,.9;;,horndrill,1,5,0,.3;;,bodyslam,1,15,85,1;;,takedown,1,20,90,.85;;,doubledge,1,15,120,1;;,bublebeam,4,20,65,1;;,watergun,4,25,40,1;;,icebeam,10,10,90,1;;,blizzard,10,5,110,.7;;,hyperbeam,1,5,150,.9;;,payday,1,20,40,1;;,submision,3,20,80,.8;;,counter,3,20,0,1;;,seismctss,3,20,0,1;;,rage,1,20,20,1;;,megadrain,8,15,40,1;;,solarbeam,8,10,120,1;;,drgonrage,14,10,0,1;;,thndrbolt,6,15,90,1;;,thunder,6,10,110,.7;;,eartquake,7,10,100,1;;,fissure,7,5,0,.3;;,dig,7,10,80,1;;,psychic,12,10,90,1;;,teleport,12,20,0,0;;,mimic,1,10,0,0;;,dubleteam,1,15,0,0;;,reflect,12,20,0,0;;,bide,1,10,0,0;;,metronome,1,10,0,0;;,slfdstrct,1,5,200,1;;,eggbomb,1,10,100,.75;;,fireblast,2,5,110,.85;;,swift,1,20,60,2;;,skullbash,1,10,130,1;;,softboild,1,5,0,0;;,dreameatr,12,15,100,1;;,skyattack,9,5,140,.9;;,rest,12,5,0,0;;,thndrwave,6,20,0,.9;;,psywave,12,15,0,1;;,explosion,1,5,250,1;;,rockslide,13,10,75,.9;;,triattack,1,10,80,1;;,sbstitute,1,10,0,0;;,cut,1,30,50,.95;;,fly,9,15,90,.95;;,surf,4,15,90,1;;,strength,1,15,80,1;;,flash,1,20,0,1;;,pound,1,35,40,1;;,karatechp,3,25,50,1;;,dubleslap,1,10,15,.85;;,cometpnch,1,15,18,.85;;,firepunch,2,15,75,1;;,icepunch,10,15,75,1;;,thndrpnch,6,15,75,1;;,scratch,1,35,40,1;;,vicegrip,1,30,55,1;;,guilotine,1,5,0,.3;;,gust,9,35,40,1;;,wingattck,9,35,60,1;;,bind,1,20,15,.85;;,slam,1,20,80,.75;;,vinewhip,8,25,45,1;;,stomp,1,20,65,1;;,dublekick,3,30,30,1;;,jumpkick,3,10,100,.95;;,rolingkck,3,15,60,.85;;,sandattck,7,15,0,1;;,headbutt,1,15,70,1;;,hornattck,1,25,65,1;;,furyattck,1,20,15,.85;;,tackle,1,35,40,1;;,wrap,1,20,15,.9;;,thrash,1,10,120,1;;,tailwhip,1,30,0,1;;,psnsting,5,35,15,1;;,twineedle,11,20,25,1;;,pinmisile,11,20,25,.95;;,leer,1,30,0,1;;,bite,1,25,60,1;;,growl,1,40,0,1;;,roar,1,20,0,1;;,sing,1,15,0,.55;;,suprsonic,1,20,0,.55;;,sonicboom,1,20,0,.9;;,disable,1,20,0,1;;,acid,5,30,40,1;;,ember,2,25,40,1;;,flmethrwr,2,15,90,1;;,mist,10,30,0,0;;,hydropump,4,5,110,.8;;,psybeam,12,20,65,1;;,aurorbeam,10,20,65,1;;,peck,9,35,35,1;;,drillpeck,9,20,80,1;;,lowkick,3,20,0,1;;,absorb,8,25,20,1;;,leechseed,8,10,0,.9;;,growth,1,20,0,0;;,razorleaf,8,25,55,.95;;,psnpowder,5,35,0,.75;;,stunspore,8,30,0,.75;;,slppowder,8,15,0,.75;;,petldance,8,10,120,1;;,stringsht,11,40,0,.95;;,firespin,2,15,35,.85;;,thndrshck,6,30,40,1;;,rockthrow,13,15,50,.9;;,confusion,12,25,50,1;;,hypnosis,12,20,0,.6;;,meditate,12,40,0,0;;,agility,12,30,0,0;;,quickatck,1,30,40,1;;,niteshade,15,15,0,1;;,screech,1,40,0,.85;;,recover,1,5,0,0;;,harden,1,30,0,0;;,minimize,1,10,0,0;;,smokescrn,1,20,0,1;;,confusray,15,10,0,1;;,withdraw,4,40,0,0;;,defenscrl,1,40,0,0;;,barrier,12,20,0,0;;,lightscrn,12,30,0,0;;,haze,10,30,0,0;;,focusnrgy,1,30,0,0;;,mirormove,9,20,0,0;;,lick,15,30,30,1;;,smog,5,20,30,.7;;,sludge,5,20,65,1;;,boneclub,7,20,65,.85;;,waterfall,4,15,80,1;;,clamp,4,15,35,.85;;,spikcanon,1,15,20,1;;,constrict,1,35,10,1;;,amnesia,12,20,0,0;;,kinesis,12,15,0,.8;;,hghjmpkck,3,10,130,.9;;,glare,1,30,0,1;;,poisongas,5,40,0,.9;;,barrage,1,20,15,.85;;,leechlife,11,10,80,1;;,lovelykss,1,10,0,.75;;,transform,1,10,0,0;;,bubble,4,30,40,1;;,dizypunch,1,10,70,1;;,spore,8,15,0,1;;,splash,1,40,0,0;;,acidarmor,5,20,0,0;;,crbhammer,4,10,100,.9;;,furyswipe,1,15,18,.8;;,bonemrang,7,10,50,.9;;,hyperfang,1,15,80,.9;;,sharpen,1,30,0,0;;,convrsion,1,30,0,0;;,superfang,1,10,0,.9;;,slash,1,20,70,1]]
function menu_update(game,key,entries,is_pop_disabled)
local c,v=g_cursors[key],g_views[key]
if g_bpu then c=max(0,c-1)end
if g_bpd then c=min(#entries-1,c+1)end
if c<v+1 then v=c-1 end
if c>v+3 then v=c-3 end
if #entries==1 then v=-1 end
if #entries==2 then v=-1 end
if g_bpx then
if entries[c+1].func then
entries[c+1]:func(game)
end
end
if g_bpo and not is_pop_disabled then game:pop()end
g_cursors[key]=c%#entries
g_views[key]=v
end
function menu_draw1(game,key,entries)
local c,v=g_cursors[key],g_views[key]
local y=-5
rectfill(0,0,39,39,1)
rectfill(-1,y-v*8+3,40,y-v*8+max(#entries,3)*8+6,13)
for i=1,#entries do
local basey=y+(i-v)*7
local yoff=4
if i<c+1 then yoff-=2 end
if i>c+1 then yoff+=3 end
if i==c+1 then
rectfill(0,yoff+basey-3-3,39,yoff+basey+5,5)
rectfill(0,yoff+basey-3-2,39,yoff+basey+4,1)
rectfill(0,yoff+basey-3-1,39,yoff+basey+3,6)
wobble_text(entries[i].name,20,yoff+basey-3,13)
else
zprint(entries[i].name,20,basey-3+yoff,1,0)
end
end
end
function menu_draw3(game,key,entries)
print_draw3_message(unpack(split(entries[g_cursors[key]+1].desc,"|")))
end
zclass[[modes,actor|push,%modes_push,pop,%modes_pop,update,nop,draw1,nop,draw2,nop,draw3,nop,curr,main;stack;,;defaults;sub,0,init,nop,update,nop,finit,nop,draw1,nop,draw2,nop,draw3,nop;main;update,%main_update,draw1,%main_draw1,draw2,%main_draw2,draw3,%main_draw3;credits;update,%credits_update,draw1,%credits_draw1,draw2,%main_draw2,draw3,%main_draw3,credits_offset,5;browse;update,%browse_update,draw1,%browse_draw1,draw2,%browse_draw2,draw3,%browse_draw3;browsestat;update,%browsestat_update,draw1,%browsestat_draw1,draw2,%browse_draw2,draw3,%browse_draw3;fightparty;update,%party_update,draw1,%party_draw1,draw2,%party_draw2,draw3,%party_draw3,select_func,%fight_select;fightsel;update,%fightsel_update,draw1,%fightsel_draw1,draw2,%fightsel_draw2,draw3,%fightsel_draw3,init,%fightsel_init;fightover;update,%fightover_update,draw1,%fightover_draw1,draw2,%fightover_draw2,draw3,%fightover_draw3,init,%fightover_init;p1sel;next,p2sel,init,%psel_init,p0key,p1;p2sel;next,turn,init,%psel_init,p0key,p2;turn;next,p1sel,update,%turn_update,draw1,%turn_draw1,draw2,%turn_draw2,draw3,%turn_draw3,init,%turn_init,cur_action,no;pselactions;update,%pselactions_update,draw1,%pselactions_draw1,draw2,%turn_draw2,draw3,%pselactions_draw3;pselmove;update,%pselmove_update,draw1,%pselmove_draw1,draw2,%turn_draw2,draw3,%pselmove_draw3,init,%pselmove_init;party;update,%party_update,draw1,%party_draw1,draw2,%party_draw2,draw3,%party_draw3,init,%party_init,select_func,%party_select;editparty;update,%editparty_update,draw1,%editparty_draw1,draw2,%editparty_draw2,draw3,%editparty_draw3;partyaction;update,%partyaction_update,draw1,%partyaction_draw1,draw2,%editparty_draw2,draw3,%partyaction_draw3,init,%partyaction_init;partypkmn;update,%partypkmn_update,draw1,%partypkmn_draw1,draw2,%partypkmn_draw2,draw3,%partypkmn_draw3,init,%partypkmn_init;partymoves;update,%partymoves_update,draw1,%partymoves_draw1,draw2,%editparty_draw2,draw3,%partymoves_draw3,init,%partymoves_init;partymovesel;update,%partymovesel_update,draw1,%partymovesel_draw1,draw2,%partymovesel_draw2,draw3,%partymovesel_draw3,init,%partymovesel_init;]]
c_modes=zobj[[;name,browse,state,browse,func,%menu_state_callback,desc,view|pokemon|info;;name,teams,state,party,func,%menu_state_callback,desc,edit|stored|teams;;name,computer,state,fightparty,func,%menu_state_callback,desc,battle|against|computer;;name,player,state,games,func,%menu_state_callback,desc,battle|against|player;;name,hoard,state,settings,func,%menu_state_callback,desc,battle all|pokemon|in order;;name,info,state,credits,func,%menu_state_callback,desc,help|and|credits]]
g_picodex_div=zobj[[,6,5,5,6,6,5,6]]
function any_btn()return g_bl or g_br or g_bu or g_bd or g_bx or g_bo end
function draw_picodex(shaking,rotation,l_screen,tr_screen,br_screen,light,backbuttonheld,top_row_buttons,bot_row_buttons)
light=light or 0
camera(-28+(rotation+1)*14+(shaking and flr(rnd(3)-1)or 0),-15)
draw_back_panel(light)
draw_left_flap(light>=4,l_screen)
draw_right_flap(light>=4,rotation,backbuttonheld,tr_screen,br_screen,top_row_buttons,bot_row_buttons)
camera(0,0)
end
function smap(cx,cy,cw,ch,sx,sy,sw,sh,flipx)
local dx,dy=cw/sw,ch/sh
if flipx then
cx+=cw
dx=-dx
end
if(sx<0)cx-=sx*dx sx=0
if(sy<0)cy-=sy*dy sy=0
if(sw>128)sw=128
if(sh>128)sh=128
if sh<sw then
for y=sy,sy+sh-1 do
tline(sx,y,sx+sw-1,y,cx,cy,dx,0)
cy+=dy
end
else
for x=sx,sx+sw-1 do
tline(x,sy,x,sy+sh-1,cx,cy,0,dy)
cx+=dx
end
end
end
function wobble_text(text,x,y,color)
x-=#text*2
local t1=""
local t2=""
for i=1,#text do
letter=sub(text,i,i)
if letter=="!"then
letter="\^:040e040e0e000000"
end
if letter=="?"then
letter="\^:0e0e040e04000000"
end
if i%2==0 then
t1=t1.." "
t2=t2..letter
else
t1=t1..letter
t2=t2.." "
end
end
print(t1,x,y+(t()%2),color)
print(t2,x,y+((t()+1)%2),color)
end
function zprint(str,x,y,color,align)
str=""..str
if align==0 then x-=#str*2
elseif align>0 then x-=#str*4+1 end
print(str,x,y,color)
end
function draw_screen(xoff,yoff,w,h,screen_func)
local ox,oy=%0x5f28,%0x5f2a
clip(-ox+xoff,-oy+yoff,w,h)
camera(ox-xoff,oy-yoff)
screen_func()
camera(ox,oy)
clip()
end
function draw_left_flap(is_on,screen_func)
rectfill(-1+5,9+5,8*8-5,11*8-5,is_on and 13 or 5)
if is_on then draw_screen(11,21,40,40,screen_func)end
map(8,0,-1,9,8,11)
spr(g_bl and 186 or 154,07,77)
spr(g_br and 188 or 156,23,77)
spr(g_bu and 171 or 139,15,73)
spr(g_bd and 187 or 155,15,81)
spr(g_bo and 170 or 138,39,77)
spr(g_bx and 172 or 140,47,77)
end
function draw_right_flap(is_on,flap_rotation,backbuttonheld,topscreen_func,botscreen_func,top_row_buttons,bot_row_buttons)
if flap_rotation<0 then
smap(0,0,8,11,8*8*(1-abs(flap_rotation))-1,9,8*8*abs(flap_rotation),11*8)
if flap_rotation==-1 and backbuttonheld then spr(123,3,49)end
elseif flap_rotation>0 then
rectfill(65+5,9+5,65+8*8*flap_rotation-5,9+11*8-5,is_on and 13 or 5)
if flap_rotation==1 and is_on then
draw_screen(74,18,46,13,topscreen_func)
draw_screen(74,67,46,21,botscreen_func)
end
smap(16,0,8,11,65,9,8*8*flap_rotation,11*8)
if flap_rotation==1 then
if top_row_buttons then spr(100,73+(top_row_buttons\1%6)*8,41)end
if bot_row_buttons then spr(100,73+(bot_row_buttons\1%6)*8,49)end
end
end
end
function draw_back_panel(light)
local rate=t()*7
map(24,0,-1,1,9,12)
spr((light>0)and(rate%11<.5 and 131 or 130)or 132,19,3)
spr((light>1)and(rate%13<.5 and 131 or 129)or 132,14,3)
spr((light>2)and(rate%17<.5 and 131 or 128)or 132,9,3)
spr((light>3)and(rate%43<.5 and 134 or 133)or 135,3,3)
end
function set_browse(delta,key)
local newval=g_cursors[key]+delta
if newval==mid(1,#g_available_pokemon,newval)then
g_cursors[key]=newval
end
g_cursors[key]=mid(1,#g_available_pokemon,g_cursors[key])
end
function browseupdate_shared(a,key)
set_browse(0,key)
if g_bpl then set_browse(-1,key)end
if g_bpr then set_browse(1,key)end
if g_bpo then a:pop()end
end
function browse_update(a,key)
browseupdate_shared(a,key)
if g_bpu then set_browse(-4,key)end
if g_bpd then set_browse(4,key)end
end
function browse_draw1(a,key)
local c,v=g_cursors[key]-1,g_views[key]
local pkmn=get_browse_pokemon(c+1)
local xo,yo,pad=5,5,10
if c\4<v then v=c\4 end
if c\4>v+3 then v=c\4-3 end
v=max(0,min(152/4-4,v))
for j=0,3 do
for i=0,3 do
get_browse_pokemon((v+j)*4+i+1).draw(i*pad+xo,j*pad+yo,5,.375,.375)
end
end
local x,y=(c%4)*pad+xo,(c\4-v)*pad+yo
if(c)%4==0 then x+=1 end
if(c)%4==3 then x-=1 end
if(c)\4-v==0 then y+=1 end
if(c)\4-v==3 then y-=1 end
rectfill(x-7-1,y-7-1,x+6+1,y+6+1,5)
rectfill(x-6-1,y-6-1,x+5+1,y+5+1,6)
pkmn.draw(x,y,13,.5,.5)
rect(x-7,y-7,x+6,y+6,1)
g_views[key]=v
end
function draw2_pokeinfo(pkmn)zprint(pkmn.name,46/2,4,1,0)end
function draw3_pokeinfo(pkmn)
rectfill(0,0,46,6,1)
zprint(format_num(pkmn.num),23,1,13,0)
zprint(c_types[pkmn.type1].name,23,8,1,0)
if pkmn.type2 then
rectfill(0,14,46,20,1)
zprint(c_types[pkmn.type2].name,23,15,13,0)
end
end
g_loaded_row=16
function draw_pkmn(num,x,y,sw,sh)
if num<0 then rectfill(x-1,y-1,x,y-num%2,6)return end
sw=sw or 1
sh=sh or 1
local row=num/8\1
local col=num%8
if row ~=g_loaded_row then
g_loaded_row=row
memcpy(0x0000,0x8000+0x400*row,0x400)
end
local w,h=16*sw,16*sh
sspr(col*16,0,16,16,x-w/2,y-h/2,w,h)
end
function draw_pkmn_out(num,x,y,col,xscale,yscale)
xscale=xscale or 1
yscale=yscale or 1
local outline_width=max(abs(xscale),1)\ 1
for c=1,15 do pal(c,col)end
for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num,x-outline_width,y+i,xscale,yscale)end
for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num,x+outline_width,y+i,xscale,yscale)end
for c=1,15 do pal(c,1)end
for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num,x+i,y,xscale,yscale)end
for i=-outline_width,outline_width,outline_width*2 do draw_pkmn(num,x,y+i,xscale,yscale)end
for c=1,15 do pal(c,c)end
draw_pkmn(num,x,y,xscale,yscale)
end
function format_num(num)
local str=""..num
for i=#str+1,3 do
str="0"..str
end
return "#"..str
end
function get_pokemon(num)
return c_pokemon[num]
end
function get_browse_pokemon(num)
return c_pokemon[g_available_pokemon[num]]or{draw=nop}
end
c_creditlist=split",,,,,,credits,,⬇️/⬆️  ,,,alanxoc3,CODE,GFX|SFX,,the,great,cadet,GFX|SFX,,wadlo,MAGIKARP,GYARADOS,,,,,code,snippets,,,,,zep,FOR PX9,& PICO-8,,mot,FOR SMAP,,,,,pokemon,data,,,,,blbapedia,,pokeapi,,serebii,,smogon,,upokecntr,,volvox,,nintendo,OF COURSE,,,,,gotta,catch,em all,"
c_partyactions=zobj[[;name,pokemon,state,partypkmn,desc,select|the|pokemon,func,%menu_state_callback;;name,moves,state,partymoves,desc,select|the|moves,func,%menu_state_callback;;name,delete,desc,remove|from|party,func,%partydel]]
function get_partyactions()
local party=get_party(@0x5ef4)
if party[@0x5ef3+1]then
return c_partyactions
else
return{c_partyactions[1]}
end
end
function set_default_party_pkmn(party,ind,num)
party[ind]={num=num,moves=c_pokemon[num].get_natural_moveset(100)}
return party
end
function set_party_pkmn_move(party,ind,moveind,move)
local partypkmn=party[ind]
for i=1,4 do
if partypkmn.moves[i]==move then
partypkmn.moves[i]=nil
end
end
partypkmn.moves[moveind]=move
return party
end
function print_draw3_message(top,mid,bot)
rectfill(0,0,45,20,1)
zprint(top,46/2,1,13,0)
zprint(mid,46/2,8,13,0)
zprint(bot,46/2,15,13,0)
end
c_party_memlocs=zobj[[0,0x5e00,1,0x5e1e,2,0x5e3c]]
function get_party(party_index)
local mem=c_party_memlocs[party_index]
local party={}
for i=1,6 do
local memstart=mem+(i-1)*5
local moves={}
local has_moves=false
for i=1,4 do
local move=peek(memstart+i)
if move>0 then
moves[i]=move
has_moves=true
end
end
if has_moves then
party[i]={num=peek(memstart),moves=moves}
end
end
return party
end
function save_party(party_index,party)
local mem=c_party_memlocs[party_index]
memset(mem,0,30)
for i=1,6 do
local memstart=mem+(i-1)*5
local pkmn=party[i]
if pkmn then
poke(memstart,pkmn.num)
for i=1,4 do
poke(memstart+i,pkmn.moves[i])
end
end
end
end
function select_move(pl,slot,switch)
pl.actions={}
local priority_class=1000
if switch then
priority_class=3000
else
local move=pl.active.moveids[slot]or 0
addaction(pl,pl,"#,uses,"..c_moves[move].name,function(s,o)
generic_attack(s,o,slot)
end)
if move==120 then priority_class=2000 end
if move==18 or move==4 or move==89 or move==30 then
priority_class=0000
end
end
pl.priority=min(3000,priority_class+pl.active:getstat"speed")
end
function get_other_pl(game,pl)
return pl==game.p1 and game.p2 or game.p1
end
function draw_hp(x,y,hp,maxhp,status,align,col)
hp=max(ceil(hp),0)
zprint(hp,x+3*max(align,0),y-2+5*align,col,align)
zprint(status or "",x+3*max(align,0),y-2-5*align,col,align)
rectfill(x,y-1,x-align*ceil(hp/maxhp*17),y+1,col)
end
function newaction(pactive,message,logic)
return{pl=pactive,active=pactive.active,message=message,logic=logic or nop}
end
function addaction(p0,...)
add(p0.actions,newaction(...))
end
function logic_faint(s)
s.active.shared.major=1
local na=get_next_active(s.party)
if na then
s.active=party_pkmn_to_active(get_next_active(s.party))
addaction(s,s,"#,comes,out")
end
end
function pop_next_action(game)
for p in all{game.p1,game.p2}do
if p.active.shared.hp<=0 and p.active.shared.major ~=1 then
return newaction(p,"#,is,fainted",logic_faint)
end
end
for s in all{game.p0,get_other_pl(game,game.p0)}do
local o=get_other_pl(game,s)
while #s.actions>0 do
local action=deli(s.actions,1)
if action.active.shared.major ~=1 and(action.active==s.active or action.active==o.active)then
return action
end
end
end
end
function get_possible_move_slots(active)
local possible_moves={}
for i=1,4 do
if active.moveids[i]and active.movepps[i]>0 then
add(possible_moves,i)
end
end
return possible_moves
end
function select_random_move_slot(active)
local possible_moves=get_possible_move_slots(active)
return possible_moves[flr_rnd(#possible_moves)+1]or 0
end
function generic_attack(s,o,m)
local move=c_moves[s.active.moveids[m]or 0]
if move.num!=0 then
s.active.movepps[m]-=1
end
local dmg=move.damage
if dmg>0 then
addaction(s,o,"#,-"..dmg..",hitpoints",function()
o.active.shared.hp=max(0,o.active.shared.hp-dmg)
end)
else
addaction(s,s,"#,does,nothing")
end
end
function get_crit_ratio(base_speed)
return min(.99,(base_speed+76)/1024)
end
function move_accuracy_rate()
return flr_rnd"256"==0 and flr_rnd"256"==0
end
function calc_move_damage(lvl,attack,defence,critical,move_power)
local base_damage=(2*lvl*critical/5+2)*move_power*(attack/defence)/50+2
return base_damage*stab*type1*type2*random
end
c_pselactions=zobj[[;name,fight,desc,select|a|move,func,%menu_state_callback,state,pselmove;;name,switch,desc,change|active|pokemon,func,%menu_state_callback,state,pselswitch;;name,forfeit,desc,leave|the|fight,func,%psel_forfeit]]
function err_beep()sfx"60" end
function calc_max_stat(lvl,base)return ceil(lvl*.01*(base*2+93))+5 end
function calc_max_hp(lvl,base)return calc_max_stat(lvl,base)+5+lvl end
function begin_fight(game,lvl,party1,party2,name1,name2,iscpu1,iscpu2)
local party1,party2=get_fight_party(party1,lvl),get_fight_party(party2,lvl)
game.p1={name=name1,priority=1,iscpu=iscpu1,actions={},active=party_pkmn_to_active(get_next_active(party1)),party=party1,winlogic=nop}
game.p2={name=name2,priority=0,iscpu=iscpu2,actions={},active=party_pkmn_to_active(get_next_active(party2)),party=party2,winlogic=nop}
add(game.p1.actions,newaction(game.p1,"#,comes,out"))
add(game.p2.actions,newaction(game.p2,"#,comes,out"))
game.p0=game.p1
game:push"turn"
end
function get_next_active(party)
for i=1,6 do
if party[i]and party[i].major ~=1 then
return party[i]
end
end
end
function get_fight_party(party,lvl)
local fightparty={}
for i=1,6 do
local cur=party[i]
if cur then
local pkmn=c_pokemon[cur.num]
fightparty[i]={
num=cur.num,
lvl=lvl,
maxhp=calc_max_hp(lvl,pkmn.hp),
attack=calc_max_stat(lvl,pkmn.attack),
defence=calc_max_stat(lvl,pkmn.defence),
speed=calc_max_stat(lvl,pkmn.speed),
special=calc_max_stat(lvl,pkmn.special),
moveids=(function()local m={}for i=1,4 do m[i]=cur.moves[i]end return m end)(),
hp=calc_max_hp(lvl,pkmn.hp),
movepps=(function()local m={}for i=1,4 do m[i]=cur.moves[i]and c_moves[cur.moves[i]].pp end return m end)(),
}
end
end
return fightparty
end
function party_pkmn_to_active(partypkmn)
return{
type1=c_pokemon[partypkmn.num].type1,
type2=c_pokemon[partypkmn.num].type2,
moveids=(function()local m={}for i=1,4 do m[i]=partypkmn.moveids[i]end return m end)(),
movepps=partypkmn.movepps,
stages=zobj[[special,0,defence,0,attack,0,speed,0,accuracy,0,evasion,0]],
getstat=function(a,stat)
local stage=a.stages[stat]
return ceil(mid(1,999,
a.shared[stat]*(
(stat=="evasion"or stat=="accuracy")
and mid(1,1+stage/3,3)/mid(1,1-stage/3,3)
or mid(2,2+stage,8)/mid(2,2-stage,8)
)
))
end,
minor={},
shared=partypkmn,
}
end
g_fade,g_fade_table=1,zobj[[0;,0,0,0,0,0,0,0,0;1;,1,1,1,1,0,0,0,0;2;,2,2,2,1,0,0,0,0;3;,3,3,3,3,1,1,0,0;4;,4,4,2,2,2,1,0,0;5;,5,5,5,1,0,0,0,0;6;,6,6,13,13,5,5,0,0;7;,7,7,6,13,13,5,0,0;8;,8,8,8,2,2,2,0,0;9;,9,9,4,4,4,5,0,0;10;,10,10,9,4,4,5,0,0;11;,11,11,3,3,3,3,0,0;12;,12,12,12,3,1,0,0,0;13;,13,13,5,5,1,0,0,0;14;,14,14,13,4,2,2,0,0;15;,15,15,13,13,5,5,0,0;]]
function fade(threshold)
for c=0,15 do
pal(c,g_fade_table[c][1+flr(7*min(1,max(0,threshold)))],1)
end
end
zclass[[fader,actor|ecs_exclusions;actor,yes,timer,yes;]]
zclass[[fader_out,fader|start;duration,.5,destroyed,@,update,%fader_out_update]]
zclass[[fader_in,fader|start;duration,.5,update,%fader_in_update]]
function extract_sheet(index)
px9_decomp(0,0,peek2(index*2),
function(...)return vget(0x8000+index*0x2000,...)end,
function(...)return vset(0x8000+index*0x2000,...)end)
end
function vget(offset,x,y)
x=min(max(0,x),127)\1
y=y\1
local val=peek(y*64+offset+x\2)
if x%2==1 then return(val & 0xf0)>>>4
else return(val & 0x0f)end
end
function vset(offset,x,y,val)
x=min(max(0,x),127)\1
y=y\1
local mem_coord=y*64+offset+x\2
local oldval=peek(mem_coord)
if x%2==1 then poke(mem_coord,(oldval & 0x0f)|(((val or 0)& 0x0f)<<4))
else poke(mem_coord,(oldval & 0xf0)|(((val or 0)& 0x0f)<<0))
end
end
function px9_decomp(x0,y0,src,vget,vset)
local function vlist_val(l,val)
local v,i=l[1],1
while v!=val do
i+=1
v,l[i]=l[i],v
end
l[1]=val
end
local cache,cache_bits=0,0
function getval(bits)
if cache_bits<8 then
cache_bits+=8
cache+=@src>>cache_bits
src+=1
end
cache<<=bits
local val=cache&0xffff
cache^^=val
cache_bits-=bits
return val
end
function gnp(n)
local bits=0
repeat
bits+=1
local vv=getval(bits)
n+=vv
until vv<(1<<bits)-1
return n
end
local w,h_1,eb,el,pr,x,y,splen,predict=gnp"1",gnp"0",gnp"1",{},{},0,0,0
for i=1,gnp"1" do add(el,getval(eb))end
for y=y0,y0+h_1 do
for x=x0,x0+w-1 do
splen-=1
if(splen<1)then
splen,predict=gnp"1",not predict
end
local a=y>y0 and vget(x,y-1)or 0
local l=pr[a]or{unpack(el)}
pr[a]=l
local v=l[predict and 1 or gnp"2"]
vlist_val(l,v)
vlist_val(el,v)
vset(x,y,v)
end
end
end
zclass[[game_state,actor|curr,fadein;init,%game_state_init;ecs_exclusions;actor,yes;defaults;sinit,nop,update,nop,draw,nop,light,0,backbuttonheld,no,modes,;logo;next,fadein,sinit,%logo_init,update,nop,draw,%logo_draw,duration,2.5;fadein;next,game,duration,0,sinit,%gamefadein_init;closed;next,opening,sinit,%closed_init,update,%closed_update,draw,%closed_draw;opening;next,starting_1,duration,.25,draw,%opening_draw;starting_1;next,starting_2,light,1,duration,.125,sinit,%light_init,draw,%opened_draw;starting_2;next,starting_3,light,2,duration,.125,sinit,%light_init,draw,%opened_draw;starting_3;next,game,light,3,duration,.125,sinit,%light_init,draw,%opened_draw;game;next,closing,light,4,sinit,%game_init,update,%game_update,draw,%game_draw;closing;next,closed,duration,.25,update,nop,draw,%closing_draw;]]
function _init()
memset(0x8000,0,0x7fff)
poke(0x5f5c,15)
poke(0x5f5d,5)
cls()
sfx(62,0)
extract_sheet(0)
extract_sheet(1)
extract_sheet(2)
poke(0x5f56,0xe0)
px9_decomp(0,0,peek2(3*2),mget,mset)
normalize_pokemon_data()
memcpy(0x0000,0xc000,0x2000)
g_tl=_g.game_state()
end
function _update60()
g_bl=btn"0" g_br=btn"1"
g_bu=btn"2" g_bd=btn"3"
g_bo=btn"4" g_bx=btn"5"
g_bpl=btnp"0" g_bpr=btnp"1"
g_bpu=btnp"2" g_bpd=btnp"3"
g_bpo=btnp"4" g_bpx=btnp"5"
g_available_pokemon={}
for i=0,151 do
if@(0x5e5a+i)~=0 then
add(g_available_pokemon,i)
end
end
if@0x5efa==1 then
g_bo,g_bx=g_bx,g_bo
g_bpo,g_bpx=g_bpx,g_bpo
end
zcall(loop_entities,[[1;,actor,clean;2;,fader,clean;]])
register_entities()
zcall(loop_entities,[[1;,fader,tick;2;,game_state,tick;3;,fader,state;4;,game_state,state;]])
end
function _draw()
cls()
loop_entities("game_state","draw")
fade(g_fade)
end
function parse_numlist(str)
local tbl={}
for x in all(split(str or "","|"))do
if type(x)=="number"then
add(tbl,x)
end
end
return tbl
end
function normalize_pokemon_data()
g_all_pokemon_moves={}
for i=0,#c_moves do
local move=c_moves[i]
c_moves[i]={
name=move[1],
type=move[2],
pp=move[3],
damage=move[4],
accuracy=move[5],
ref=(i>=1 and i<=50 and "tm "..i)or(i>=51 and i<=55 and "hm "..(i-50)),
num=i,
}
end
local movemem=peek2(8)
for i=0,151 do
local is_range=false
local moves={}
while@movemem ~=0 do
if@movemem==255 then
is_range=true
elseif is_range then
for i=moves[#moves],@movemem do
add(moves,i)
end
is_range=false
else
add(moves,@movemem)
end
movemem+=1
end
movemem+=1
g_all_pokemon_moves[i]=moves
end
for i=-2,151 do
local pkmn=c_pokemon[i]or{}
local movelvls={}
for i=10,#pkmn do
add(movelvls,pkmn[i])
end
c_pokemon[i]={
evolvesfrom=(pkmn[1]or 0)>0 and i-pkmn[1]or nil,
name=pkmn[2],
type1=pkmn[3],
type2=pkmn[4],
hp=pkmn[5],
attack=pkmn[6],
defence=pkmn[7],
speed=pkmn[8],
special=pkmn[9],
movelvls=movelvls,
moves={},
get_natural_moveset=function(level)
local a,moveset=c_pokemon[i],{}
for i=#a.movelvls,1,-1 do
if a.movelvls[i]<=level and #moveset<4 then
add(moveset,a.moves[i].num)
end
end
return moveset
end,
draw=function(...)draw_pkmn_out(i,...)end,
num=i,
}
end
update_pokemon_moves()
end
function update_pokemon_moves()
for i=0,151 do
local pkmn,moves,movemap=c_pokemon[i],{},{}
function set_move(m,reason)
if not movemap[m]then
movemap[m]=true
local refmove=c_moves[m]
add(moves,{
ref=reason or refmove.ref,
num=m
})
end
end
for i,m in ipairs(g_all_pokemon_moves[i])do
set_move(m,pkmn.movelvls[i]and "lvl "..pkmn.movelvls[i])
end
if i==25 and@0x5efe ~=0 then set_move(53,"special")end
if i==54 and@0x5efd ~=0 then set_move(143,"special")end
pkmn.moves=moves
while pkmn.evolvesfrom do
pkmn=c_pokemon[pkmn.evolvesfrom]
for m in all(pkmn.moves)do
set_move(m.num,"previous")
end
end
end
end