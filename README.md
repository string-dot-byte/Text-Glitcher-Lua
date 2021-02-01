# Text-Glitcher-Lua

Text-Glitcher is a Roblox module which permits you to have glitched text effect with some symbols. Great use for horror type games or perhaps to give a cool effect.

With the utilisation of TweenService, I have brought to you this module which permits text tweens almost the same way you would do for normal tweening.

<p align="center">
  <img src="https://media.discordapp.net/attachments/769655840985579520/801955296183582750/3M75PUZhkU.gif" alt="Glitcher demo" height="500">
</p>

The idea to open source this module and add more features came to me just by having a chat with my girlfriend on open sourced scripts. 

## Usage
```lua
local TextGlitcher = require(THEMODULE)

local Glitcher = TextGlitcher.new('The end text should be this', HereIsTheTextLabel,{
  TweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
  Reversed = true, SingleHash = false
})
Glitcher:GlitchText()
```
Now there I'm making a TextGlitcher function with a TweenInfo which will then be passed into an actual tween handling the glitching. That Dictionary takes multiple values if wanted, but isn't necessary unless you want to use them. Default values are listed below along with more options.




# API
---

### TextGlitcher.new(EndString, TextObject, {Dictionary options})


## Options

| Option name | Description | Default value | Type |
| ----------- | ----------- | ------------- | ---- |
| Reversed | Wether the style should play in reverse (Example: Linear; from last to first). | false | Boolean
| Yielding | Should it Yield while you are running it. | true | Boolean
| SingleHash | Should it only create one glitched text for the whole glitching? | false | Boolean


### Glitcher:GlitchText()

Starts the glitching with the options passed into `TextGlitcher.new()`

- Returns the end expected string (don't ask)


### Glitcher:IsCompleted()

If the glitching has been completed.

- Returns a boolean.





