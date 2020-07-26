//
//  ContentView.swift
//  ViewTiles
//
//  Created by ty on 26/7/20.
//  Copyright © 2020 Gurukarma. All rights reserved.
//

import SwiftUI

protocol MiddleView {
    var colour: Color { get set }
    var outerColour: Color { get set }
    static var isMatched: (Pattern) -> Bool { get }
}

// **********************************************************************************************************
// SHAPE
// **********************************************************************************************************

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        var path: Path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // middle top
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY)) // right middle
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY)) // middle bottom
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY)) // left middle
        path.closeSubpath() // top middle
        
        return path
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path: Path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // middle top
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // right bottom
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // left bottom
        path.closeSubpath() // back to start
        return path
    }
}

// https://www.hackingwithswift.com/quick-start/swiftui/how-to-draw-polygons-and-stars
struct Star: Shape {
    // store how many corners the star has, and how smooth/pointed it is
    let corners: Int
    let smoothness: CGFloat // 0.1 is almost no depth, 0.9 is almost at the center

    func path(in rect: CGRect) -> Path {
        guard corners >= 2 else { return Path() } // ensure we have at least two corners, otherwise send back an empty path

        let center = CGPoint(x: rect.width / 2, y: rect.height / 2) // draw from the center of our rectangle
        var currentAngle = -CGFloat.pi / 2 // start from directly upwards (as opposed to down or to the right)
        let angleAdjustment = .pi * 2 / CGFloat(corners * 2) // calculate how much we need to move with each star corner

        // figure out how much we need to move X/Y for the inner points of the star
        let innerX = center.x * smoothness
        let innerY = center.y * smoothness

        var path = Path() // we're ready to start with our path now
        path.move(to: CGPoint(x: center.x * cos(currentAngle), y: center.y * sin(currentAngle))) // move to our initial position
        var bottomEdge: CGFloat = 0 // track the lowest point we draw to, so we can center later

        for corner in 0..<corners * 2  { // loop over all our points/inner points
            // figure out the location of this point
            let sinAngle = sin(currentAngle)
            let cosAngle = cos(currentAngle)
            let bottom: CGFloat

            if corner.isMultiple(of: 2) { // if we're a multiple of 2 we are drawing the outer edge of the star
                bottom = center.y * sinAngle // store this Y position
                path.addLine(to: CGPoint(x: center.x * cosAngle, y: bottom)) // …and add a line to there
            } else { // we're not a multiple of 2, which means we're drawing an inner point
                bottom = innerY * sinAngle // store this Y position
                path.addLine(to: CGPoint(x: innerX * cosAngle, y: bottom)) // …and add a line to there
            }

            if bottom > bottomEdge { bottomEdge = bottom }// if this new bottom point is our lowest, stash it away for later
            currentAngle += angleAdjustment // move on to the next corner
        }
        let unusedSpace = (rect.height / 2 - bottomEdge) / 2 // figure out how much unused space we have at the bottom of our drawing rectangle
        let transform = CGAffineTransform(translationX: center.x, y: center.y + unusedSpace) // create and apply a transform that moves our path down by that amount, centering the shape vertically
        
        return path.applying(transform)
    }
}

// **********************************************************************************************************
// MIDDLE
// **********************************************************************************************************

// defaults to light blue colour with orange outer colour
// assumes the view dimensions are square
// assumes the view is the correct dimensions
struct Middle_CircleCircleCut: View, MiddleView {
    var colour: Color = Color.lightBlue
    var outerColour: Color = Color.orange
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.circle_circleCut ? true : false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // big circle
                Circle()
                    .fill(self.colour)
                
                // obscure with smaller circles
                // colour the same as the Outer colour
                Circle() // top middle
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    .position(x: geometry.size.width / 2, y: 0)
                Circle() // bottom middle
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    .position(x: geometry.size.width / 2, y: geometry.size.height)
                Circle() // middle right
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    .position(x: geometry.size.width, y: geometry.size.height / 2)
                Circle() // middle left
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    .position(x: 0, y: geometry.size.height / 2)
            }.clipShape(Circle())
        }
    }
}

