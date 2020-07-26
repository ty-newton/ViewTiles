//
//  Tiles.swift
//  ViewTiles
//
//  Created by Ty on 30/5/20.
//  Copyright © 2020 Ty. All rights reserved.
//

import Foundation
import SwiftUI


// ***********************************
// WARNING: purple and plum are easily confused when looking at the physical tiles
// ***********************************

enum PatternShape {
    case none
    case circle_circleCut
    case square_circleCut
    case square_straightCut
    case scallop
    case cross_circlePoint
    case cross_pointyPoint
    case circle
    case circle_circleCorner
    case square_squareCorner
    case square
    case star6
    case diamond
    case plus
    case star4
}

typealias Pattern = (colour: Color, shape: PatternShape)

// Inner, Center and Outer patterns
let none: Pattern = (colour: .black, shape: .none)

// Outer patterns:
let grey: Pattern = (colour: .darkGray, shape: .none)       // t1-bottom
let orange: Pattern = (colour: .orange, shape: .none)       // t1-top
let pink: Pattern = (colour: .pink, shape: .none)           // t1-right
let green: Pattern = (colour: .darkGreen, shape: .none)     // t2-right
let darkBlue: Pattern = (colour: .darkBlue, shape: .none)   // t3-top
let lightBlue: Pattern = (colour: .lightBlue, shape: .none) // t10-top
let purple: Pattern = (colour: .purple, shape: .none)       // t6-top
let maroon: Pattern = (colour: .maroon, shape: .none)       // t8-right
let yellow: Pattern = (colour: .yellow, shape: .none)       // t11-top
let plum: Pattern = (colour: .plum, shape: .none)           // t18-top

// Center patterns:
let lightBlue_circle_circleCut: Pattern = (colour: .lightBlue, shape: .circle_circleCut)      // t1-top
let lightBlue_square_circleCut: Pattern = (colour: .lightBlue, shape: .square_circleCut)      // t1-right
let darkBlue_square_straightCut: Pattern = (colour: .darkBlue, shape: .square_straightCut)    // t2-right - octagon
let yellow_scallop: Pattern = (colour: .yellow, shape: .scallop)                              // t3-top
let yellow_cross_circlePoint: Pattern = (colour: .yellow, shape: .cross_circlePoint)          // t5-top
let lightBlue_cross_pointyPoint: Pattern = (colour: .lightBlue, shape: .cross_pointyPoint)    // t6-top
let yellow_circle: Pattern = (colour: .yellow, shape: .circle)                                // t7-top
let orange_circle_circleCorner: Pattern = (colour: .orange, shape: .circle_circleCorner)      // t8-right
let orange_cross_pointyPoint: Pattern = (colour: .orange, shape: .cross_pointyPoint)          // t9-top
let pink_square_squareCorner: Pattern = (colour: .pink, shape: .square_squareCorner)            // t10-top
let green_square: Pattern = (colour: .darkGreen, shape: .square)                              // t11-top
let orange_cross_circlePoint: Pattern = (colour: .orange, shape: .cross_circlePoint)          // t12-top
let yellow_square_squareCorner: Pattern = (colour: .yellow, shape: .square_squareCorner)        // t14-top
let lightBlue_star6: Pattern = (colour: .lightBlue, shape: .star6)                            // t16-top
let pink_cross_circlePoint: Pattern = (colour: .pink, shape: .cross_circlePoint)              // t17-top
let yellow_star6: Pattern = (colour: .yellow, shape: .star6)                                  // t18-top
let pink_cross_pointyPoint: Pattern = (colour: .pink, shape: .cross_pointyPoint)              // t21-top
let darkBlue_square_squareCorner: Pattern = (colour: .darkBlue, shape: .square_squareCorner)    // t22-top
let purple_star6: Pattern = (colour: .purple, shape: .star6)                                  // t24-top
let lightBlue_square: Pattern = (colour: .lightBlue, shape: .square)                          // t35-top
let pink_circle: Pattern = (colour: .pink, shape: .circle)                                    // t36-top
let green_circle: Pattern = (colour: .darkGreen, shape: .circle)                              // t38-top

// Inner patterns:
let pink_diamond: Pattern = (colour: .pink, shape: .diamond)        // t1-right
//let green_circle: Pattern = (colour: .darkGreen, shape: .circle)    // t2-right
let darkBlue_circle: Pattern = (colour: .darkBlue, shape: .circle)  // t3-top
let purple_plus: Pattern = (colour: .purple, shape: .plus)          // t7-top
let maroon_star4: Pattern = (colour: .maroon, shape: .star4)        // t8-right
let yellow_square: Pattern = (colour: .yellow, shape: .square)      // t11-top
let darkBlue_square: Pattern = (colour: .darkBlue, shape: .square)  // t35-top
let darkBlue_plus: Pattern = (colour: .darkBlue, shape: .plus)      // t36-top
let plum_plus: Pattern = (colour: .plum, shape: .plus)              // t38-top

// the design that a side has
typealias Design = (inner: Pattern, center: Pattern, outer: Pattern)

