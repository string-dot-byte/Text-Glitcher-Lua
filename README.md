# Text-Glitcher

Text-Glitcher is a Roblox module which handles text glitching effects with symbols. Great use for horror type games or perhaps to give a cool effect to text.

## Features
 - Uses TweenService for simple and multiple tweening options
 - Reverse option to have the effect in reverse
 - You can customize your array easily for the unknown symbols section
- This module provides different glitching styles

<p align="center">
  <img src="https://cdn.discordapp.com/attachments/577991646449238016/847567303116849152/ezgif-2-ab923b990e8b.gif" alt="Glitcher demo" height="200">
  <img src="https://cdn.discordapp.com/attachments/577991646449238016/847567323790966814/3M75PUZhkU.gif" alt="Glitcher demo" height="200">
</p>

With the utilisation of TweenService, I have brought to you this module which permits text tweens almost the same way you would do for normal tweening.

## Usage
```lua
local TextGlitcher = require(THEMODULE)

local Glitcher = TextGlitcher.new('The end text should be this', HereIsTheTextLabel,{
  TweenInfo = TweenInfo.new(2, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
  Reversed = true, SingleGlitch = false
})
Glitcher:GlitchText()
```
We initialize the Glitcher with the `.new` function and pass the end text as the first argument, and the 2nd one would be the GuiObject and the 3rd one is the options.

After that, we call the `GlitchText` method to start glitching the text.

The options table isn't necessary, although it's good to add it for a neat and appealing animation. If nothing is provided, it will default (see table below).




# API
---

### TextGlitcher.new(EndString: string, TextObject: TextLabel \| TextButton \| TextBox, {Dictionary options})

*Note: TextObject would be the UI the text would be transmitted onto*


## Options

| Option name | Description | Default value | Type |
| ----------- | ----------- | ------------- | ---- |
| Reversed | Whether the style should play in reverse (Example: Linear; from last to first). | false | Boolean
| SingleGlitch | Should it only create one glitched text for the whole glitching? | false | Boolean
| Suffix | (If using the custom Suffix style) Text suffix | Empty string | String
| MaintainEndTextAfterGlitch | Maintain the current text when the animation finishes | false | Boolean
| UpdateRate | The rate at which the glitch effect is updated onto the label | nil | Number
| TweenInfo | Classic TweenInfo created with `TweenInfo.new()` | nil | TweenInfo
| GlitchCharacters | List of characters to grab for the glitch efffect | {...} | Table
| UnglitchedEvent | BindableEvent that gets fired when a character is changed | nil | BindableEvent



### Glitcher:GlitchText(*style: string?*)

Starts the glitching with the options passed into `TextGlitcher.new()`
`styles` are listed at the bottom of the post.


### Glitcher:IsCompleted()*: boolean*

If the glitching has been completed.

- Returns a boolean.


### Glitcher:GlitchOnce(*customCharacters: {string}?*)

Glitches the GUI's text directly. You can call this multiple times.


### Glitcher:Cancel()

Cancels and ends the glitching tween.


### Glitcher:Pause()

Pauses the current tween until it's been called again by `Glitcher:Play()` or until it has been cancelled.


### Glitcher:Resume()

Resumes the paused tween.


### Glitcher:GetState()*: Enum.PlaybackState*

Gets the PlaybackState of the playing tween on the glitcher.
See more here: https://developer.roblox.com/en-us/api-reference/enum/PlaybackState

You can also grab the current tween with `Glitcher.tween`. This could be used to bind events such `Glitcher.tween.Completed` which is an event for `TweenBase`.

---

**Current styles are:**
* `Suffix`: Where the text typewrites itself with an optional character at the end
Pass in the `Suffix` index as string in the information when creating the glitcher.

* `IndexUpdate`: The current index character will be the on which will ONLY have a weird character. Example: TEST (Index 2) -> T\*ST (depending on the randomized character selected)
