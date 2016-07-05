function love.load()
	x = 0
	i = 0
	mp3 = love.audio.newSource("music.mp3", "static")
	personaje = love.graphics.newImage("bunny.jpg")

end

function love.update(dt)
	if love.keyboard.isDown("right") then
		x = x + 1
		love.graphics.setColor(255, 0, 0)
		love.audio.play(mp3)
	else love.audio.pause(mp3)
	end

	if love.keyboard.isDown("left") then
		x = x - 1
		love.graphics.setColor(0, 0, 255)
	end

	if love.keyboard.isDown("up") then
		i = i - 1
		love.graphics.setColor(0, 255, 0)
	elseif love.keyboard.isDown("down") then
		i = i + 1
		love.graphics.setColor(255, 255, 255)
	end
end

function love.draw()
    love.graphics.draw(personaje, x, i, 0, 0.3, 0.3)
    
end