// defaults to light blue colour with pink outer colour
// assumes the view dimensions are square
// assumes the view is the correct dimensions
struct Middle_SquareCircleCut: View, MiddleView {
    var colour: Color = Color.lightBlue
    var outerColour: Color = Color.pink

    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.square_circleCut ? true : false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // big square
                Rectangle()
                    .fill(self.colour)
                
                // obscure with small circles
                // colour the same as the Outer colour
                Circle() // top left
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.7)
                    .position(x: 0, y: 0)
                Circle() // top right
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.7)
                    .position(x: geometry.size.width, y: 0)
                Circle() // bottom left
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.7)
                    .position(x: 0, y: geometry.size.height)
                Circle() // bottomright
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width * 0.7, height: geometry.size.height * 0.7)
                    .position(x: geometry.size.width, y: geometry.size.height)
                }.rotationEffect(.degrees(45.0)).clipShape(Rectangle())
        }
    }
}

// defaults to light blue colour with pink outer colour
// assumes the view dimensions are square
// assumes the view is the correct dimensions
struct Middle_Octagon: View, MiddleView {
    var colour: Color = Color.darkBlue
    var outerColour: Color = Color.darkGreen
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.square_straightCut ? true : false
    }
    
    var body: some View {
        Rectangle()
            .fill(self.colour)
            .rotationEffect(.degrees(45.0))
            .clipShape(Rectangle())
    }
}

struct Middle_Scallop: View, MiddleView {
    var colour: Color = Color.yellow
    var outerColour: Color = Color.black // not used, kept to conform to MiddleView
    let scallopSize: CGFloat = 0.55 // % of the view edge length

    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.scallop ? true : false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 4 circles, each at the corners, inset by the radius
                // radius is half the edge length
                Circle() // top left
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.scallopSize, height: geometry.size.height * self.scallopSize)
                    .position(x: geometry.size.width * self.scallopSize / 2, y: geometry.size.height * self.scallopSize / 2)
                Circle() // top right
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.scallopSize, height: geometry.size.height * self.scallopSize)
                    .position(x: geometry.size.width - (geometry.size.width * self.scallopSize / 2), y: geometry.size.height * self.scallopSize / 2)
                Circle() // bottom right
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.scallopSize, height: geometry.size.height * self.scallopSize)
                    .position(x: geometry.size.width - (geometry.size.width * self.scallopSize / 2), y: geometry.size.height - (geometry.size.height * self.scallopSize / 2))
                Circle() // bottom left
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.scallopSize, height: geometry.size.height * self.scallopSize)
                    .position(x: geometry.size.width * self.scallopSize / 2, y: geometry.size.height - (geometry.size.height * self.scallopSize / 2))
            }.scaleEffect(0.95)
        }
    }
}

// yellow_cross_circlePoint
struct Middle_CrossCirclePoint: View, MiddleView {
    var colour: Color = Color.yellow
    var outerColour: Color = Color.black // not used, kept to conform to MiddleView
    let pointSize: CGFloat = 0.30 // % of the view edge length
    let shaftWidth: CGFloat = 0.18 // % of the view edge length
    let shaftLength: CGFloat = 0.70 // % of the view edge length

    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.cross_circlePoint ? true : false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // 2 crossed rectangles or 1 large rectangle for 4 smaller rectangles on top
                Rectangle()
                    .fill(self.colour)
                    .scaleEffect(CGSize(width: self.shaftWidth, height: self.shaftLength))
                Rectangle()
                    .fill(self.colour)
                    .scaleEffect(CGSize(width: self.shaftWidth, height: self.shaftLength))
                    .rotationEffect(.degrees(90))
                
