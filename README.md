# Simple Tooltip for Game Maker Studio 2 v2022+

## What is MekoTooltip

A highly performant library to easily create customizable tooltips with dynamic width and height.

## Usage

In the repository there is a single script called `MekoTooltip` which contains everything you need.

When you copy this script into your project, you will be able to call some newly created functions.

`var tooltip = MekoTooltip([texture, options])` - This is the initializer function of a tooltip. It accepts two optional parameters; the `texture` is a sprite, which should have nineslice enabled and the second one is the `options` which is a struct. After calling this function it returns with a struct of the created tooltip.

Available options are:
- `font`: the font used by the tooltip, it can also be a sprite font like in the example. Defaults to `-1`.
- `padding`: space around the text content. Defaults to `8`.
- `maxWidth`: maximum width of the tooltip including nineslice bounds and padding. Defaults to `-1`.

## Tooltip functions

There are multiple functions available on the returned tooltip struct.

`tooltip.add_content(text, [options])` - You can populate the tooltip by calling this function. It accepts 2 parameters; `text` is a string with the content you want to see in the tooltip and `options` is a struct with the following options:
- `color`: Defines the color of the text. Defaults to `c_white`.
- `margin`: Defines the space after the content. Defaults to `4`.

`tooltip.clear_content()` - Removes every content added before with `tooltip.add_content()`.

`tooltip.show(x, y)` - Shows the tooltip at the given `x` and `y` coordinate.

`tooltip.hide()` - Hides the tooltip but doesn't destroys it, so it can show again.

`tooltip.destroy()` - Destroys the tooltip, which means closing it and removing it from the `MekoTooltip_tooltips` global variable.

`tooltip.get_dimensions()` - Returns a struct with `width` and `height` properties. It's useful when you want to know the size of the tooltip before rendering it.

## Helpers

`MekoTooltip_tooltips` - A global variable contains all the tooltips created.

`MekoTooltip_needRender` - A global variable which is true if tooltips have to be re-rendered.

`MekoTooltip_hasVisible` - A global variable which is true when it has at least one visible tooltip.

`MekoTooltip_hasVisible` - A global variable which is true when it has at least one visible tooltip.

`MekoTooltip_defaults` - A global variable contains default options.

`MekoTooltip_set_defaults(options)` - With this function you can set default values which can be used by all the tooltips without defining them on creation. The options is the same what you pass to the `MekoTooltip()` function.

`MekoTooltip_render()` - This function does the drawing for you, so you will probably put this function call into a draw or drawGUI event. In this sample, it draws everything on a surface.
