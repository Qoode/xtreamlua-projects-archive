--# Openning Sequence 
police = Font.load("Data/Common/font.ttf")
Mp3me.load("Data/Music/Intro.mp3")


pic = {}
pic[1] = Image.load("Data/Picture/Art/ashley.png")
pic[2] = Image.load("Data/Picture/Art/hao.png")

function playText()

 while true do
 coroutine.yield(text)
 end
end

function picDefile()
end



dofile("System/game.lua")