                // 4 circles, at center of each side
                Circle() // top middle
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.pointSize, height: geometry.size.height * self.pointSize)
                    .position(x: geometry.size.width / 2, y: 0 + (geometry.size.height * self.pointSize / 2))
                Circle() // bottom middle
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.pointSize, height: geometry.size.height * self.pointSize)
                    .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height * self.pointSize / 2))
                Circle() // middle right
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.pointSize, height: geometry.size.height * self.pointSize)
                    .position(x: geometry.size.width - (geometry.size.width * self.pointSize / 2), y: geometry.size.height / 2)
                Circle() // middle left
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.pointSize, height: geometry.size.height * self.pointSize)
                    .position(x: 0 + (geometry.size.width * self.pointSize / 2), y: geometry.size.height / 2)
            }.scaleEffect(1.1)
            .rotationEffect(.degrees(45))
        }
    }
}

struct _Middle_CrossPointyPoint: View {
    var colour: Color = Color.lightBlue
    var outerColour: Color = Color.purple
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // large rectangle
                Rectangle()
                    .fill(self.colour)
                
                // 4 triangles at the center of each edge
                Triangle() // middle bottom
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width * 0.33, height: geometry.size.height * 0.5) // 1/3 width, 1/2 height
                    .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height * 0.5 / 2))
                Triangle() // left middle
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width * 0.33, height: geometry.size.height * 0.5) // 1/3 width, 1/5 height
                    .position(x: geometry.size.width / 2, y: geometry.size.height - ((geometry.size.height * 0.5) / 2))
                    .rotationEffect(.degrees(90))
                Triangle() // middle top
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width * 0.33, height: geometry.size.height * 0.5) // 1/3 width, 1/5 height
                    .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height * 0.5) / 2)
                    .rotationEffect(.degrees(180))
                Triangle() // right middle
                    .fill(self.outerColour)
                    .frame(width: geometry.size.width * 0.33, height: geometry.size.height * 0.5) // 1/3 width, 1/5 height
                    .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height * 0.5) / 2)
                    .rotationEffect(.degrees(270))
            }
        }
    }
}

// lightBlue_cross_pointyPoint
struct Middle_CrossPointyPoint: View, MiddleView {
    var colour: Color = Color.lightBlue
    var outerColour: Color = Color.purple
    let rectSize: CGFloat = 0.85 // % of the view edge length
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.cross_pointyPoint ? true : false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // large rectangle
                Rectangle()
                    .fill(self.outerColour)

                _Middle_CrossPointyPoint(colour: self.colour, outerColour: self.outerColour)
                    .scaleEffect(self.rectSize)
            }
        }
    }
}

// orange_circle_circleCorner
struct Middle_CircleCircleCorner: View, MiddleView {
    var colour: Color = Color.orange
    var outerColour: Color = Color.black // not used, kept to conform to MiddleView
    let cornerSize: CGFloat = 0.35 // % of the view edge length
    let centerSize: CGFloat = 0.9 // % of the view edge length

    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.circle_circleCorner ? true : false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // large center circle
                Circle()
                    .fill(self.colour)
                    .scaleEffect(self.centerSize)
                
                // 4 circles, each at the corners, inset by the radius
                // radius is half the edge length
                Circle() // top left
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.cornerSize, height: geometry.size.height * self.cornerSize)
                    .position(x: geometry.size.width * self.cornerSize / 2, y: geometry.size.height * self.cornerSize / 2)
                Circle() // top right
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.cornerSize, height: geometry.size.height * self.cornerSize)
                    .position(x: geometry.size.width - (geometry.size.width * self.cornerSize / 2), y: geometry.size.height * self.cornerSize / 2)
                Circle() // bottom right
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.cornerSize, height: geometry.size.height * self.cornerSize)
                    .position(x: geometry.size.width - (geometry.size.width * self.cornerSize / 2), y: geometry.size.height - (geometry.size.height * self.cornerSize / 2))
                Circle() // bottom left
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.cornerSize, height: geometry.size.height * self.cornerSize)
                    .position(x: geometry.size.width * self.cornerSize / 2, y: geometry.size.height - (geometry.size.height * self.cornerSize / 2))
            }
        }
    }
}

