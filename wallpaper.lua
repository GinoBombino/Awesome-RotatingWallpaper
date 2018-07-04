-- {{{ Random Wallpapers-- Get the list of files from a directory. Must be all images or folders and non-empty.

local gears = require("gears")
local io = io
local math = math
local os = os

function wallpaper.scanDir(directory)
	local i, fileList, popen = 0, {}, io.popen
	for filename in popen([[find "]] ..directory.. [[" -type f -iregex '.*\.\w*' ]]):lines() do
		i = i + 1
		fileList[i] = filename
	end
	return fileList
end

wallpaperList = scanDir("/home/grey/Images/FromPhone-Pictures/backgrounds/")

math.randomseed(os.time())

function wallpaper.setPaper(s)
	gears.wallpaper.maximized(wallpaperList[math.random(1, #wallpaperList)], s, false)
end

-- Apply a random wallpaper every changeTime seconds.
changeTime = 600
wallpaperTimer = gears.timer { timeout = changeTime }
wallpaperTimer:connect_signal("timeout", function()
	setPaper(s)
	-- stop the timer (we don't need multiple instances running at the same time)
	wallpaperTimer:stop() 
	--restart the timer
	wallpaperTimer.timeout = changeTime
	wallpaperTimer:start()
end)

