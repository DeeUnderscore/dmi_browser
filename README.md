# dmi_browser

**dmi_browser** is a DMI viewer in your browser.

`.dmi` files are used by the [BYOND](https://www.byond.com/) platform to store sprites. They are PNG files with extra metadata in a zTXt chunk. That metadata allows the BYOND platform to properly slice the PNG sprite sheet, and to arrange the individual frames into animations. dmi_browser displays individual frames of the sprite sheet, and animates the sprites marked for animations.

## Try it
You can reach dmi_browser at the following address:

https://deeunderscore.github.io/dmi

If you would like some sample dmi files, you can check out [Baystation 12's icon files](https://github.com/Baystation12/Baystation12/tree/dev/icons). Baystation12 is an open source game for the BYOND platform.

## Implementation
dmi_browser is an Angular2 single page application written in the Dart programming language. It is entirely client side, and aims to work in modern browsers.

Processing of DMIs is done by the [dmi_read](https://github.com/DeeUnderscore/dmi_read) library.

## Project
dmi_browser is free software licensed under the ISC license. For more details, see <LICENSE.md>.

The project is on Github at [DeeUnderscore/dmi_browser](https://github.com/DeeUnderscore/dmi_browser).