// yellow_circle
struct Middle_Circle: View, MiddleView {
    var colour: Color = Color.yellow
    var outerColour: Color = Color.black // not used, kept to conform to MiddleView
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.circle ? true : false
    }
    
    var body: some View {
        // large circle
        Circle()
            .fill(self.colour)
    }
}

// pink_square_squareCorner
struct Middle_SquareSquareCorner: View, MiddleView {
    var colour: Color = Color.orange
    var outerColour: Color = Color.black // not used, kept to conform to MiddleView
    let cornerSize: CGFloat = 0.30 // % of the view edge length
    let centerSize: CGFloat = 0.8 // % of the view edge length

    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.square_squareCorner ? true : false
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // large center circle
                Rectangle()
                    .fill(self.colour)
                    .scaleEffect(self.centerSize)
                
                // 4 circles, each at the corners, inset by the radius
                // radius is half the edge length
                Rectangle() // top left
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.cornerSize, height: geometry.size.height * self.cornerSize)
                    .position(x: geometry.size.width * self.cornerSize / 2, y: geometry.size.height * self.cornerSize / 2)
                Rectangle() // top right
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.cornerSize, height: geometry.size.height * self.cornerSize)
                    .position(x: geometry.size.width - (geometry.size.width * self.cornerSize / 2), y: geometry.size.height * self.cornerSize / 2)
                Rectangle() // bottom right
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.cornerSize, height: geometry.size.height * self.cornerSize)
                    .position(x: geometry.size.width - (geometry.size.width * self.cornerSize / 2), y: geometry.size.height - (geometry.size.height * self.cornerSize / 2))
                Rectangle() // bottom left
                    .fill(self.colour)
                    .frame(width: geometry.size.width * self.cornerSize, height: geometry.size.height * self.cornerSize)
                    .position(x: geometry.size.width * self.cornerSize / 2, y: geometry.size.height - (geometry.size.height * self.cornerSize / 2))
            }.scaleEffect(0.9)
        }
    }
}

// green_square
struct Middle_Square: View, MiddleView {
    var colour: Color = Color.darkGreen
    var outerColour: Color = Color.black // not used, kept to conform to MiddleView
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.square ? true : false
    }
    
    var body: some View {
        // large circle
        Rectangle()
            .fill(self.colour)
            .scaleEffect(0.9)
    }
}

// lightBlue_star6
struct Middle_Star6: View, MiddleView {
    var colour: Color = Color.lightBlue
    var outerColour: Color = Color.black // not used, kept to conform to MiddleView
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.star6 ? true : false
    }
    
    var body: some View {
        // large circle
        Star(corners: 6, smoothness: 0.5)
            .fill(self.colour)
            .rotationEffect(.degrees(-45))
    }
}

// **********************************************************************************************************
// INNER
// **********************************************************************************************************

struct Inner_Diamond: View {
    var colour: Color = Color.pink
    let diamondSize: CGFloat = 0.8 // % of the view edge length
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.diamond ? true : false
    }
    
    var body: some View {
        Rectangle()
            .fill(self.colour)
            .scaleEffect(self.diamondSize)
    }
}

struct Inner_Circle: View {
    var colour: Color = Color.darkGreen
    let squareSize: CGFloat = 0.9 // % of the view edge length
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.circle ? true : false
    }
    
    var body: some View {
        Circle()
            .fill(self.colour)
    }
}

// purple_plus
struct Inner_Plus: View {
    var colour: Color = Color.purple
    let shaftLength: CGFloat = 1.5 // % of the view edge length
    let shaftWidth: CGFloat = 0.5 // % of the view edge length
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.plus ? true : false
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(self.colour)
                .scaleEffect(CGSize(width: self.shaftWidth, height: self.shaftLength))
            Rectangle()
                .fill(self.colour)
                .scaleEffect(CGSize(width: self.shaftWidth, height: self.shaftLength))
                .rotationEffect(.degrees(90))
        }
    }
}

