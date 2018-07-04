-- {{{ Random Wallpapers-- Get the list of files from a directory. Must be all images or folders and non-empty.

local gears = require("gears")
local io = io
local math = math
local os = os

local wallpaper = {}

function wallpaper.scanDir(directory)
	local i, fileList, popen = 0, {}, io.popen
	for filename in popen([[find "]] ..directory.. [[" -type f -iregex '.*\.\w*' ]]):lines() do
		i = i + 1
		fileList[i] = filename
	end
	return fileList
end

wallpaperList = wallpaper.scanDir("/home/grey/Images/FromPhone-Pictures/backgrounds/")

math.randomseed(os.time())

function wallpaper.setPaper(s)
	gears.wallpaper.maximized(wallpaperList[math.random(1, #wallpaperList)], s, false)
end

-- Apply a random wallpaper every changeTime seconds.
changeTime = 600
wallpaper.timer = gears.timer { timeout = changeTime }
wallpaper.timer:connect_signal("timeout", function()
	wallpaper.setPaper(s)
	-- stop the timer (we don't need multiple instances running at the same time)
	wallpaper.timer:stop() 
	--restart the timer
	wallpaper.timer.timeout = changeTime
	wallpaper.timer:start()
end)


return wallpaper
