# Text-Glitcher-Lua

Text-Glitcher is a Roblox module which permits you to have glitched text effect with some symbols. Great use for horror type games or perhaps to give a cool effect.

With the utilisation of TweenService, I have brought to you this module which permits text tweens almost the same way you would do for normal tweening.

<p align="center">
  <img src="https://cdn.discordapp.com/attachments/577991646449238016/847567303116849152/ezgif-2-ab923b990e8b.gif" alt="Glitcher demo" height="200">
  <img src="https://cdn.discordapp.com/attachments/577991646449238016/847567323790966814/3M75PUZhkU.gif" alt="Glitcher demo" height="200">
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
| TweenInfo | The tween information, explanable on the docs | None (errors) | TweenInfo
| Suffix | (If using the custom Suffix style) Text suffix | Empty string | String


### Glitcher:GlitchText(*style*)

Starts the glitching with the options passed into `TextGlitcher.new()`


### Glitcher:IsCompleted()

If the glitching has been completed.

- Returns a boolean.


### Glitcher:Hash()

Hashes the GUI's text directly. You can call this multiple times but will not show the actual string. Look at `Glitcher:GlitchText()` instead for text glitching.


### Glitcher:Cancel()

Cancels and ends the glitching tween.


### Glitcher:Pause()

Pauses the current tween until it's been called again by `Glitcher:Resume()` or until it has been cancelled.


### Glitcher:Resume()

Resumes the paused tween.


### Glitcher:GetState()

Gets the PlaybackState of the playing tween on the glitcher.
See more here: https://developer.roblox.com/en-us/api-reference/enum/PlaybackState


Current styles are:
* `Suffix`: Where the text typewrites itself with an optional character at the end
Pass in the `Suffix` index as string in the information when creating the glitcher.

* `IndexUpdate`: The current index character will be the on which will ONLY have a weird character. Example: TEST (Index 2) -> T\*ST
