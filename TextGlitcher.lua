local TweenService = game:GetService 'TweenService'
local RunService = game:GetService 'RunService'


--[===[
		SETUP
  ]===]
export type GlitchAction = {
	FullString: string,
	TextDisplay: TextLabel | TextBox | TextButton,
	UnglitchedEvent: BindableEvent,
	TweenInfo: TweenInfo,
	GlitchCharacters: {string},
	Suffix: string,
	Reversed: boolean,
	SingleGlitch: boolean,
	Completed: boolean,
	MaintainEndTextAfterGlitch: boolean,
	UpdateRate: number,
	tween: TweenBase
}

local StringToTable = function(str: string): {string}
	local res = {}

	for c in str:gmatch '.' do
		table.insert(res, c)
	end

	return res
end

local PossibleGlitchCharacters: {string}, createGlitch do
	PossibleGlitchCharacters = {
		'-','+','*','/','|','}','{','[',']','~','\\','"',
		':',';','?','.','>','<','=','+','-','_',')',
		'(','*','&','%','$','#','@','!'
	}
	
	createGlitch = function(amount: number, customCharacters: {string}?): string
		--amount -= 1
		if amount <= 0 then return '' end

		local s = ''

		--[==[if amount >= 60 then -- table.concat is quicker than normal concatenation for larger strings
			
			local res = {}
			for i = 1, amount do
				res[i] = PossibleGlitchCharacters[math.random(1, #PossibleGlitchCharacters)]
			end
			
			return table.concat(res, '')
		end]==]

		for i = 1, amount do
			s ..= customCharacters[math.random(1, #customCharacters)]
		end

		return s
	end

	math.randomseed(os.clock() ^ 6)
end


--[===[
		STYLES
  ]===]
local StylesFunction = {} do
	StylesFunction.EasingStyle = function(self, Int: IntValue): ()
		local FullString = self.FullString


		local SingleGlitch = self.Glitched or createGlitch(#FullString, self.GlitchCharacters)

		while not self.Completed do
			local ThisGlitch = self.SingleGlitch and SingleGlitch:sub(self.Reversed and 1 or Int.Value, self.Reversed and #FullString-Int.Value or #FullString) or createGlitch(#FullString-Int.Value, self.GlitchCharacters)
			self.TextDisplay.Text = self.Reversed and ThisGlitch .. FullString:sub(#FullString-Int.Value+1, #FullString) or FullString:sub(1, Int.Value) .. ThisGlitch

			local Letter = FullString:sub(Int.Value, Int.Value)
			
			self.UnglitchedEvent:Fire(Letter)
			
			task.wait(self.UpdateRate)
		end
	end

	StylesFunction.Suffix = function(self, Int: IntValue)
		local FullString = self.FullString
		local Suffix = self.Suffix or ''

		while not self.Completed do
			local Suffix = self.MaintainEndTextAfterGlitch and (Int.Value == #FullString and '' or Suffix) or Suffix
			self.TextDisplay.Text = FullString:sub(1, Int.Value) .. Suffix

			local Letter = FullString:sub(Int.Value, Int.Value)
			
			self.UnglitchedEvent:Fire(Letter)
			
			task.wait(self.UpdateRate)
		end
	end

	StylesFunction.IndexUpdate = function(self, Int: IntValue)
		local FullString = self.FullString

		local LastIndex, LastGlitch = 1, nil
		while not self.Completed do
			local newGlitch = createGlitch(1, self.GlitchCharacters)
			
			if self.SingleGlitch and LastGlitch and Int.Value == LastIndex then
				newGlitch = LastGlitch
			end
			
			LastGlitch = newGlitch
			
			self.TextDisplay.Text = FullString:sub(1, math.abs(Int.Value-1)) .. newGlitch .. FullString:sub(Int.Value+1)
			LastIndex = Int.Value

			local Letter = FullString:sub(Int.Value, Int.Value)
			
			self.UnglitchedEvent:Fire(Letter)
			
			task.wait(self.UpdateRate)
		end

		self.TextDisplay.Text = self.MaintainEndTextAfterGlitch and self.TextDisplay.Text or FullString
	end
end


--[===[
		MAIN
  ]===]
local StringAction = {} do
	StringAction.__index = StringAction

	function StringAction.new(FullString: string, TextDisplayer: TextLabel | TextBox | TextButton, info: {}): GlitchAction
		if type(FullString) ~= 'string' then
			warn('Miss used type for first argument; Use a string instead.')
		end
		
		local self = setmetatable({}, StringAction)

		self.FullString = FullString
		self.TextDisplay = TextDisplayer
		self.Reversed = info.Reversed or false
		self.SingleGlitch = info.SingleGlitch or false
		self.MaintainEndTextAfterGlitch = info.MaintainEndTextAfterGlitch
		self.UpdateRate = info.UpdateRate
		self.Completed = false
		self.UnglitchedEvent = Instance.new 'BindableEvent'

		self.Suffix = info.Suffix or ''

		self.TweenInfo = info.TweenInfo or TweenInfo.new(1)

		self.GlitchCharacters = info.GlitchCharacters or PossibleGlitchCharacters

		return self
	end

	function StringAction:GlitchText(style: string?): ()
		if self.tween and self:GetState() == Enum.PlaybackState.Playing then return warn('Can not glitch text while it is already being glitched') end
		self.Completed = false

		local Int = Instance.new('IntValue')
		Int.Value = 0

		local tween = TweenService:Create(Int, self.TweenInfo, {Value = #self.FullString})
		self.tween = tween
		tween.Completed:Connect(function()self.Completed = true Int:Destroy()end)
		tween:Play()

		if StylesFunction[style] then
			StylesFunction[style](self, Int)
			return
		end

		StylesFunction.EasingStyle(self, Int)
	end

	function StringAction:IsCompleted(): boolean
		return self.Completed
	end

	function StringAction:GlitchOnce(customCharacters: {string}?): ()
		self.Glitched = createGlitch(#self.FullString, customCharacters or self.GlitchCharacters)

		self.TextDisplay.Text = self.Glitched
	end

	function StringAction:Cancel(): ()
		if not self.tween then return warn('There is no tween connected') end

		self.Completed = true
		self.tween:Cancel()
	end

	function StringAction:Pause(): ()
		if not self.tween then return warn('There is no tween connected') end

		self.tween:Pause()
	end

	function StringAction:Resume(): ()
		if not self.tween then return warn('There is no tween connected') end

		self.tween:Play()
	end

	function StringAction:GetState(): Enum.PlaybackState
		if not self.tween then return warn('There is no tween connected') end
		
		return self.tween.PlaybackState
	end
end


return StringAction
