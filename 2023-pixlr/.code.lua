_g=setmetatable({},{__index=_ENV})
_ENV=_g
function f_zobj_eval(val,table,parameters)
if ord(val)==126 then return table[sub(val,2)]
elseif val=="@" then return deli(parameters,1)
elseif val=="#" then return{}end
return val ~="" and val or nil
end
function f_zobj_set(table,str,...)
local params,statements,dest={...},split(str,";"),table
foreach(statements,function(statement)
local tokens=split(statement)
if #tokens>1 then
if tokens[1]=="" then
foreach(tokens,function(val)
add(dest,f_zobj_eval(val,table,params))
end)
else
for i=1,#tokens,2 do
dest[tokens[i]]=f_zobj_eval(tokens[i+1],table,params)
end
end
dest=table
else
if statement=="" then statement=#dest+1 end
if type(dest[statement])~="table"then
dest[statement]={}
end
dest=dest[statement]
end
end)
return table
end
function f_zobj(...)
return f_zobj_set(setmetatable({},{__index=_g}),...)
end
f_zobj_set(_g,"c_yes,@,c_no,@,c_empty,@,f_nop,@",true,false,"",function(...)return...end)
f_zobj_set(_g,"f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zclass,@,f_zclass_register,@,f_zclass_kill,@,f_zclass_loop,@,f_zclass_clean,@,f_zclass_get_elapsed_percent,@,f_zclass_load,@,f_zclass_loadlogic,@,f_zclass_state,@,f_get_at_coord,@,f_draw_pixelgroup,@,f_pixelgroup_set_pixel,@,f_pixelgroup_get_pixel,@,f_pixelgroup_push,@,f_pixelgroup_combine_moved,@,f_pixelgroup_check,@,f_pixelgroup_combine,@,f_create_pixelgroup,@,f_pixelgroup_set_dir_arrs,@,f_pixelgroup_get_dir_array,@,f_pixelgroup_move,@,f_initialize_groups,@,G_STR_MOVABLEWALL,@,G_STR_WALL,@,G_STR_BOMB,@,G_STR_LAVA,@,G_STR_PL,@,f_ball_update,@,f_ball_update_x,@,f_ball_update_y,@,f_game_init,@,f_game_update,@,f_game_draw,@,f_zbtn,@,f_xbtn,@,f_ybtn,@",f_zobj,f_zobj_set,f_zobj_eval,function(...)
return f_zobj_set(f_zobj(G_ZCLASS_TEMPLATE),...)
end,function(_ENV)
del(_g.g_zclass,_ENV)
add(_g.g_zclass,_ENV)
end,function(_ENV)
_ENV.alive=false
end,function(funcName)
for obj in all(_g.g_zclass)do
(obj[funcName]or function()end)(obj)
end
end,function()
for obj in all(_g.g_zclass)do
if not obj.alive then
del(_g.g_zclass,obj)
end
end
end,function(_ENV,key)
if key==curr then
return duration and timer/duration or 0
end
if _ENV[key]and _ENV[key].done then
return 1
end
return 0
end,function(_ENV,stateName)
next_state=stateName or next
end,function(_ENV,stateName)
timer,next_state,isnew,next,duration=0
_ENV[curr].done=true
for k,v in pairs(defaults)do _ENV[k]=v end
for k,v in pairs(_ENV[stateName])do _ENV[k]=v end
curr=stateName
_ENV:init()
end,function(_ENV)
timer+=1/_g.G_FPS
if isnew then _ENV:f_zclass_loadlogic(curr)end
if duration and timer>=duration then _ENV:f_zclass_load()end
while next_state do _ENV:f_zclass_loadlogic(next_state)end
_ENV:update()
end,function(x,y)
for obj in all(g_zclass)do
if obj.alive and obj:get(x,y)then
return obj
end
end
end,function(_ENV)
for coord in all(array)do
pset((coord[1]+x)%32\1,(coord[2]+y)%32\1,col)
end
end,function(_ENV,sx,sy)
local rx,ry=(sx-x)%32,(sy-y)%32
if not grid[ry]then grid[ry]={}end
if not grid[ry][rx]then
local coord={rx,ry}
grid[ry][rx]=coord
add(array,coord)
end
end,function(_ENV,sx,sy)
return _ENV.grid[(sy-y)%32]and _ENV.grid[(sy-y)%32][(sx-x)%32]
end,function(_ENV,xoff,yoff,blockids,pushmap,objs)
local is_root=not objs
objs=objs or{[_ENV]=true}
local start=#objs+1
for coord in all(_ENV:f_pixelgroup_get_dir_array(xoff,yoff))do
local obj=f_get_at_coord((x+coord[1]+xoff)%32,(y+coord[2]+yoff)%32)
if obj and not objs[obj]then
if blockids[obj.id]then
return false
elseif pushmap[obj.id]then
if obj.id==_ENV.id and _ENV.alive and obj.alive then
_ENV:combine(obj)
end
objs[obj.id]=true
objs[obj]=true
add(objs,obj)
end
end
end
for i=start,#objs do
if not objs[i]:push(xoff,yoff,blockids,pushmap,objs)then
return false
end
end
if is_root then
for thing in all(objs)do
thing:move(xoff,yoff)
end
_ENV:move(xoff,yoff)
end
return true
end,function(_ENV)
local xoff,yoff=0,1
if(moved_x or moved_y)and alive then
local x_new,y_new=xoff,yoff
for _=0,3 do
x_new,y_new=-y_new,x_new
for coord in all(_ENV:f_pixelgroup_get_dir_array(x_new,y_new))do
local obj=f_get_at_coord((x+coord[1]+x_new)%32,(y+coord[2]+y_new)%32)
if obj and obj ~=_ENV and obj.alive and obj.id==id then
_ENV:combine(obj)
end
end
end
end
end,function(_ENV,xoff,yoff,solidmap)
for coord in all(_ENV:f_pixelgroup_get_dir_array(xoff,yoff))do
local obj=f_get_at_coord((x+coord[1]+xoff)%32,(y+coord[2]+yoff)%32)
if obj and solidmap[obj.id]then
return true
end
end
return false
end,function(_ENV,other)
for coord in all(other.array)do
local sx,sy=(other.x+coord[1])%32,(other.y+coord[2])%32
if not _ENV:get(sx,sy)then
_ENV:set(sx,sy)
end
end
_ENV:f_pixelgroup_set_dir_arrs()
other.alive=false
end,function(start_x,start_y)
local col=sget(start_x,start_y)
if col==0 then return nil end
local queue={{0,0}}
local group=f_zclass("id,default,draw,~f_draw_pixelgroup,set,~f_pixelgroup_set_pixel,get,~f_pixelgroup_get_pixel,combine,~f_pixelgroup_combine,check,~f_pixelgroup_check,move,~f_pixelgroup_move,push,~f_pixelgroup_push,x,@,y,@,col,@,grid,#,array,#,array_l,#,array_r,#,array_u,#,array_d,#",start_x,start_y,col)
while #queue>0 do
local lx,ly=unpack(deli(queue))
local gx,gy=lx%32,ly%32
local sx,sy=(gx+start_x)%32,(gy+start_y)%32
if sget(sx,sy)==col and not(group.grid[gy]and group.grid[gy][gx])then
if not group.grid[gy]then group.grid[gy]={}end
local coord={gx,gy}
group.grid[gy][gx]=coord
add(group.array,coord)
add(queue,{lx-1,ly})add(queue,{lx,ly-1})
add(queue,{lx+1,ly})add(queue,{lx,ly+1})
end
end
group:f_pixelgroup_set_dir_arrs()
return group
end,function(_ENV)
array_l,array_d,array_r,array_u={},{},{},{}
for coord in all(array)do
local gx,gy=unpack(coord)
if not grid[(gy-1)%32]or not grid[(gy-1)%32][gx]then add(array_u,coord)end
if not grid[(gy+1)%32]or not grid[(gy+1)%32][gx]then add(array_d,coord)end
if not grid[gy][(gx+1)%32]then add(array_r,coord)end
if not grid[gy][(gx-1)%32]then add(array_l,coord)end
end
end,function(_ENV,xoff,yoff)
if xoff<0 then return array_l
elseif xoff>0 then return array_r
elseif yoff<0 then return array_u
else return array_d end
end,function(_ENV,xdir,ydir)
x=(x+mid(-1,1,xdir))%32
y=(y+mid(-1,1,ydir))%32
if xdir~=0 then
moved_x=true
end
if ydir~=0 then
moved_y=true
end
end,function()
local grid,groups={},{}
for y=0,31 do
for x=0,31 do
if not grid[x+y*32]then
local group=f_create_pixelgroup(x,y)
if group then
for coord in all(group.array)do
grid[(x+coord[1])%32+(y+coord[2])%32*32]=true
end
add(groups,group)
end
end
end
end
return groups
end,"id,movablewall;","id,wall;","id,bomb;","id,lava;","id,pl,xstore,0,ystore,0,jumpstore,0,jump,#,coyote,~c_no,update,~f_ball_update,x_prev_dir,0,x_prev_len,0,update_x,~f_ball_update_x,update_y,~f_ball_update_y;",function(_ENV)
xstore+=f_xbtn()
ystore+=f_ybtn()
if btn"4" then
jumpstore=1
end
end,function(_ENV)
local nx=mid(-1,1,xstore)
if not moved_x and nx ~=0 then
if x_prev_dir ~=nx and x_prev_dir ~=0 then
x_prev_len=0
else
x_prev_len=min(3,x_prev_len+1)
end
if x_prev_len==1 or x_prev_len==3 then
_ENV:push(nx,0,{wall=true},{movablewall=true,pl=true})
end
x_prev_dir=nx
else
x_prev_len=0
x_prev_dir=0
end
xstore=0
end,function(_ENV)
local ny=mid(-1,1,ystore)
if #jump==0 and jumpstore>0 and(coyote and coyote>0 or _ENV:check(0,1,{wall=true,movablewall=true}))then
add(jump,false)add(jump,false)add(jump,true)
add(jump,false)add(jump,true)add(jump,true)
coyote=0
end
if #jump>0 and jumpstore>0 then
if deli(jump)then
if not moved_y and not _ENV:push(0,-1,{wall=true},{movablewall=true,pl=true})then
jump={}
end
end
elseif not _ENV:check(0,1,{wall=true,movablewall=true,pl=true})then
if #jump>0 then
deli(jump)deli(jump)
elseif not coyote then
coyote=1
else
_ENV:push(0,1,{wall=true},{movablewall=true,pl=true})
coyote=0
end
else
jump={}
coyote=false
end
jumpstore=0
end,function(_ENV)
xytoggle=0
local groups=f_initialize_groups()
for group in all(groups)do
if group.col==6 then f_zobj_set(group,G_STR_MOVABLEWALL)group:register()
elseif group.col==7 then f_zobj_set(group,G_STR_WALL)group:register()
elseif group.col==8 then f_zobj_set(group,G_STR_BOMB)group:register()
elseif group.col==9 then f_zobj_set(group,G_STR_LAVA)group:register()
elseif group.col==12 then f_zobj_set(group,G_STR_PL)group:register()
end
end
end,function(_ENV)
if btnp"5" then
f_zclass_loop"kill"
f_zclass_clean()
reload(0x0,0x0,0x2000)
_ENV:f_game_init()
end
f_zclass_loop"state"
xytoggle=(xytoggle+1)%2
if xytoggle==0 then
f_zclass_loop"update_x"
f_zclass_loop"update_y"
end
f_zclass_loop"f_pixelgroup_combine_moved"
for obj in all(g_zclass)do
obj.moved_x=false
obj.moved_y=false
end
f_zclass_clean()
end,function(_ENV)
poke(0x5f55,0x00)clip(0,0,32,32)cls(0)
rect(0,0,31,31,1)
f_zclass_loop"draw"
clip()poke(0x5f55,0x60)
sspr(0,0,32,32,0,0,64,64)
end,function(f,a)return f(a)and f(a+1)and 0 or f(a)and-1 or f(a+1)and 1 or 0 end,function()return f_zbtn(btn,0)end,function()return f_zbtn(btn,2)end)
g_zclass={}
G_ZCLASS_TEMPLATE="timer,0,state,~f_zclass_state,load,~f_zclass_load,elapsed,~f_zclass_get_elapsed_percent,register,~f_zclass_register,kill,~f_zclass_kill,alive,~c_yes,isnew,~c_yes,init,~f_nop,update,~f_nop,curr,begin;begin;,;"
function _init()
g_tl=f_zclass"level,1;begin;init,~f_game_init,update,~f_game_update,draw,~f_game_draw;"
palt(0,false)
poke(0x5f2c,3)
end
G_FPS=30
function _update()
g_tl:f_zclass_state()
end
function _draw()
g_tl:draw()
end