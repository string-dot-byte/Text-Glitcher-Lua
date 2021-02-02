local StringLib = {}
local class = require(script.Parent.Class)

local TweenService = game:GetService('TweenService')

-- Glitch text setup
local Possible, createHash do
	Possible = {
		'-','+','*','/','|','}','{','[',']','~','\\','"',
		':',';','?','/','.','>','<','=','+','-','_',')',
		'(','*','&','%','$','#','@','!',')','}'
	}
	createHash = function(amount)
		if amount <= 0 then return '' end
		local s = ''
		for i = 1, amount do
			s ..= Possible[math.random(1, #Possible)]
		end
		return s
	end

	math.randomseed(tick() ^ 6)
end

local StylesFunction = {} do
	StylesFunction.EasingStyle = function(self)
		local FullString = self.FullString

		local Int = Instance.new('IntValue')
		local Completed = false
		Int.Value = 0 -- Hehe :)

		local tween = TweenService:Create(Int, self.TweenInfo, {Value = #FullString})
		tween:Play()
		tween.Completed:Connect(function()Completed = true end)
		
		local SingleHash = createHash(#FullString)
		
		local f = function()
			while not Completed do wait()
				local Hash = self.SingleHash and SingleHash:sub(self.Reversed and 1 or Int.Value, self.Reversed and #FullString-Int.Value or #FullString) or createHash(#FullString-Int.Value)
				self.TextDisplay.Text = self.Reversed and Hash .. FullString:sub(#FullString-Int.Value+1, #FullString) or FullString:sub(1, Int.Value) .. Hash
			end
			self.Completed = true
		end
		if self.Yielding == false then
			coroutine.wrap(f)()
		else
			f()
		end
	end
end

local StringAction = class() do
	function StringAction:init(FullString, TextDisplayer, info)
		if typeof(FullString) ~= 'string' then
			warn('Miss used type for first argument; Use a string instead.')
		end
		--[[ Note: Add checks to see if user passed TweenInfo correctly ]]
		
		self.FullString = FullString
		self.TextDisplay = TextDisplayer
		self.Yielding = info.Yielding or true
		--self.style = info.Style or ''
		self.Reversed = info.Reversed or false
		self.SingleHash = info.SingleHash or false
		
		self.TweenInfo = info.TweenInfo
	end
	
	function StringAction:GlitchText()
		--if StylesFunction[self.style]then
			--StylesFunction[self.style](self)
		--else
			StylesFunction.EasingStyle(self)
		--end
		return self.FullString -- In case anyone sets the Text property to the function
	end
	
	function StringAction:IsCompleted()
		return self.Completed or false
	end
end


return setmetatable({new = StringAction}, {
	__call = function (_, ...)
		return StringAction(...)
	end
})