// maroon_star4
struct Inner_Star4: View {
    var colour: Color = Color.maroon
    var middleColour: Color = Color.orange
    let triangleHeight: CGFloat = 0.15 // % of the view edge length
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.star4 ? true : false
    }
    
    var body: some View {
        GeometryReader { geometry in
            // large rectangle
            Rectangle()
                .fill(self.colour)
            
            // low triangles on each edge; using middle colour
            Triangle()
                .fill(self.middleColour)
                .frame(width: geometry.size.width, height: geometry.size.height * self.triangleHeight)
                .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height * self.triangleHeight / 2))
            Triangle()
                .fill(self.middleColour)
                .frame(width: geometry.size.width, height: geometry.size.height * self.triangleHeight)
                .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height * self.triangleHeight / 2))
                .rotationEffect(.degrees(90))
            Triangle()
                .fill(self.middleColour)
                .frame(width: geometry.size.width, height: geometry.size.height * self.triangleHeight)
                .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height * self.triangleHeight / 2))
                .rotationEffect(.degrees(180))
            Triangle()
                .fill(self.middleColour)
                .frame(width: geometry.size.width, height: geometry.size.height * self.triangleHeight)
                .position(x: geometry.size.width / 2, y: geometry.size.height - (geometry.size.height * self.triangleHeight / 2))
                .rotationEffect(.degrees(270))
        }
    }
}

// yellow_square
struct Inner_Square: View {
    var colour: Color = Color.yellow
    
    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.square ? true : false
    }
    
    var body: some View {
        Rectangle()
            .fill(self.colour)
    }
}

// **********************************************************************************************************
// COMPOSITE
// **********************************************************************************************************

// a rectangle with colour from pattern, and a 2 wide black border
struct Outer: View {
    var borderWidth: CGFloat = 2
    var borderColour: Color = Color.black
    var pattern: Pattern


    var body: some View {
        ZStack {
            Rectangle()
                .fill(self.pattern.colour)
                .border(self.borderColour, width: self.borderWidth)
        }
    }
}

struct Middle: View {
    var pattern: Pattern
    var outerColour: Color

    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.none ? false : true
    }

    var body: some View {
        ZStack {
            Group { // max of 10 views allowed as children
                Middle_CircleCircleCut(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_CircleCircleCut.isMatched(self.pattern), remove: true)
                Middle_SquareCircleCut(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_SquareCircleCut.isMatched(self.pattern), remove: true)
                Middle_Octagon(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_Octagon.isMatched(self.pattern), remove: true)
                Middle_Scallop(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_Scallop.isMatched(self.pattern), remove: true)
                Middle_CrossCirclePoint(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_CrossCirclePoint.isMatched(self.pattern), remove: true)
                Middle_CrossPointyPoint(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_CrossPointyPoint.isMatched(self.pattern), remove: true)
                Middle_Circle(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_Circle.isMatched(self.pattern), remove: true)
                Middle_CircleCircleCorner(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_CircleCircleCorner.isMatched(self.pattern), remove: true)
                Middle_SquareSquareCorner(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_SquareSquareCorner.isMatched(self.pattern), remove: true)
                Middle_Square(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_Square.isMatched(self.pattern), remove: true)
            }
            Group {
                Middle_Star6(colour: self.pattern.colour, outerColour: self.outerColour)
                    .isHidden(!Middle_Star6.isMatched(self.pattern), remove: true)
            }
        }
    }
}

struct Inner: View {
    var pattern: Pattern
    var outerColour: Color

    static let isMatched: (Pattern) -> Bool = { pattern in
        return pattern.shape == PatternShape.none ? false : true
    }

    var body: some View {
        ZStack {
            Inner_Circle(colour: self.pattern.colour)
                .isHidden(!Inner_Circle.isMatched(self.pattern), remove: true)
            Inner_Diamond(colour: self.pattern.colour)
                .isHidden(!Inner_Diamond.isMatched(self.pattern), remove: true)
            Inner_Plus(colour: self.pattern.colour)
                .isHidden(!Inner_Plus.isMatched(self.pattern), remove: true)
            Inner_Star4(colour: self.pattern.colour, middleColour: self.outerColour)
                .isHidden(!Inner_Star4.isMatched(self.pattern), remove: true)
            Inner_Square(colour: self.pattern.colour)
                .isHidden(!Inner_Square.isMatched(self.pattern), remove: true)
        }
    }
}

