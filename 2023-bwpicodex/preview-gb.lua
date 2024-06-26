cls()
poke(0x5f2c, 3) -- enable 64x64
poke(0x5f5c, 8) -- btn initial delay
poke(0x5f5d, 1) -- btn repeat delay

-- menus: browse,edit,league,versus
-- credits can be shown automatically

--num=0, --view=0,
function create_grid(memloc, grid_w, grid_len, cw, ch, x, y, sel_bg, bg, view_h, draw_func, disablesel)
  return {
    numloc=memloc,
    viewloc=memloc+1,
    w=grid_w,
    len=grid_len,
    cw=cw, ch=ch,
    x=x, y=y,
    selbg=sel_bg, bg=bg,
    vh=view_h,
    df=draw_func,
    disablesel=disablesel,
  }
end

function update_grid(grid)
  local h = @grid.numloc\grid.w*grid.w

  if btnp'0' then poke(grid.numloc, max(h, @grid.numloc-1)) end
  if btnp'1' then poke(grid.numloc, min(h+grid.w-1, @grid.numloc+1)) end
  if btnp'2' then poke(grid.numloc, max(@grid.numloc%grid.w, @grid.numloc-grid.w)) end
  if btnp'3' then poke(grid.numloc, min(grid.len-grid.w+@grid.numloc%grid.w, @grid.numloc+grid.w)) end -- TODO: there is a bug when there is only one cell at the bottom and you go down.

  if @grid.numloc >= grid.len then poke(grid.numloc, grid.len-1) end

  if @grid.numloc\grid.w-grid.vh+1 > @grid.viewloc then poke(grid.viewloc, (@grid.viewloc+1)%((grid.len-grid.vh+1)\grid.w)) end
  if @grid.numloc\grid.w           < @grid.viewloc then poke(grid.viewloc, (@grid.viewloc-1)%((grid.len-grid.vh+1)\grid.w)) end
end

function draw_grid(grid)
  for j=0,grid.vh*grid.w-1 do
    local i = j + @grid.viewloc*grid.w
    if i >= grid.len then return end
    local xloc, yloc = grid.x+i%grid.w*grid.cw, grid.y+j\grid.w*grid.ch
    camera(-xloc-1, -yloc-1)

    local l, r, u, d = 0, 0, 0, 0

    if i == 0                          then l = 1 u = 1 end
    if i == grid.w-1                   then r = 1 u = 1 end
    if i == grid.len-1                 then r = 1 d = 1 end
    if i == (grid.len-1)\grid.w*grid.w then l = 1 d = 1 end

    rectfill(-1+l, -1,   grid.cw-2-r, grid.ch-2,   i == @grid.numloc and not grid.disablesel and grid.selbg or grid.bg)
    rectfill(-1,   -1+u, grid.cw-2,   grid.ch-2-d, i == @grid.numloc and not grid.disablesel and grid.selbg or grid.bg)

    clip(xloc, yloc, grid.cw, grid.ch) -- camera goes in one, but clip doesn't. dont want to go in for the title screen animation
    grid.df(i, i == @grid.numloc)
    camera()
    clip()
  end
end

function minisfx(num) -- plays a sfx with len of 4
  -- d7040000 this is the sfx prefix to:
  -- - set dampen/reverb/buzz/noise to max
  -- - get rid of loops
  -- - set speed to 4
  sfx(num\4, 0, num%4*8, 8)
end

