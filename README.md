# Unnamed raycast fps

## Goal

Making a playable raycasted game using HTML/JavaScript api only.

HTML/JS is really great for this project because it offers various things in an easy way:
  * Pixels manipulation through canvas/ImageData
  * Input handling through `onXXXXXX` events
  * Easy debugging in any browser

I will use the `Haxe` language on top of that, basically to have a statically typed HTML/JS API.

## Dev blog

### Start

I decided to continue on my raycasted game from the @js1024fun jam.

First steps:
 * Support wide ratio
 * Keyboard controls
 * Cleaner code (original was aimed to be minimal)

![start](https://github.com/gogoprog/raycastfps/raw/master/res/rfps-start.png)

### Floor

First acceptable floor rendering : I could not figure it out by myself so I read stuff about `mode7` and `rotozoomer` to achieve this.

In the end I have a simple implementation supporting only 1 floor. That will be enough for now.

![floor](https://github.com/gogoprog/raycastfps/raw/master/res/rfps-floor.gif)

### First sprite

First step on sprite rendering :
  * (almost) correctly positionned in "3D"
  * Correct size depending on the distance

The maths were pretty easy :
  * Get angle from camera, check if it is inside the field-of-view to render it
  * Compute distance and use it to alter the rendering size
  * Use angle divided by Fov to know the exact location on the screen : this works but I do it in a linear way which is not fully correct


![sprite](https://github.com/gogoprog/raycastfps/raw/master/res/rfps-sprite.gif)

### Sprite again

Continuing on sprite rendering :
  * Snap to the ground
  * Support depth (hidden by walls)
  * Support transparency (just skipping transparent pixels)

For the depth I just keep the wall distance from camera for every column, assuming the sprites will always be smaller than the walls. Then I do a simple comparison when rendering the sprite columns.

![sprite2](https://github.com/gogoprog/raycastfps/raw/master/res/rfps-sprite2.gif)


### Sprite rotations and ECS

Adding useful stuff for the future:
  * ECS architecture
  * Sprite System with rotation handling
  * Sorted sprite rendering

I introduced ECS to have a Sprite system which will take care of animations and rotations. This system is feeding the renderer with sprites, and now the renderer sorts the sprites.

![rotations](https://github.com/gogoprog/raycastfps/raw/master/res/rfps-rotations.gif)

### It is getting alive!

  * Definitions loader : basically helpers to load the json data files.
  * SpriteAnimationSystem : updates the Sprite component to display the correct animation frame.
  * Sky rendering

The code is getting cleaner and is ready to be completely data-driven. I also updated the textures to make it look better.

![life](https://github.com/gogoprog/raycastfps/raw/master/res/rfps-life.gif)

### First interaction : Killing of course

  * Display quads in screenspace for Hud.
  * HudSystem displaying and animating the weapon depending on the speed.
  * Bullet and collision detection.
  * Life components and death animation.

Finally we can shoot these ugly monsters!

![kill](https://github.com/gogoprog/raycastfps/raw/master/res/rfps-kill.gif)

## Credits

  * Monster: https://opengameart.org/content/monster-for-3d-shooter-sprite (Pawel "Nmn" Zarczynski)
  * Shotgun: https://forum.zdoom.org/viewtopic.php?f=37&t=67971 (Sgt. Shivers, Skelegant, Wartorn)
  * Floor: https://opengameart.org/content/grey-stone-wall-256px (Tiziana)
  * Wall: https://opengameart.org/content/dusty-exterior-wall-01 (Sindwiller)
  * Sky: https://www.doomworld.com/forum/topic/93966-post-your-sky-textures/ (Fuzzball)