struct Quad: View {
                                    // outser size is 100% of Quad's view size
    var middleSize: CGFloat = 0.8   // 80% percentage of Quad's view size
    var innerSize: CGFloat = 0.35   // 35% percentage of Quad's view size
    var side: Side
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Outer(pattern: self.side.design.outer)
                Middle(pattern: self.side.design.center, outerColour: self.side.design.outer.colour)
                    .frame(width: geometry.size.width * self.middleSize, height: geometry.size.height * self.middleSize)
                    .isHidden(!Middle.isMatched(self.side.design.center), remove: true)
                Inner(pattern: self.side.design.inner, outerColour: self.side.design.center.colour)
                    .frame(width: geometry.size.width * self.innerSize, height: geometry.size.height * self.innerSize)
                    .isHidden(!Inner.isMatched(self.side.design.inner), remove: true)
            }.clipped()
        }
    }
}

struct Tile: View {
    var piece: RotatingSquare
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // top left
                Quad(side: self.piece.square.top)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    .position(x: geometry.size.width / 4, y: geometry.size.height / 4)
                // top right
                Quad(side: self.piece.square.right)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    .position(x: geometry.size.width / 4 * 3, y: geometry.size.height / 4)
                // bottom left
                Quad(side: self.piece.square.left)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    .position(x: geometry.size.width / 4, y: geometry.size.height / 4 * 3)
                // bottom right
                Quad(side: self.piece.square.bottom)
                    .frame(width: geometry.size.width / 2, height: geometry.size.height / 2)
                    .position(x: geometry.size.width / 4 * 3, y: geometry.size.height / 4 * 3)
            }
        }
    }
}

struct ListRow: View {
    var tile: RotatingSquare
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text("\(String(self.tile.square.identifier))")
                    .bold()
                    .font(Font.largeTitle)
                    .padding()
                Tile(piece: self.tile)
                    .frame(width: min(geometry.size.width, geometry.size.height), height: min(geometry.size.width, geometry.size.height))
                    .clipShape(Diamond())
                    .rotationEffect(.degrees(45))
            }
        }
    }
}

struct ListView: View {
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(0..<Tiles.count) {
                    ListRow(tile: Tiles[$0])
                        .frame(minWidth: 400, maxWidth: .infinity, minHeight: 300)
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        //Text("Hello, World 4!").frame(maxWidth: .infinity, maxHeight: .infinity)
        //Inner_Plus(colour: Tiles[6].square.top.design.inner.colour).frame(width: 400, height: 400)
        //Middle_CircleCircleCut(colour: Tiles[0].square.top.design.center.colour, outerColour: Tiles[0].square.top.design.outer.colour).frame(width: 400, height: 400)
        //Middle_CrossCirclePoint(colour: Tiles[4].square.top.design.center.colour, outerColour: Tiles[0].square.top.design.outer.colour).frame(width: 400, height: 400)
        //Middle_CrossPointyPoint(colour: Tiles[5].square.top.design.center.colour, outerColour: Tiles[5].square.top.design.outer.colour).frame(width: 400, height: 400)
        //Middle_CircleCircleCorner(colour: Tiles[7].square.right.design.center.colour, outerColour: Tiles[7].square.right.design.outer.colour).frame(width: 400, height: 400)
        //Middle(pattern: Tiles[0].square.top.design.center, outerColour: Tiles[0].square.top.design.outer.colour).frame(width: 400, height: 400)
        //Quad(side: Tiles[7].square.right).frame(width: 400, height: 400)
        //Quad(side: Tiles[0].square.top).frame(width: 400, height: 400)
        //Tile(piece: Tiles[0]).frame(width: 400, height: 400)
        //ListRow(tile: Tiles[0]).frame(width: 600, height: 400)
        
        ListView().frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().frame(width: 800, height: 1200)
    }
}

