-- title:  Type States
-- author: Nathan Jent
-- desc:   Trying out the type state pattern in MoonScript to model and FSM with types.
-- script: moon

sign=(n)->n>0 and 1 or n<0 and -1 or 0

export class Player
 new:(o)=>
  if o == nil then o={}
  @elapsed=o.elapsed or 0
  @x=o.x or 96
  @y=o.y or 24
  @spdx=0
  @spdy=0
  @maxspd=20
  @cur_frame=o.cur_frame or 1
  @frame_elapsed=o.frame_elapsed or 0
 walk:()=>WalkingPlayer @
 stop:=>
  @elapsed=0
  Player @
 frames:{
  {id:1,w:2,h:2,hold:160}
  {id:3,w:2,h:2,hold:5}
 }
 update:(t)=>@
 draw:(t)=>
  @frame_elapsed+=1
  print("frame_elapsed: #{@frame_elapsed}",0,16,2)
  print("spdx: #{@spdx}, spdy: #{@spdy}",0,24,2)
  if @cur_frame > #@frames
   @cur_frame=1
   @frame_elapsed=0
  frame=@frames[@cur_frame]
  if @frame_elapsed > frame.hold
   @cur_frame+=1
   @frame_elapsed=0
  spr frame.id,@x,@y,14,3,0,0,2,2

export class WalkingPlayer extends Player
 new:(o)=>
  @spdx=o.spdx or 0
  @spdy=o.spdy or 0
  super o
 walk:(dspdx,dspdy)=>
  @elapsed=0
  if math.abs(@spdx) < @maxspd or sign(@spdx) != sign(dspdx)
   @spdx+=dspdx
  if math.abs(@spdy) < @maxspd or sign(@spdy) != sign(dspdy)
   @spdy+=dspdy
  @
 stop:=>super!
 frames:{
  {id:1,w:2,h:2,hold:12}
  {id:5,w:2,h:2,hold:12}
  {id:7,w:2,h:2,hold:12}
  {id:9,w:2,h:2,hold:12}
 }
 update:(t)=>
  @x+=@spdx/30
  @y+=@spdy/30
  @elapsed+=1
  if @elapsed > 30
   @\stop! else @
 draw:(t)=>super t

p=Player!
t=0

update=(t)->
 xInput=0
 yInput=0
 if btn 0
  yInput-=1
 if btn 1
  yInput+=1
 if btn 2
  xInput-=1
 if btn 3
  xInput+=1

 if xInput != 0 and yInput != 0
  p=p\walk xInput,yInput,0.7071
 else if xInput != 0
  p=p\walk xInput,0,1
 else if yInput != 0
  p=p\walk 0,yInput,1

 p=p\update t

draw=(t)->
 cls 13
 print("time: #{t}",0,0,2)
 print("elapsed: #{p.elapsed}",0,6,2)
 p\draw t

export TIC=->
 t+=1
 update t
 draw t

-- <TILES>
-- 001:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 002:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 003:eccccccccc888888caaaaaaaca888888cacccccccacccccccacc0ccccacc0ccc
-- 004:ccccceee8888cceeaaaa0cee888a0ceeccca0cccccca0c0c0cca0c0c0cca0c0c
-- 005:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 006:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 007:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 008:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 009:eccccccccc888888caaaaaaaca888888cacccccccacc0ccccacc0ccccacc0ccc
-- 010:ccccceee8888cceeaaaa0cee888a0ceeccca0ccc0cca0c0c0cca0c0c0cca0c0c
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 021:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888c000ccccccccceec
-- 022:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 023:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888ccc000c0eecccccc
-- 024:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee00ccceeeccceeeee
-- 025:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cc0eccccccc
-- 026:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee00ccceeeccceeeee
-- </TILES>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdeffedcba9876543210
-- 002:0123456789abcdef0123456789abcdef
-- </WAVES>

-- <SFX>
-- 000:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- </SFX>

-- <PALETTE>
-- 000:1a1c2c5d275db13e53ef7d57ffcd75a7f07038b76425717929366f3b5dc941a6f673eff7f4f4f494b0c2566c86333c57
-- </PALETTE>