pkmn_names = split"mISSING,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANF,nIDRINA,nIDQUEN,nIDRANM,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCH,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRMIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOOH,cELEBI"
pkmn_types = {{"bIRD","nORMAL"}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"fIRE",""}, {"fIRE",""}, {"fIRE","fLYING"}, {"wATER",""}, {"wATER",""}, {"wATER",""}, {"bUG",""}, {"bUG",""}, {"bUG","fLYING"}, {"bUG","pOISON"}, {"bUG","pOISON"}, {"bUG","pOISON"}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"nORMAL",""}, {"nORMAL",""}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"pOISON",""}, {"pOISON",""}, {"eLECTR",""}, {"eLECTR",""}, {"gROUND",""}, {"gROUND",""}, {"pOISON",""}, {"pOISON",""}, {"pOISON","gROUND"}, {"pOISON",""}, {"pOISON",""}, {"pOISON","gROUND"}, {"nORMAL",""}, {"nORMAL",""}, {"fIRE",""}, {"fIRE",""}, {"nORMAL",""}, {"nORMAL",""}, {"pOISON","fLYING"}, {"pOISON","fLYING"}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"bUG","gRASS"}, {"bUG","gRASS"}, {"pOISON","bUG"}, {"pOISON","bUG"}, {"gROUND",""}, {"gROUND",""}, {"nORMAL",""}, {"nORMAL",""}, {"wATER",""}, {"wATER",""}, {"fIGHTG",""}, {"fIGHTG",""}, {"fIRE",""}, {"fIRE",""}, {"wATER",""}, {"wATER",""}, {"wATER","fIGHTG"}, {"pSYCIC",""}, {"pSYCIC",""}, {"pSYCIC",""}, {"fIGHTG",""}, {"fIGHTG",""}, {"fIGHTG",""}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"wATER","pOISON"}, {"wATER","pOISON"}, {"rOCK","gROUND"}, {"rOCK","gROUND"}, {"rOCK","gROUND"}, {"fIRE",""}, {"fIRE",""}, {"pSYCIC","wATER"}, {"pSYCIC","wATER"}, {"sTEEL","eLECTR"}, {"sTEEL","eLECTR"}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"wATER",""}, {"wATER","iCE"}, {"pOISON",""}, {"pOISON",""}, {"wATER",""}, {"wATER","iCE"}, {"gHOST","pOISON"}, {"gHOST","pOISON"}, {"gHOST","pOISON"}, {"rOCK","gROUND"}, {"pSYCIC",""}, {"pSYCIC",""}, {"wATER",""}, {"wATER",""}, {"eLECTR",""}, {"eLECTR",""}, {"gRASS","pSYCIC"}, {"gRASS","pSYCIC"}, {"gROUND",""}, {"gROUND",""}, {"fIGHTG",""}, {"fIGHTG",""}, {"nORMAL",""}, {"pOISON",""}, {"pOISON",""}, {"gROUND","rOCK"}, {"gROUND","rOCK"}, {"nORMAL",""}, {"gRASS",""}, {"nORMAL",""}, {"wATER",""}, {"wATER",""}, {"wATER",""}, {"wATER",""}, {"wATER",""}, {"wATER","pSYCIC"}, {"pSYCIC",""}, {"bUG","fLYING"}, {"pSYCIC","iCE"}, {"eLECTR",""}, {"fIRE",""}, {"bUG",""}, {"nORMAL",""}, {"wATER",""}, {"wATER","fLYING"}, {"wATER","iCE"}, {"nORMAL",""}, {"nORMAL",""}, {"wATER",""}, {"eLECTR",""}, {"fIRE",""}, {"nORMAL",""}, {"rOCK","wATER"}, {"rOCK","wATER"}, {"rOCK","wATER"}, {"rOCK","wATER"}, {"rOCK","fLYING"}, {"nORMAL",""}, {"iCE","fLYING"}, {"eLECTR","fLYING"}, {"fIRE","fLYING"}, {"dRAGON",""}, {"dRAGON",""}, {"dRAGON","fLYING"}, {"pSYCIC",""}, {"pSYCIC",""}, {"gRASS",""}, {"gRASS",""}, {"gRASS",""}, {"fIRE",""}, {"fIRE",""}, {"fIRE",""}, {"wATER",""}, {"wATER",""}, {"wATER",""}, {"nORMAL",""}, {"nORMAL",""}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"bUG","fLYING"}, {"bUG","fLYING"}, {"bUG","pOISON"}, {"bUG","pOISON"}, {"pOISON","fLYING"}, {"eLECTR","wATER"}, {"eLECTR","wATER"}, {"eLECTR",""}, {"nORMAL",""}, {"nORMAL",""}, {"nORMAL",""}, {"nORMAL","fLYING"}, {"pSYCIC","fLYING"}, {"pSYCIC","fLYING"}, {"eLECTR",""}, {"eLECTR",""}, {"eLECTR",""}, {"gRASS",""}, {"wATER",""}, {"wATER",""}, {"rOCK",""}, {"wATER",""}, {"gRASS","fLYING"}, {"gRASS","fLYING"}, {"gRASS","fLYING"}, {"nORMAL",""}, {"gRASS",""}, {"gRASS",""}, {"bUG","fLYING"}, {"wATER","gROUND"}, {"wATER","gROUND"}, {"pSYCIC",""}, {"dARK",""}, {"dARK","fLYING"}, {"pSYCIC","wATER"}, {"gHOST",""}, {"pSYCIC",""}, {"pSYCIC",""}, {"pSYCIC","nORMAL"}, {"bUG",""}, {"bUG","sTEEL"}, {"nORMAL",""}, {"gROUND","fLYING"}, {"sTEEL","gROUND"}, {"nORMAL",""}, {"nORMAL",""}, {"wATER","pOISON"}, {"sTEEL","bUG"}, {"bUG","rOCK"}, {"bUG","fIGHTG"}, {"dARK","iCE"}, {"nORMAL",""}, {"nORMAL",""}, {"fIRE",""}, {"fIRE","rOCK"}, {"gROUND","iCE"}, {"gROUND","iCE"}, {"rOCK","wATER"}, {"wATER",""}, {"wATER",""}, {"fLYING","iCE"}, {"wATER","fLYING"}, {"sTEEL","fLYING"}, {"dARK","fIRE"}, {"dARK","fIRE"}, {"wATER","dRAGON"}, {"gROUND",""}, {"gROUND",""}, {"nORMAL",""}, {"nORMAL",""}, {"nORMAL",""}, {"fIGHTG",""}, {"fIGHTG",""}, {"pSYCIC","iCE"}, {"eLECTR",""}, {"fIRE",""}, {"nORMAL",""}, {"nORMAL",""}, {"eLECTR",""}, {"fIRE",""}, {"wATER",""}, {"rOCK","gROUND"}, {"rOCK","gROUND"}, {"dARK","rOCK"}, {"pSYCIC","fLYING"}, {"fIRE","fLYING"}, {"gRASS","pSYCIC"}}

