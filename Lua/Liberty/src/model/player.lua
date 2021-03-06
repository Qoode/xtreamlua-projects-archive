--- Player view property
player = {
	size = {
		width = 40,
		height = 80
	},
	frameRate = 0.08;
	[STAND] = { { { x = 240, y = 160 } , { x = 240, y = 160 } } },
	[RUN] 	= {
			{ { x = 0, y = 0}, { x = 0, y = 80} },
			{ { x = 40, y = 0}, { x = 40, y = 80} },
			{ { x = 80, y = 0}, { x = 80, y = 80} },
			{ { x = 120, y = 0}, { x = 120, y = 80} },
			{ { x = 160, y = 0}, { x = 160, y = 80} },
			{ { x = 200, y = 0}, { x = 200, y = 80} }
	},
	[JUMP] 	= {
			{ { x = 0, y = 160} , { x = 0, y = 240} },
			{ { x = 40, y = 160} , { x = 40, y = 240} },
			{ { x = 80, y = 160} , { x = 80, y = 240} },
			{ { x = 120, y = 160} , { x = 120, y = 240} },
			{ { x = 160, y = 160} , { x = 160, y = 240} },
			{ { x = 200, y = 160} , { x = 200, y = 240} },
	}
}

return player;
