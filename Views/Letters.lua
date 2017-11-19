local l = {}

local button = require("UI.Button")

l.letterButtons = {}

function l.createLetter( letter )
	local size = 40
	local l = button.new({
		width = size,
		height = size,
		font = "Avenir Next", 
		label = letter
	})
	return l
end

function l.gLetters( letters )
	local requested = {}
	for i=1,#letters do
		local letter = l.createLetter(letters[i])
		letter.id = letters[i]
		requested[#requested+1] = letter
	end
	return requested
end




return l