function draw_pkmn(num, x, y, out_c, in_c, flip)
  local row = num/8\1
  local col = num%8

  local masks = {8, 4, 2, 1}
  local colordrawfunc = function(ix, iy, c)
    local mask = masks[num\64+1]
    for i=1,15 do
      if i & mask == 0 then
        palt(i, true)
      else
        pal(i, c)
      end
    end
    palt(mask, false)
    pal(mask, c)

    spr(num%64\8*16+num%64*2, ix-8, iy-8, 2, 2, flip, false)

    palt()
    pal()
  end

  for yy=-1,1 do
    for xx=-1,1 do
      if not (xx == 0 and yy == 0) then
        colordrawfunc(x+xx, y+yy, out_c)
      end
    end
  end

  colordrawfunc(x, y, in_c) -- sprite
end

g_maxnum = 252

function _init()
  reload(0x0000, 0x0000, 0x4300, "./game.p8") -- for sfx

  -- sfx starts at 0x3200. each sfx are 68 bytes. 64 for notes then 4 for effects.
  -- 0x4278 = 0x3200+62*68 (0 to 62, only modify 63/64 sfx, because 63*4 = 252, which is how many pkmn there are)
  for iloc=0x3200, 0x4278, 68 do
    for loc=iloc, iloc+63, 2 do
      -- breaking apart the bits:
      -- & 0b0111000011011111 (0x70df)
      --   0: disable custom waves
      --   111: keep the note effects
      --   000: dont keeep the volume
      --   011: only allow triangle, tilted saw, saw, and square waves. tilted saw usually gives the "meat" of the cry.
      --   011111: note pitch, but remove the top bit so we don't have tons of super high pitched noises (lots of 255 and 254)
      -- | 0b0000100000000000 (0x0800): set the volume to 4 for everything

      poke2(loc, %loc & 0x70df | 0x0800)
    end

    -- breaking apart the bits:
    -- 0x00: zero out the beg loop
    -- 0x00: zero out the end loop
    -- 0x07: set speed to 7
    -- 0xd7: somehow sets noiz, buzz, detune, reverb, dampen all to max
    poke4(iloc+64, 0x.07d7)
  end

  g_browse  = create_grid(0x5e00, 3, 252, 20, 20, 2, 2, C_3, C_2, 2, function(i, is_sel)
    draw_pkmn(i, 9, 9, is_sel and C_2 or C_1, is_sel and C_4 or C_3)
  end)

  g_titleanim = create_grid(0x5e02, 1, 1, 60, 40, 2, 2, C_2, C_2, 1, function(i, is_sel)
    f_zprint("\^w\^tpicodex", 2, 1,  C_1, -1)
    f_zprint("dUAL vERSION",  2, 12, C_1, -1)

    draw_pkmn(254, 19, 28, C_0, C_3)
    draw_pkmn(g_pkmn, 43+g_pkmn_x+g_pkmn_off, 28, C_0, C_4)
  end)

  create_battle_grid = function(pkmn1, pkmn2)
    return create_grid(0x5e04, 1, 1, 60, 40, 2, 2, C_3, C_2, 2, function(i, is_sel)
      is_sel = false
      local b = function(name, gender, status, item, x, y, bx, by, hp, hpmax)
        roundrect_r(bx-1, by+1, bx+35, by+6, (is_sel and C_2 or C_1))
        if hp > 0 then
          rectfill(bx, by+2, bx+mid(1, hp/hpmax*34, 34), by+5, is_sel and C_4 or C_3)
          pset(bx,    by+2, (is_sel and C_2 or C_1))
          pset(bx+34, by+2, (is_sel and C_2 or C_1))
          pset(bx,    by+5, (is_sel and C_2 or C_1))
          pset(bx+34, by+5, (is_sel and C_2 or C_1))
        end

        local tx, ty = x+15, y+9
        for i=0,5 do
          if i ~= 1 then
            pset(tx+i%3*2, ty+i%2*2, i == 5 and (is_sel and C_4 or C_3) or (is_sel and C_2 or C_1))
          end
        end
        -- end hp bar section

        f_zprint(name,   x+0,  y-5, is_sel and C_2 or C_1, -1)
        f_zprint(status, x+0,  y+8, is_sel and C_2 or C_1, -1)
        f_zprint(item,   x+37, y+8, is_sel and C_2 or C_1, 1)
        f_zprint(gender, x+37, y-5, is_sel and C_2 or C_1, 1)
      end

      draw_pkmn(pkmn1, 49, 9,   is_sel and C_2 or C_1, is_sel and C_4 or C_3, true)  b(pkmn_names[pkmn1+1],"M","bRN","___",1, 5,1, 5,  50+(sin(t())+1)*30, 100)
      draw_pkmn(pkmn2, 9, 9+20, is_sel and C_2 or C_1, is_sel and C_4 or C_3, false) b(pkmn_names[pkmn2+1],"M","___","pSb",   22,5+20,22,5+20, -10+(cos(t())+1)*80, 80)
    end, true)
  end

  g_battleanim = create_battle_grid(5, rnd'19'\1)

  local bb = split"fIGHT,pARTY,aUTO,fORFEIT"
  g_fight_text = create_grid(0x5e06, 2, 4, 30, 9, 2, 44, C_3, C_2, 2, function(i, is_sel)
    print(bb[i+1], i%2, 1, is_sel and C_4 or C_1)
  end)

  local aa = split"bROWSE,eDIT,lEAGUE,vERSUS"
  g_title_text = create_grid(0x5e06, 2, 4, 30, 9, 2, 44, C_3, C_2, 2, function(i, is_sel)
    print(aa[i+1], i%2, 1, is_sel and C_4 or C_1)
  end)

  g_trainers = split"pLAYR1,pLAYR2,yOUNGS,sAGE,fALKNR,gRUNT,bUGCTR,bUGSY,pKMFAN,bEAUTY,wITNEY,kIMINO,mEDIUM,mORTY,pOLICE,kARATE,cHUCK,gENTLE,sAILOR,jASMIN,rOCKET,sKIER,pRYCE,sCIENT,tWINS,cLAIR,nERD,cAMPER,bROCK,sCHOOL,sWIMER,mISTY,jUGLER,gUITAR,lTSURG,hIKER,lASS,eRIKA,bIKER,pICNIK,jANINE,mANIAC,pSYCIC,sABRIN,fISHER,bREATH,bLAINE,bIRDKP,cOOLTR,bLUE,sILVER,wILL,kOGA,bRUNO,kAREN,lANCE,eUSINE,lAWREN,rED"

  g_display_text = create_grid(0x5e06, 1, 1, 60, 16, 2, 45, C_2, C_2, 1, function(i, is_sel)
    print("\f0"..g_trainers[t()\1%#g_trainers+1].." \f3".."cHARMEL", 0, 1, C_1)
    print("\f0USES \f2fLAMTHR",            0, 8, C_1)
  end)

  g_browse_text = create_grid(0x5e06, 1, 1, 60, 16, 2, 45, C_2, C_2, 1, function(i, is_sel)
    local numstr = tostr(@g_browse.numloc)
    while #numstr < 3 do numstr = "0"..numstr end

    print("\f2"..numstr.." \f3"..pkmn_names[@g_browse.numloc+1], 0, 1, C_1)
    print("\f0"..pkmn_types[@g_browse.numloc+1][1].." \f0"..pkmn_types[@g_browse.numloc+1][2],            0, 8, C_1)
  end)

  local tt   = split"tAKDOWN,tACKLE,fIRSPIN,rAPSPIN,sPIKES,rAINDNC,sUNYDAY,lEER,sTRSHOT"
  local ttyp = split"nORMAL,nORMAL,fIRE,nORMAL,gROUND,wATER,fIRE,nORMAL,bUG"
  g_movelist = create_grid(0x5e08, 2, #tt, 30, 9, 2, 4, C_3, C_2, 4, function(i, is_sel)
    f_zprint(tt[i+1], i%2, 1, is_sel and C_4 or C_1, -1)
  end)

  g_move_text = create_grid(0x5e06, 1, 1, 60, 16, 2, 45, C_2, C_2, 1, function(i, is_sel)
    local move_name = tt[@g_movelist.numloc+1]

    print("\f3"..move_name.."\f0 "..ttyp[@g_movelist.numloc+1], 0, 1, C_1)
    print("\f020PP \f0100A 100S",            0, 8, C_1)
  end)
  -- so do i need 2 grids for every view?
  -- well, there are less than that. big view has: title, party select, pkmn select, move select, battle, trainer select.
  -- there is enough diversity i guess.

  g_list = {
    g_titleanim,
    g_browse,
    g_battleanim,
    g_battleanim,
    g_movelist,
  }

  g_list_text = {
    g_title_text,
    g_browse_text,
    g_fight_text,
    g_display_text,
    g_move_text,
  }
end

cur_list_ind = 0x5eff
C_0=0 C_1=0 C_2=1
C_3=2 C_4=3

cols_loc = 0x5efe
mock_ind = -1
g_off = 0
g_scale = 1
view_y = 0
g_num  = 0
g_active = false
g_hpmod = 0
g_pkmn = 0
g_pkmn_x = 0
pkmn_cycle = 0
pkmn_name = "missing"
function _update60()
  pkmn_cycle = t()\1%252
  pkmn_name = pkmn_names[pkmn_cycle+1]

  cols = {
    {[0]=1,       13,     6,      7,    }, -- default
    {[0]=128+4,   4,      128+15, 15    }, -- sand
    {[0]=128+3,   3,      128+11, 128+10}, -- green
    {[0]=128+2,   2,      128+8,  8     }, -- red
    {[0]=128+1,   1,      128+12, 12    }, -- blue
    {[0]=128+5,   128+13, 13,     14,   }, -- pink
    {[0]=0,       5,      6,      7,    }, -- black & white
    {[0]=128+0,   5,      128+6,  128+7 }, -- dark-yel
  }

  g_pkmn_off = 0
  local cycle = 3.5
  if t()%cycle < 2 then
    if t()%cycle < 1 then
      g_pkmn_x += 1
    else
      if t()%cycle == 1 then
        g_pkmn = rnd'19'\1
      end
      g_pkmn_x -= 1
    end
  elseif t()%cycle >= 2.25 and t()%cycle < 2.5 then
    g_pkmn_off = (rnd(3)-1)\1
    if t()%cycle == 2.25 then
      minisfx(g_pkmn)
    end
  end

  local top = (g_maxnum-1)\3 -- 253, includes substitute/empty/?

  if btnp(0) then g_hpmod -= 1 end
  if btnp(1) then g_hpmod += 1 end
  if btnp(2) then g_active = not g_active end
  if btnp(3) then g_active = not g_active end
  if btnp(4) then minisfx(@g_browse.numloc) poke(cols_loc, (@cols_loc+1)%#cols) end
  if btnp(5) then poke(cur_list_ind, (@cur_list_ind + 1) % #g_list) end

  update_grid(g_list[@cur_list_ind%#g_list+1])
  update_grid(g_list_text[@cur_list_ind%#g_list_text+1])
end

scannum = 0
scannum2 = 0

function f_zprint(text, x, y, color, align, control)
    text = ""..text
    if align == 0    then x -= #text*2
    elseif align > 0 then x -= #text*4+1 end

    print((control or "")..text, x, y, color)
end

function roundrect(x, y, rx, ry, c)
  rectfill(x-rx+1, y-ry, x+rx-1-1, y+ry-1, c)
  rectfill(x-rx, y-ry+1, x+rx-1, y+ry-1-1, c)
end

function roundrect_r(x1, y1, x2, y2, c)
  rectfill(x1, y1+1, x2, y2-1, c)
  if x2-x1 > 2 then -- if check is for the hp bar, so it looks good when small.
    rectfill(x1+1, y1, x2-1, y2, c)
  end
end

function _draw()
  memset(0x5f70, 0, 16) -- enable secondary pallette for all lines

  cls(C_0)

  draw_grid(g_list[@cur_list_ind%#g_list+1])
  draw_grid(g_list_text[@cur_list_ind%#g_list_text+1])

  local one, two = 0xaa, 0x55
  for i=0,7 do poke(0x5f70+i,0b10101010) end
  scannum += .75
  scannum %= 64+20+1
  scannum2 += .5
  scannum2 %= 64+8+1

  local r, y, h = 31, 46, 14
  if false then
    local items = {"fIGHT", "pARTY", "aUTO", "fORFEIT"}
    if mock_ind == 3 then
      items = {"tACKLE", "tAILWHP", "fLMTHWR", "fLMWEEL"}
    elseif mock_ind == 1 then
      items = {"bROWSED", "vERSUSD", "eDIT", "lEAGUE"}
    end
    local xx, yy = @g_browse.numloc%4%2*30, @g_browse.numloc%4\2*9
    --rectfill(2, y+1, 31, y+7, C_1)
    rectfill(3+xx-1, y+1+yy-1, 31+xx, y+7+yy+1, @g_browse.numloc%4==0 and C_2 or C_2)

    for i=0,3 do
      xx, yy = i%2*31-1, i\2*9
      f_zprint(items[i+1], 4+xx, y+2+yy, i==@g_browse.numloc%4 and (i==0 and C_1 or C_3) or (i==0 and C_2 or C_2), -1)
    end

  elseif false then
    local items = {"uSE fLMTHWR?", "", "nORMAL 17/20PP", ""}
    local xx, yy = @g_browse.numloc%4%2*30, @g_browse.numloc%4\2*7
    ----rectfill(2+xx, y+1+yy, 31+xx, y+7+yy, C_2)

    for i=0,3 do
      xx, yy = i%2*31, i\2*7

      f_zprint(items[i+1], 3+xx, y+3+yy, i == 0 and C_3 or C_2, -1)
    end

  elseif false then
    local items = {"cHARMEL", "", "uSES fLMTHWR", ""}
    local xx, yy = @g_browse.numloc%4%2*30, @g_browse.numloc%4\2*7
    ----rectfill(2+xx, y+1+yy, 31+xx, y+7+yy, C_2)

    for i=0,3 do
      xx, yy = i%2*31, i\2*7

      f_zprint(items[i+1], 3+xx, y+3+yy, i == 0 and C_3 or C_2, -1)
    end

  elseif false then
    local numstr = tostr(@g_browse.numloc)
    while #numstr < 3 do numstr = "0"..numstr end
    --rectfill(2, y+1, 61, y+7, C_2)
    print(""..numstr.." "..pkmn_names[@g_browse.numloc+1],3, y+3,  C_3)
    local typstr = pkmn_types[@g_browse.numloc+1][1]
    if pkmn_types[@g_browse.numloc+1][2] ~= "" then
      typstr ..= "/"..pkmn_types[@g_browse.numloc+1][2]
    end
    print(typstr,3, y+8+2,C_2)
  end

  camera()

  pal(cols[@cols_loc%#cols+1], 1)
end
