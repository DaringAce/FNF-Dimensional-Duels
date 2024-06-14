--Quick explanation P3 is for player's ally icon and P4 is for being the opponent's ally below there are other modes of this script if you only want a third icon
--Just write the path of your icons make sure the resolution of them are 300*150 in the future i will prob add wininng icons support :p
P3 = "icons/extra/icon-CapZ"
P4 = "icons//extra/icon-Anti" 
P3P = false 
--Set on true when you want only P3 being the enemy and there isn't a character which takes the place of P4
P3E = false
--Set on true when you want only a P3 being the player's ally and there isn't a character which takes the place of P4
--By default it will bring both icons so let them on false to bring P3 and P4 icons so plz don't set both as true .-.

function onCreatePost() --Made by me Aldoidk04 :33333
	if P3E then
		P4 = P3
		icon2()
	elseif P3P then
		icon1()
	else
		icon1()
		icon2()
	end
end
--The rest is just the logic of the script :p sorry if is a big mess
--If you have a custom healthbar or something i think you should look at these lines (20,21 and 38,39)and set true to false
function icon1()
	makeLuaSprite('iconP3',nil,0,0)
	loadGraphic('iconP3', P3)
	loadGraphic('iconP3', P3, getProperty('iconP3.width') / 2)
	addAnimation('iconP3', '', {0, 1}, 0)
	setObjectOrder('iconP3', getObjectOrder('iconP1') + 16)
	setProperty("iconP3.flipX", true)
	setObjectCamera('iconP3', "camHUD")
end

function icon2()
	makeLuaSprite('iconP4',nil,0,0)
	loadGraphic('iconP4', P4)
	loadGraphic('iconP4', P4, getProperty('iconP4.width') / 2)
	addAnimation('iconP4', '', {0, 1}, 0)
	setObjectOrder('iconP4', getObjectOrder('iconP2') + 1)
	setObjectCamera('iconP4', "camHUD")
end

function onUpdatePost()
	local h = getProperty('health')

	for i = 3, 4 do
		local ic = 'iconP'..(i - 2)
	--Oh yeah if you want them with the same alpha from the actual icons just remove the 2 lines lol
		--setProperty('iconP'..i..'.alpha',getProperty(ic..'.alpha'))
		setProperty('iconP'..i..'.angle',getProperty(ic..'.angle'))
		setProperty('iconP'..i..'.x',getProperty(ic..'.x') + (i == 3 and 50 or -50))

		setProperty('iconP'..i..'.y',getProperty(ic..'.y') + (downscroll and -55 or 55))
	--If you want to make them smaller i would recommend you to just write -0.1
		setProperty('iconP'..i..'.scale.x', getProperty(ic..'.scale.x'))
		setProperty('iconP'..i..'.scale.y', getProperty(ic..'.scale.y'))
	end

	setProperty('iconP3.animation.curAnim.curFrame', h < 0.4 and 1 or 0)
	setProperty('iconP4.animation.curAnim.curFrame', h > 1.6 and 1 or 0)
end