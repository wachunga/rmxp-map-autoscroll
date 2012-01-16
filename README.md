Map Autoscroll (v 1.02)
===

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


Usage
---
Instead of a "Scroll Map" event command, use the "Call Script" command and enter on the following on the first line:

    autoscroll(x,y)

(replacing `x` and `y` with the x and y coordinates of the tile to scroll to)

To specify a scroll speed other than the default (4), use:

    autoscroll(x,y,speed)

(now also replacing `speed` with the scroll speed from 1-6)

Diagonal scrolling happens automatically when the destination is diagonal relative to the starting point (i.e., not directly up, down, left or right).

To scroll to the player, instead use the following:

    autoscroll_player(speed)

Note: because of how the interpreter and the "Call Script" event command are setup, the call to `autoscroll(...)` can only be on the first line of the "Call Script" event command (and not flowing down to subsequent lines).

For example, the following call may not work as expected:

    autoscroll($game_variables[1],
    $game_variables[2])

(since the long argument names require dropping down to a second line)

A work-around is to setup new variables with shorter names in a preceding (separate) "Call Script" event command:

    @x = $game_variables[1]
    @y = $game_variables[2]

and then use those as arguments:

    autoscroll(@x,@y)

The renaming must be in a separate "Call Script" because otherwise the call to autoscroll(...) isn't on the first line.
