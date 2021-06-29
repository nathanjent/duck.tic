-- title:  Type States
-- author: Nathan Jent
-- desc:   Trying out the type state pattern in MoonScript to model and FSM with types.
-- script: moon

export class Player
 new:(o)=>
  @elapsed=0
  if o
   @x=o.x or 96
   @y=o.y or 24
  else
   @x=96
   @y=24
  trace "idling..."
 up:=>
  WalkingPlayer @
 down:=>
  WalkingPlayer @
 left:=>
  WalkingPlayer @
 right:=>
  WalkingPlayer @
 stop:=>
  @elapsed=0
  Player @
 draw:(t)=>
  spr 1+(t%60)//30*2,@x,@y,14,3,0,0,2,2

export class WalkingPlayer extends Player
 new:(o)=>
  super o
  trace "walking..."
 up:=>
  @y-=1
  WalkingPlayer @
 down:=>
  @y+=1
  WalkingPlayer @
 left:=>
  @x-=1
  WalkingPlayer @
 right:=>
  @x+=1
  WalkingPlayer @
 stop:=>
  @elapsed=0
  Player @
 draw:(t)=>super t

p=Player!
t=0

update=(t)->
 p.elapsed+=1
 if p.elapsed > 10
  p=p\stop!
 if btn 0
  p=p\up!
 if btn 1
  p=p\down!
 if btn 2
  p=p\left!
 if btn 3
  p=p\right!

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
-- 017:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 018:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
-- 019:cacccccccaaaaaaacaaacaaacaaaaccccaaaaaaac8888888cc000cccecccccec
-- 020:ccca00ccaaaa0ccecaaa0ceeaaaa0ceeaaaa0cee8888ccee000cceeecccceeee
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

