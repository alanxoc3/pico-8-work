c_creditlist = split",,,,,,credits,,⬆️/⬇️  ,,,aLANXOC3,CODE,GFX|SFX,,tHE,gREAT,cADET,GFX|SFX,,wADLO,MAGIKARP,GYARADOS,,code,snippets,,zEP,fOR pX9,& pICO-8,,mOT,fOR sMAP,,pokemon,data,,bLBAPEDIA,,pOKEAPI,,sEREBII,,sMOGON,,vOLVOX,,nINTENDO,oF cOURSE,,,,gotta,catch,em,all,,,"

|[credits_init]| function(a)
    g_credits_offset = 5
end $$

|[credits_update]| function(a)
    if g_bpo then a:pop() end
    if g_bu then g_credits_offset-=1/6 end
    if g_bd then g_credits_offset+=1/6 end
    g_credits_offset = g_credits_offset%#c_creditlist
end $$

|[credits_draw1]| function(a)
    rectfill(0,0,39,39,1)
    for i,txt in ipairs(c_creditlist) do
        zprint(txt, 20, (i-g_credits_offset)*6, 13, 0)
    end
end $$
