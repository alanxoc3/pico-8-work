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

  sfx(num\4, 0, num%4*8, 8)
end

pkmn_names = split"mISSING,bULSAUR,iVYSAUR,vENSAUR,cHARMAN,cHARMEL,cHARZAR,sQUIRTL,wARTORT,bLSTOIS,cATRPIE,mETAPOD,bUTFREE,wEEDLE,kAKUNA,bEEDRIL,pIDGEY,pIDGETO,pIDGEOT,rATTATA,rATICAT,sPEAROW,fEAROW,eKANS,aRBOK,pIKACHU,rAICHU,sNDSHRW,sNDSLAS,nIDRANF,nIDRINA,nIDQUEN,nIDRANM,nIDRINO,nIDKING,cLFAIRY,cLFABLE,vULPIX,nINTALE,jIGPUFF,wIGTUFF,zUBAT,gOLBAT,oDDISH,gLOOM,vILPLUM,pARAS,pARSECT,vENONAT,vENMOTH,dIGLETT,dUGTRIO,mEOWTH,pERSIAN,pSYDUCK,gOLDUCK,mANKEY,pRIMAPE,gROWLTH,aRCANIN,pOLIWAG,pOLWIRL,pOLRATH,aBRA,kADABRA,aLKAZAM,mACHOP,mACHOKE,mACHAMP,bELSPRT,wEEPBEL,vICTBEL,tNTCOOL,tNTCRUL,gEODUDE,gRAVLER,gOLEM,pONYTA,rAPDASH,sLOWPOK,sLOWBRO,mAGNMIT,mAGNTON,fAFETCH,dODUO,dODRIO,sEEL,dEWGONG,gRIMER,mUK,sHELDER,cLYSTER,gASTLY,hAUNTER,gENGAR,oNIX,dROWZEE,hYPNO,kRABBY,kINGLER,vOLTORB,eLCRODE,eGGCUTE,eGGUTOR,cUBONE,mAROWAK,hITMLEE,hITMCHN,lIKTUNG,kOFFING,wEEZING,rHYHORN,rHYDON,cHANSEY,tANGELA,kANGKAN,hORSEA,sEADRA,gOLDEEN,sEAKING,sTARYU,sTARMIE,mRMIME,sCYTHER,jYNX,eLCABUZ,mAGMAR,pINSIR,tAUROS,mAGKARP,gYARDOS,lAPRAS,dITTO,eEVEE,vAPREON,jOLTEON,fLAREON,pORYGON,oMANYTE,oMASTAR,kABUTO,kABTOPS,aERODAC,sNORLAX,aRTCUNO,zAPDOS,mOLTRES,dRATINI,dRAGAIR,dRAGITE,mEWTWO,mEW,cHIKITA,bAYLEEF,mEGNIUM,cYNDQIL,qUILAVA,tYPHLOS,tOTODIL,cROCNAW,fRLGATR,sENTRET,fURRET,hOOTOOT,nOCTOWL,lEDYBA,lEDIAN,sPINRAK,aRIADOS,cROBAT,cHINCHU,lANTURN,pICHU,cLEFFA,iGGBUFF,tOGEPI,tOGETIC,nATU,xATU,mAREEP,fLAAFFY,aMPHROS,bELOSOM,mARILL,aZMARIL,sUDWOOD,pOLTOED,hOPPIP,sKIPLOM,jUMPLUF,aIPOM,sUNKERN,sUNFLOR,yANMA,wOOPER,qUAGSIR,eSPEON,uMBREON,mURKROW,sLOWKNG,mISDVUS,uNOWN,wOBUFET,gIFARIG,pINECO,fORTRES,dUNSPAR,gLIGAR,sTEELIX,sNUBBUL,gRANBUL,qILFISH,sCIZOR,sHUCKLE,hERCROS,sNEASEL,tEDIURS,uRSRING,sLUGMA,mACARGO,sWINUB,pILSWIN,cORSOLA,rEMRAID,oCTLERY,dELBIRD,mANTINE,sKARMRY,hONDOUR,hONDOOM,kINGDRA,pHANPY,dONPHAN,pORYGN2,sTANTLR,sMEARGL,tYROGUE,hITMTOP,sMOOCHM,eLEKID,mAGBY,mILTANK,bLISSEY,rAIKOU,eNTEI,sUICUNE,lARVTAR,pUPITAR,tYRATAR,lUGIA,hOOH,cELEBI"
pkmn_types = {{"bIRD","nORMAL"}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"fIRE",""}, {"fIRE",""}, {"fIRE","fLYING"}, {"wATER",""}, {"wATER",""}, {"wATER",""}, {"bUG",""}, {"bUG",""}, {"bUG","fLYING"}, {"bUG","pOISON"}, {"bUG","pOISON"}, {"bUG","pOISON"}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"nORMAL",""}, {"nORMAL",""}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"pOISON",""}, {"pOISON",""}, {"eLECTR",""}, {"eLECTR",""}, {"gROUND",""}, {"gROUND",""}, {"pOISON",""}, {"pOISON",""}, {"pOISON","gROUND"}, {"pOISON",""}, {"pOISON",""}, {"pOISON","gROUND"}, {"nORMAL",""}, {"nORMAL",""}, {"fIRE",""}, {"fIRE",""}, {"nORMAL",""}, {"nORMAL",""}, {"pOISON","fLYING"}, {"pOISON","fLYING"}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"bUG","gRASS"}, {"bUG","gRASS"}, {"pOISON","bUG"}, {"pOISON","bUG"}, {"gROUND",""}, {"gROUND",""}, {"nORMAL",""}, {"nORMAL",""}, {"wATER",""}, {"wATER",""}, {"fIGHTG",""}, {"fIGHTG",""}, {"fIRE",""}, {"fIRE",""}, {"wATER",""}, {"wATER",""}, {"wATER","fIGHTG"}, {"pSYCHC",""}, {"pSYCHC",""}, {"pSYCHC",""}, {"fIGHTG",""}, {"fIGHTG",""}, {"fIGHTG",""}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"gRASS","pOISON"}, {"wATER","pOISON"}, {"wATER","pOISON"}, {"rOCK","gROUND"}, {"rOCK","gROUND"}, {"rOCK","gROUND"}, {"fIRE",""}, {"fIRE",""}, {"pSYCHC","wATER"}, {"pSYCHC","wATER"}, {"sTEEL","eLECTR"}, {"sTEEL","eLECTR"}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"wATER",""}, {"wATER","iCE"}, {"pOISON",""}, {"pOISON",""}, {"wATER",""}, {"wATER","iCE"}, {"gHOST","pOISON"}, {"gHOST","pOISON"}, {"gHOST","pOISON"}, {"rOCK","gROUND"}, {"pSYCHC",""}, {"pSYCHC",""}, {"wATER",""}, {"wATER",""}, {"eLECTR",""}, {"eLECTR",""}, {"gRASS","pSYCHC"}, {"gRASS","pSYCHC"}, {"gROUND",""}, {"gROUND",""}, {"fIGHTG",""}, {"fIGHTG",""}, {"nORMAL",""}, {"pOISON",""}, {"pOISON",""}, {"gROUND","rOCK"}, {"gROUND","rOCK"}, {"nORMAL",""}, {"gRASS",""}, {"nORMAL",""}, {"wATER",""}, {"wATER",""}, {"wATER",""}, {"wATER",""}, {"wATER",""}, {"wATER","pSYCHC"}, {"pSYCHC",""}, {"bUG","fLYING"}, {"pSYCHC","iCE"}, {"eLECTR",""}, {"fIRE",""}, {"bUG",""}, {"nORMAL",""}, {"wATER",""}, {"wATER","fLYING"}, {"wATER","iCE"}, {"nORMAL",""}, {"nORMAL",""}, {"wATER",""}, {"eLECTR",""}, {"fIRE",""}, {"nORMAL",""}, {"rOCK","wATER"}, {"rOCK","wATER"}, {"rOCK","wATER"}, {"rOCK","wATER"}, {"rOCK","fLYING"}, {"nORMAL",""}, {"iCE","fLYING"}, {"eLECTR","fLYING"}, {"fIRE","fLYING"}, {"dRAGON",""}, {"dRAGON",""}, {"dRAGON","fLYING"}, {"pSYCHC",""}, {"pSYCHC",""}, {"gRASS",""}, {"gRASS",""}, {"gRASS",""}, {"fIRE",""}, {"fIRE",""}, {"fIRE",""}, {"wATER",""}, {"wATER",""}, {"wATER",""}, {"nORMAL",""}, {"nORMAL",""}, {"fLYING","nORMAL"}, {"fLYING","nORMAL"}, {"bUG","fLYING"}, {"bUG","fLYING"}, {"bUG","pOISON"}, {"bUG","pOISON"}, {"pOISON","fLYING"}, {"eLECTR","wATER"}, {"eLECTR","wATER"}, {"eLECTR",""}, {"nORMAL",""}, {"nORMAL",""}, {"nORMAL",""}, {"nORMAL","fLYING"}, {"pSYCHC","fLYING"}, {"pSYCHC","fLYING"}, {"eLECTR",""}, {"eLECTR",""}, {"eLECTR",""}, {"gRASS",""}, {"wATER",""}, {"wATER",""}, {"rOCK",""}, {"wATER",""}, {"gRASS","fLYING"}, {"gRASS","fLYING"}, {"gRASS","fLYING"}, {"nORMAL",""}, {"gRASS",""}, {"gRASS",""}, {"bUG","fLYING"}, {"wATER","gROUND"}, {"wATER","gROUND"}, {"pSYCHC",""}, {"dARK",""}, {"dARK","fLYING"}, {"pSYCHC","wATER"}, {"gHOST",""}, {"pSYCHC",""}, {"pSYCHC",""}, {"pSYCHC","nORMAL"}, {"bUG",""}, {"bUG","sTEEL"}, {"nORMAL",""}, {"gROUND","fLYING"}, {"sTEEL","gROUND"}, {"nORMAL",""}, {"nORMAL",""}, {"wATER","pOISON"}, {"sTEEL","bUG"}, {"bUG","rOCK"}, {"bUG","fIGHTG"}, {"dARK","iCE"}, {"nORMAL",""}, {"nORMAL",""}, {"fIRE",""}, {"fIRE","rOCK"}, {"gROUND","iCE"}, {"gROUND","iCE"}, {"rOCK","wATER"}, {"wATER",""}, {"wATER",""}, {"fLYING","iCE"}, {"wATER","fLYING"}, {"sTEEL","fLYING"}, {"dARK","fIRE"}, {"dARK","fIRE"}, {"wATER","dRAGON"}, {"gROUND",""}, {"gROUND",""}, {"nORMAL",""}, {"nORMAL",""}, {"nORMAL",""}, {"fIGHTG",""}, {"fIGHTG",""}, {"pSYCHC","iCE"}, {"eLECTR",""}, {"fIRE",""}, {"nORMAL",""}, {"nORMAL",""}, {"eLECTR",""}, {"fIRE",""}, {"wATER",""}, {"rOCK","gROUND"}, {"rOCK","gROUND"}, {"dARK","rOCK"}, {"pSYCHC","fLYING"}, {"fIRE","fLYING"}, {"gRASS","pSYCHC"}}

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

