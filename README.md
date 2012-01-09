Map Autoscroll (v 1.02)
===

A script for [RPG Maker XP](http://en.wikipedia.org/wiki/RPG_Maker_XP), which uses Ruby. Written years ago and posted on some now-defunct forums, but may still be useful to folks.

This script supplements the built-in "Scroll Map" event command with the aim of simplifying cutscenes (and map scrolling in general). Whereas the normal event command requires a direction and number of tiles to scroll, Map Autoscroll scrolls the map to center on the tile whose x and y coordinates are given, even scrolling diagonally when appropriate, which is not possible otherwise.

Features
---
* automatic map scrolling to given x,y coordinate (or player)
* diagonal scrolling supported
* destination is fixed, so it's possible to scroll to same place even if the origin is variable (e.g. moving NPC)
* variable speed (just like "Scroll Map" event command)
* SDK compatible

Demo
---
See `demo` directory. Requires RMXP, of course.

Installation
---
Copy the script in `src`, and open the Script Editor within RMXP. At the bottom of the list of classes on the left side of the new window, you'll see one called "Main". Right click on it and select "Insert". In the newly created entry in the list, paste this script.

Note that this script uses the [SDK](http://www.hbgames.org/forums/viewtopic.php?t=1802.0), which must be above this script. When it was developed, SDK 1.5 was the latest version.

To avoid this dependency, remove or comment out the "SDK Log Script" and "SDK Enabled Check" (also at the end of the script).
