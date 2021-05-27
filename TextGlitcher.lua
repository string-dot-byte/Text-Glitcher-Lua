local StringLib = {}
local class = require(script.Parent.Class)

local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')


-- Glitch text setup
local Possible, createHash do
	Possible = {
		'-','+','*','/','|','}','{','[',']','~','\\','"',
		':',';','?','.','>','<','=','+','-','_',')',
		'(','*','&','%','$','#','@','!'
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
		Int.Value = 0 -- Hehe :)

		local tween = TweenService:Create(Int, self.TweenInfo, {Value = #FullString})
		self.tween = tween
		tween:Play()
		tween.Completed:Connect(function()self.Completed = true end)
		
		local SingleHash = self.Hashed or createHash(#FullString)
		
		local f = function()
			while not self.Completed do wait()
				local Hash = self.SingleHash and SingleHash:sub(self.Reversed and 1 or Int.Value, self.Reversed and #FullString-Int.Value or #FullString) or createHash(#FullString-Int.Value)
				self.TextDisplay.Text = self.Reversed and Hash .. FullString:sub(#FullString-Int.Value+1, #FullString) or FullString:sub(1, Int.Value) .. Hash
			end
			self.Completed = true
			Int:Destroy() -- destroy
		end
		
		if self.Yielding == false then
			coroutine.wrap(f)()
		else
			f()
		end
	end
	
	StylesFunction.Suffix = function(self)
		local FullString = self.FullString
		local Suffix = self.Suffix or ''

		local Int = Instance.new('IntValue')
		Int.Value = 0 -- Hehe :)

		local tween = TweenService:Create(Int, self.TweenInfo, {Value = #FullString})
		self.tween = tween
		tween:Play()
		tween.Completed:Connect(function()self.Completed = true end)
		
		local f = function()
			while not self.Completed do wait()
				local Suffix = Int.Value == #FullString and '' or Suffix
				self.TextDisplay.Text = FullString:sub(1, Int.Value) .. Suffix
			end
			self.Completed = true
			Int:Destroy()
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
		if type(FullString) ~= 'string' then
			warn('Miss used type for first argument; Use a string instead.')
		end
		
		self.FullString = FullString
		self.TextDisplay = TextDisplayer
		if info.Yielding == false then
			self.Yielding = false
		else
			self.Yielding = true
		end
		self.Reversed = info.Reversed or false
		self.SingleHash = info.SingleHash or false
		
		self.Suffix = info.Suffix
		
		self.TweenInfo = info.TweenInfo
	end
	
	function StringAction:GlitchText(style)
		if StylesFunction[style] then
			StylesFunction[style](self)
			return
		end
		StylesFunction.EasingStyle(self)
		--return self.FullString
	end
	
	function StringAction:IsCompleted()
		return self.Completed or false
	end
	
	function StringAction:Hash()
		self.Hashed = createHash(#self.FullString)
		self.TextDisplay.Text = self.Hashed
	end
	
	function StringAction:Cancel()
		self.Completed = true
		self.tween:Cancel()
	end
	
	function StringAction:Pause()
		self.tween:Pause()
	end
	
	function StringAction:Resume()
		self.tween:Play()
	end
	
	function StringAction:GetState()
		return self.tween.PlaybackState
	end
end


return setmetatable({new = StringAction}, {
	__call = function (_, ...)
		return StringAction(...)
	end
})