function draw_pkmn(num, x, y, highlighted, flip)
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

  if highlighted then
    roundrect(x, y, 10, 10, C_3)
  end

  for yy=-1,1 do
    for xx=-1,1 do
      if not (xx == 0 and yy == 0) then
        colordrawfunc(x+xx, y+yy, highlighted and C_2 or C_1)
      end
    end
  end

  colordrawfunc(x, y, highlighted and C_4 or C_3) -- sprite
end

-- {dark, light}
function vget(offset, x, y)
  x = min(max(0, x), 127)\1
  y = y\1

  local val = peek(y*64+offset+x\2)
  if x%2 == 1 then return (val & 0xf0) >>> 4
  else             return (val & 0x0f) end
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
end

C_0=0 C_1=1 C_2=2
C_3=3 C_4=4 C_5=5
C_6=6
cols = {
  {[0]=129, 1,   131, 3,   139, 11, 0},
  {[0]=129, 130, 132, 4,   143, 15, 0},
  {[0]=129, 129, 1,   140, 12,  12, 0},
  {[0]=129, 133, 5,   13,  6,   7 , 0},
}

mock_ind = 0
cols_ind = 0
g_off = 0
g_scale = 1
view_y = 0
g_num  = 0
g_active = false
g_hpmod = 0
g_pkmn = 25
g_pkmn_x = 0
function _update60()
  g_pkmn_off = 0
  local cycle = 3.5
  if t()%cycle < 2 then
    if t()%cycle < 1 then
      g_pkmn_x += 1
    else
      if t()%cycle == 1 then
        g_pkmn = rnd(251)\1+1
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

  if btnp(0) then g_hpmod -= 1 g_num = mid(0,251,g_num-1) end
  if btnp(1) then g_hpmod += 1 g_num = mid(0,251,g_num+1) end
  if btnp(2) then g_active = not g_active g_num = mid(g_num%3,249+g_num%3,g_num-3) end
  if btnp(3) then g_active = not g_active g_num = mid(g_num%3,249+g_num%3,g_num+3) end
  if btnp(4) then minisfx(g_num) end
  if btnp(5) then mock_ind = (mock_ind + 1) % 6 end

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
  --rect(0,0,63,63,C_1)
  camera(0,1)
  --rect(0,0,63,63,C_0)
  roundrect(32,23,31,21,C_2)
  fillp()
  clip(1, 1, 62, 42)

  --fillp(0b1111000011110000)
  --rectfill(0,scannum2-5,63,scannum2-3,     (C_3 << 4) | C_2)
  --fillp()

  --fillp(0b0000111100001111)
  --rectfill(0,64-scannum+12,63,64-scannum+8,(C_3 << 4) | C_2)
  --fillp()

  if mock_ind == 0 then
    local yy = view_y*3
    local xo = 12
    local yo = 13
    for ii=0,2 do
      local ind = yy + ii
      draw_pkmn(ind, xo+ii*20, yo, ind == g_num)
    end

    yy = (view_y*3+3)%252
    for ii=0,2 do
      local ind = yy + ii
      draw_pkmn(ind, xo+ii*20, yo+20, ind == g_num)
    end

  elseif mock_ind == 1 then
    --rectfill(1,2,62,43,C_2)
    local ox, oy = 2, 8+7-7+7+7+1
    --roundrect_r(0+2,oy,63-1-1,oy+20-1,C_3)
    f_zprint("\^w\^tpicodex",  3+5-1-2, oy+3-19-2-1,    C_1, -1)
    f_zprint("\^wdual",  3+5-1-2+12, oy-3-19+12+1+3-1,  C_1, -1)

    local xx, yy = g_num%6%2*31, g_num%6\2*7
    draw_pkmn(254, 32-10, oy+8+2, false)
    draw_pkmn(g_pkmn, 32+10+4+g_pkmn_x+g_pkmn_off, oy+8+2, false)
    --rectfill(ox+xx-1, oy+yy, 29+ox+xx, oy+6+yy, C_3)

    -- local items = {
    --   "browse", "edit",
    --   "league", "versus",
    --   "horde", "credits",
    -- }
    -- for i=0,5 do
    --   local xx, yy = i%2*31, i\2*7
    --   local wob = i%2==0
    --   local col = C_1
    --   if i == g_num%6 then wob = t()\1%2==0 col = C_2 end
    --   f_zprint(items[i+1], 2+ox+xx-1, 1+oy+yy, col, -1)
    -- end

  elseif mock_ind >= 2 then
    local b = function(name, gender, status, x, y, bx, by, hi, hp, hpmax)
      local d, l = C_1, C_3
      if hi then
        d, l = C_2, C_4
      end

      roundrect_r(bx-1, by+1, bx+35, by+6, d)
      if hp > 0 then
        rectfill(bx, by+2, bx+mid(1, hp/hpmax*34, 34), by+5, l)
        pset(bx, by+2, d)
        pset(bx+34, by+2, d)
        pset(bx, by+5, d)
        pset(bx+34, by+5, d)
      end

      local tx, ty = x+15, y+9
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
      f_zprint(status,   x+0, y+8, d, -1)
      f_zprint(flr(hp), x+37, y+8, d, 1)
      f_zprint(gender, x+37, y-5, d, 1)
    end

    local myoff = (not g_active and 21 or 1)
    roundrect_r(2, 2+myoff, 61, 22+myoff-1, C_3)

    draw_pkmn(5, 52, 13,     g_active, true) b("cHARMEL",  "M", "bRN", 4,  9,  4, 9,  g_active,   80+g_hpmod, 90)
    draw_pkmn(5, 12, 33, not g_active)       b("cHARMEL",  "M", "",    25, 29, 25,29,  not g_active, 100+g_hpmod, 100)
  end

  clip()
  camera()
  camera(0,0)

  local one, two = 0xaa, 0x55
  for i=0,7 do poke(0x5f70+i,0b10101010) end
  scannum += .75
  scannum %= 64+20+1
  scannum2 += .5
  scannum2 %= 64+8+1

  local r, y, h = 31, 46, 14
  roundrect_r(31-r+1-1, y,   32+r-1+1, y+h+1,C_0)

  if mock_ind == 1 or mock_ind == 2 or mock_ind == 3 then
    local items = {"fIGHT", "pARTY", "aUTO", "fORFEIT"}
    if mock_ind == 3 then
      items = {"tackle", "tailwhp", "flmthwr", "flmweel"}
    elseif mock_ind == 1 then
      items = {"bROWSE", "vERSUS", "eDIT", "lEAGUE"}
    end
    local xx, yy = g_num%4%2*31, g_num%4\2*7
    --rectfill(2, y+1, 31, y+7, C_1)
    roundrect_r(2+xx-1, y+1+yy, 31+xx, y+7+yy, g_num%4==0 and C_2 or C_2)

    for i=0,3 do
      xx, yy = i%2*31, i\2*7
      f_zprint(items[i+1], 3+xx, y+2+yy, i==g_num%4 and C_3 or C_2, -1)
    end
    line(30,45, 33,45, C_2)
    line(31,44, 32,44, C_2)
    line(30,62, 33,62, C_2)
    line(31,63, 32,63, C_2)

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
    print(""..numstr.." "..pkmn_names[g_num+1],3, y+2,  C_3)
    local typstr = pkmn_types[g_num+1][1]
    if pkmn_types[g_num+1][2] ~= "" then
      typstr ..= "/"..pkmn_types[g_num+1][2]
    end
    print(typstr,3, y+8+1,C_2)
  end

  pal(cols[cols_ind+1], 1)
  camera()
end