// the side that contributes to a square
typealias Side = (identifier: UInt8, design: Design)

// a square tile
typealias Square = (identifier: UInt8, top: Side, right: Side, bottom: Side, left: Side)

// the clockwise rotation of a Square; 0 is oriented so the number on the back is readable when flipped from the left/right side.
enum Rotation : UInt8 {
    case _0 = 0
    case _90
    case _180
    case _270
}

// a square tile that rotates
typealias RotatingSquare = (orientation: Rotation, square: Square)

// all the outer edge tiles
let Tiles : [RotatingSquare] = [
    (orientation: Rotation._0,
        square: (identifier: 1,
                 top: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 0, design: (inner: none, center: none, outer: grey))
    )),
    (orientation: Rotation._0,
        square: (identifier: 2,
                 top: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 0, design: (inner: none, center: none, outer: grey))
    )),
    (orientation: Rotation._0,
        square: (identifier: 3,
                 top: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 0, design: (inner: none, center: none, outer: grey))
    )),
    (orientation: Rotation._0,
        square: (identifier: 4,
                 top: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 0, design: (inner: none, center: none, outer: grey))
    )),
    (orientation: Rotation._0,
        square: (identifier: 5,
                 top: (identifier: 5, design: (inner: none, center: yellow_cross_circlePoint, outer: pink)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange))
    )),
    (orientation: Rotation._0,
        square: (identifier: 6,
                 top: (identifier: 6, design: (inner: none, center: lightBlue_cross_pointyPoint, outer: purple)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange))
    )),
    (orientation: Rotation._0,
        square: (identifier: 7,
                 top: (identifier: 7, design: (inner: purple_plus, center: yellow_circle, outer: purple)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange))
    )),
    (orientation: Rotation._0,
        square: (identifier: 8,
                 top: (identifier: 7, design: (inner: purple_plus, center: yellow_circle, outer: purple)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange))
    )),
    (orientation: Rotation._0,
        square: (identifier: 9,
                 top: (identifier: 9, design: (inner: none, center: orange_cross_pointyPoint, outer: green)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange))
    )),
    (orientation: Rotation._0,
        square: (identifier: 10,
                 top: (identifier: 10, design: (inner: none, center: pink_square_squareCorner, outer: lightBlue)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange))
    )),
    (orientation: Rotation._0,
        square: (identifier: 11,
                 top: (identifier: 11, design: (inner: yellow_square, center: green_square, outer: yellow)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange))
    )),
    (orientation: Rotation._0,
        square: (identifier: 12,
                 top: (identifier: 12, design: (inner: none, center: orange_cross_circlePoint, outer: darkBlue)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange))
    )),
    (orientation: Rotation._0,
        square: (identifier: 13,
                 top: (identifier: 12, design: (inner: none, center: orange_cross_circlePoint, outer: darkBlue)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange))
    )),
    (orientation: Rotation._0,
        square: (identifier: 14,
                 top: (identifier: 13, design: (inner: none, center: yellow_square_squareCorner, outer: pink)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange))
    )),
    (orientation: Rotation._0,
        square: (identifier: 15,
                 top: (identifier: 6, design: (inner: none, center: lightBlue_cross_pointyPoint, outer: purple)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 16,
                 top: (identifier: 1, design: (inner: none, center: lightBlue_star6, outer: yellow)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 17,
                 top: (identifier: 1, design: (inner: none, center: pink_cross_circlePoint, outer: green)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 18,
                 top: (identifier: 14, design: (inner: none, center: yellow_star6, outer: plum)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 19,
                 top: (identifier: 10, design: (inner: none, center: pink_square_squareCorner, outer: lightBlue)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 20,
                 top: (identifier: 11, design: (inner: yellow_square, center: green_square, outer: yellow)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 21,
                 top: (identifier: 15, design: (inner: none, center: pink_cross_pointyPoint, outer: lightBlue)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 22,
                 top: (identifier: 16, design: (inner: none, center: darkBlue_square_squareCorner, outer: yellow)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 23,
                 top: (identifier: 16, design: (inner: none, center: darkBlue_square_squareCorner, outer: yellow)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 24,
                 top: (identifier: 17, design: (inner: none, center: purple_star6, outer: orange)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 25,
                 top: (identifier: 13, design: (inner: none, center: yellow_square_squareCorner, outer: pink)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue))
    )),
    (orientation: Rotation._0,
        square: (identifier: 26,
                 top: (identifier: 5, design: (inner: none, center: yellow_cross_circlePoint, outer: pink)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 27,
                 top: (identifier: 5, design: (inner: none, center: yellow_cross_circlePoint, outer: pink)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 28,
                 top: (identifier: 6, design: (inner: none, center: lightBlue_cross_pointyPoint, outer: purple)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 29,
                 top: (identifier: 1, design: (inner: none, center: lightBlue_star6, outer: yellow)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 30,
                 top: (identifier: 10, design: (inner: none, center: pink_square_squareCorner, outer: lightBlue)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 31,
                 top: (identifier: 11, design: (inner: yellow_square, center: green_square, outer: yellow)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 32,
                 top: (identifier: 17, design: (inner: none, center: purple_star6, outer: orange)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 33,
                 top: (identifier: 12, design: (inner: none, center: orange_cross_circlePoint, outer: darkBlue)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 34,
                 top: (identifier: 12, design: (inner: none, center: orange_cross_circlePoint, outer: darkBlue)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 35,
                 top: (identifier: 18, design: (inner: darkBlue_square, center: lightBlue_square, outer: darkBlue)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 36,
                 top: (identifier: 19, design: (inner: darkBlue_plus, center: pink_circle, outer: darkBlue)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink))
    )),
    (orientation: Rotation._0,
        square: (identifier: 37,
                 top: (identifier: 1, design: (inner: none, center: lightBlue_star6, outer: yellow)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 38,
                 top: (identifier: 20, design: (inner: plum_plus, center: green_circle, outer: plum)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 39,
                 top: (identifier: 9, design: (inner: none, center: orange_cross_pointyPoint, outer: green)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 40,
                 top: (identifier: 14, design: (inner: none, center: yellow_star6, outer: plum)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 41,
                 top: (identifier: 14, design: (inner: none, center: yellow_star6, outer: plum)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 42,
                 top: (identifier: 11, design: (inner: yellow_square, center: green_square, outer: yellow)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 43,
                 top: (identifier: 11, design: (inner: yellow_square, center: green_square, outer: yellow)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 44,
                 top: (identifier: 11, design: (inner: yellow_square, center: green_square, outer: yellow)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 45,
                 top: (identifier: 15, design: (inner: none, center: pink_cross_pointyPoint, outer: lightBlue)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 46,
                 top: (identifier: 17, design: (inner: none, center: purple_star6, outer: orange)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 47,
                 top: (identifier: 12, design: (inner: none, center: orange_cross_circlePoint, outer: darkBlue)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 48,
                 top: (identifier: 18, design: (inner: darkBlue_square, center: lightBlue_square, outer: darkBlue)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green))
    )),
    (orientation: Rotation._0,
        square: (identifier: 49,
                 top: (identifier: 5, design: (inner: none, center: yellow_cross_circlePoint, outer: pink)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 50,
                 top: (identifier: 6, design: (inner: none, center: lightBlue_cross_pointyPoint, outer: purple)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 51,
                 top: (identifier: 6, design: (inner: none, center: lightBlue_cross_pointyPoint, outer: purple)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 52,
                 top: (identifier: 7, design: (inner: purple_plus, center: yellow_circle, outer: purple)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 53,
                 top: (identifier: 10, design: (inner: none, center: pink_square_squareCorner, outer: lightBlue)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 54,
                 top: (identifier: 15, design: (inner: none, center: pink_cross_pointyPoint, outer: lightBlue)),
                 right: (identifier: 3, design: (inner: green_circle, center: darkBlue_square_straightCut, outer: green)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 55,
                 top: (identifier: 15, design: (inner: none, center: pink_cross_pointyPoint, outer: lightBlue)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 56,
                 top: (identifier: 12, design: (inner: none, center: orange_cross_circlePoint, outer: darkBlue)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 57,
                 top: (identifier: 18, design: (inner: darkBlue_square, center: lightBlue_square, outer: darkBlue)),
                 right: (identifier: 1, design: (inner: none, center: lightBlue_circle_circleCut, outer: orange)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 58,
                 top: (identifier: 18, design: (inner: darkBlue_square, center: lightBlue_square, outer: darkBlue)),
                 right: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 59,
                 top: (identifier: 13, design: (inner: none, center: yellow_square_squareCorner, outer: pink)),
                 right: (identifier: 4, design: (inner: darkBlue_circle, center: yellow_scallop, outer: darkBlue)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    )),
    (orientation: Rotation._0,
        square: (identifier: 60,
                 top: (identifier: 19, design: (inner: darkBlue_plus, center: pink_circle, outer: darkBlue)),
                 right: (identifier: 2, design: (inner: pink_diamond, center: lightBlue_square_circleCut, outer: pink)),
                 bottom: (identifier: 0, design: (inner: none, center: none, outer: grey)),
                 left: (identifier: 8, design: (inner: maroon_star4, center: orange_circle_circleCorner, outer: maroon))
    ))
]


/*
 (orientation: Rotation._0,
     square: (identifier: 5,
              top: (identifier: 2, design: (inner: , center: , outer: )),
              right: (identifier: 1, design: (inner: , center: , outer: )),
              bottom: (identifier: 1, design: (inner: , center: , outer: )),
              left: (identifier: 1, design: (inner: , center: , outer: ))
 ))
 */

/*
 highest side identifier = 20
 
 the brown and pinkish brown colous are both recorded as maroon
 
 To test the data:
 1. ensure that the identifiers are the same value for the same design
 2. ...
 */

/*
 I want to draw the tiles on the screen so I can double check that the data is correct
 
 I want to find all the combinations of tiles for a length of 14 where neighbouring tiles are the same pattern
 */
