# ViewTiles
Viewer for the tiles in the Eternity 2 puzzle

Includes 60 tiles that make up the outer edge of the puzzle.

I am learning SwiftUI at the same time as writing this so the code is pretty messy.

# Code organisation
Some of the code is borrowed from another project I am writing that is exploring the Eternity 2 puzzle structure.

Tiles.swift
Tiles are defined in code as constants.  Tiles is an array of RotatingSquare.  RotatingSquare represents a Square (game piece) and its Orientation.  Orientation is useful to my other project but not really helpful for ViewTiles.  Square is made up of the number (on the back of the game piece) and the 4 sides (oriented so the number on the back can be read if it is flipped over by its left/right side).  Side is composed of an identifier (unique for the design) and a Design.  Design represents the art that has to match for the puzzle to be solved.

Design consists of 3 Patterns: outer, center and inner.  The outer Pattern is the background colour of the design.  The center Pattern is the large graphic portion and the inner Pattern is the small central graphic.  Some Sides do not have some of the patterns; mostly missign the inner Pattern.  This is represented explicitly with the Pattern type "none".

Pattern uses a few enumerations to define the shapes and colours.  This can be a little strange to read since it uses my vernacular.

Color.swift
The SwiftUI Color object doesn't have very many colours to choose from.  Color.swift extends Color to add the ones needed to display the pieces.

View.swift
SwiftUI doesn't seem to have a good way for a View to hide itself.  View.swift extends View to add an isHidden method so the code in ContentView.swift is a little easier to create.

ContentView.swift
This is where the display happens.  I have had some trouble with XCode prieviws not wanting to work with it but it works with an old fashioned build and run.

The code shows a scrollable list of Tile with each row showing the piece number and piece graphic.  This is done by compositing views.  A Tile represents the game piece and is made up from 4 Quads.  A Quad represents the design on one of the sides of a Tile and is made up of Outer, Middle and Inner patterns.  Each of these patterns is created in their own View.

Since there doesn't seem to be a way to use branching code within the body of a View and there doesn't seem to be a way to return a View from a function I use the isHidden() code to make patterns that don't belong to a Tile remove themselves.  It's a very odd way to have to do this and makes me think that I will learn something in SwiftUI in the future that will show me the proper way to think about solving this problem.
