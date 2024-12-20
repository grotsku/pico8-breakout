pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
function _init()
	--variables
	--ball
	ball_x=1
	ball_dx=2
	ball_y=64
	ball_dy=2
	ball_r=2
	--paddle
	pad_x=52
	pad_y=120
	pad_dx=0
	pad_w=24
	pad_h=3
	pad_c=7
	cls()
end

function _update()
	ball_x+=ball_dx
	ball_y+=ball_dy
	
	bounce()
	move_pad()
	
	--check if ball hit pad
	if ball_box(pad_x,pad_y,pad_w,pad_h) then
		ball_dy=-ball_dy
		sfx(2)
	end
end

function _draw()
	cls()
	rectfill(0,0,127,127,1)
	circfill(ball_x,ball_y,ball_r,10)
	rectfill(pad_x,pad_y,pad_x+pad_w,pad_y+pad_h,pad_c)
end
-->8
--functions

function bounce()
	if ball_x>127 or ball_x<0 then
		ball_dx=-ball_dx
		sfx(1)
	end
	if ball_y>127 or ball_y<0 then
		ball_dy = -ball_dy
		sfx(1)
	end
end

function move_pad()
	local btn_press=false
	local speed=1.8
	--left
	if btn(0) then
		pad_dx-=speed
		btn_press=true
		sfx(3)
	end
	--right
	if btn(1) then
		pad_dx+=speed
		btn_press=true
		sfx(3)
	end
	
	--slowdown
	if not (btn_press) then
		pad_dx=pad_dx/1.8
	end
	
	pad_x+=pad_dx
end

function ball_box(box_x,box_y,box_w,box_h)
	--check collision with ball and box
	if ball_y-ball_r>box_y+box_h then
		return false
	end
	--check something y
	if ball_y+ball_r<box_y then
		return false
	end
	--check x
		if ball_x-ball_r>box_x+box_w then
		return false
	end
	--check something x
	if ball_x+ball_r<box_x then
		return false
	end
		
	return true
end

--[[ check ball collision with
paddle. not sure about this.
tutorial bit confusing --]]
-- ty,tx etc. are target
function deflect_ball_paddle(ball_x,ball_y,ball_dx,ball_dy,tx,ty,tw,ty)
	if ball_dx==0 then
		--moving vertically
		return false
	elseif ball_dy==0 then
		--moving horizontally
		return true
	else
		--moving diagonally
		--calculate slope
		local slp=ball_dy/ball_dx
		local cx,cy
		--check variants
		if slp>0 and ball_dx>0 then
			--moving down right
			--31:39 breakout#7
		end
	end
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
00010000000001c0001c0001d0001300013000180001a000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000233501a000190000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00010000263501b7100f7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100002f1101c100281000000012600000000f600106000e6000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
