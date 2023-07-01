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
f_zobj_set(_g,"f_zobj,@,f_zobj_set,@,f_zobj_eval,@,f_zclass,@,f_zclass_get_elapsed_percent,@,f_zclass_load,@,f_zclass_loadlogic,@,f_zclass_state,@,f_test_init,@,f_test_update,@,f_test_draw,@,f_game_init,@,f_game_update,@,f_game_draw,@,f_zbtn,@,f_xbtn,@,f_ybtn,@",f_zobj,f_zobj_set,f_zobj_eval,function(template)
return f_zobj_set(f_zobj"timer,0,isnew,~c_yes,init,~f_nop,update,~f_nop,curr,begin;begin;,;",template)
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
printh(curr)
_ENV[curr].done=true
for k,v in pairs(defaults)do _ENV[k]=v end
for k,v in pairs(_ENV[stateName])do _ENV[k]=v end
curr=stateName
printh(init)
_ENV:init()
end,function(_ENV)
timer+=1/60
if isnew then _ENV:f_zclass_loadlogic(curr)end
if duration and timer>=duration then _ENV:f_zclass_load()end
while next_state do _ENV:f_zclass_loadlogic(next_state)end
_ENV:update()
end,function(_ENV)col+=1 end,function(_ENV)x+=f_xbtn()y+=f_ybtn()end,function(_ENV)circfill(x,y,2,col)end,function(_ENV)
ball=f_zclass"x,64,y,64,col,7,init,~f_test_init,update,~f_test_update,draw,~f_test_draw;"
end,function(_ENV)
ball:f_zclass_state()
end,function(_ENV)
cls()
rect(0,0,127,127,8)
ball:draw()
end,function(f,a)return f(a)and f(a+1)and 0 or f(a)and-1 or f(a+1)and 1 or 0 end,function()return f_zbtn(btn,0)end,function()return f_zbtn(btn,2)end)
function _init()
g_tl=f_zclass"begin;init,~f_game_init,update,~f_game_update,draw,~f_game_draw;"
end
function _update60()
g_tl:f_zclass_state()
end
function _draw()
g_tl:draw()
end