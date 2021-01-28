# File preparation, this is not ready yet. Writing documentation as development goes

# Text-Glitcher-Lua


## Options

| Option name | Description | Default value | Type |
| ----------- | ----------- | ------------- | ---- |
| Reversed | Wether the style should play in reverse (Example: Linear; from last to first). | false | Boolean
| Randomized | Should the characters be randomized on every change (Example: ). | true | Boolean
| Style | The style which the text should glitch. | Linear | String
| SingleThreaded | Should it be ran on a single thread? More threads means quicker glitching. | false | Boolean
| Yield | Should it Yield while you are running it. | true | Boolean
| lapse | The amount of time per glitching | 0.1 | Number
| SingleHash | Should it only create one glitched text for the whole glitching? | false | Boolean
| IndexLoop | Gives it more of a longer glitching time. | false | Boolean



## Styles

| Style | Description | Extra |
| ----- | ----------- | ----- |
| Linear | Glitches by order from first to last.
| Randomized | Glitch with a random order within the string. | Best to run on multiple threads for better results
| Exponential | Not out yet, in progress...

