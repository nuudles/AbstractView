//
//  TriangleShape.swift
//  AbstractView
//
//  Created by Christopher Luu on 11/18/15.
//  Copyright © 2015 Nuudles. All rights reserved.
//

import Foundation

public struct TriangleShape: AbstractShape
{
	// MARK: - Public enums
	public enum Orientation
	{
		case Normal
		case UpsideDown
		case PointingLeft
		case PointingRight

		static let allValues: [Orientation] = [.Normal, .UpsideDown, .PointingLeft, .PointingRight]
		static let count = allValues.count
	}

	// MARK: - Public constants
	public static let triangleShapeInitializer: ShapeInitializer =
	{
		(frame: CGRect, color: UIColor) in
		return TriangleShape(frame: frame, color: color)
	}
	
	// MARK: - Public properties
	public var frame: CGRect
	public var color: UIColor
	public var orientation: Orientation

	// MARK: - Initialization methods
	public init(frame: CGRect, color: UIColor, orientation: Orientation)
	{
		self.frame = frame
		self.color = color
		self.orientation = orientation
		
	}

	init(frame: CGRect, color: UIColor)
	{
		self.init(frame: frame, color: color, orientation: Orientation.allValues[Int(arc4random_uniform(UInt32(Orientation.count)))])
	}

	// MARK: - AbstractShape methods
	public func drawInContext(context: CGContextRef)
	{
		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextBeginPath(context)
		switch orientation
		{
		case .Normal:
			CGContextMoveToPoint(context, frame.origin.x, frame.origin.y + frame.size.height)
			CGContextAddLineToPoint(context, frame.origin.x + frame.size.width / 2.0, frame.origin.y)
			CGContextAddLineToPoint(context, frame.origin.x + frame.size.width, frame.origin.y + frame.size.height)
		case .UpsideDown:
			CGContextMoveToPoint(context, frame.origin.x, frame.origin.y)
			CGContextAddLineToPoint(context, frame.origin.x + frame.size.width / 2.0, frame.origin.y + frame.size.height)
			CGContextAddLineToPoint(context, frame.origin.x + frame.size.width, frame.origin.y)
		case .PointingLeft:
			CGContextMoveToPoint(context, frame.origin.x, frame.origin.y + frame.size.height / 2.0)
			CGContextAddLineToPoint(context, frame.origin.x + frame.size.width, frame.origin.y)
			CGContextAddLineToPoint(context, frame.origin.x + frame.size.width, frame.origin.y + frame.size.height)
		case .PointingRight:
			CGContextMoveToPoint(context, frame.origin.x, frame.origin.y)
			CGContextAddLineToPoint(context, frame.origin.x + frame.size.width, frame.origin.y + frame.size.height / 2.0)
			CGContextAddLineToPoint(context, frame.origin.x, frame.origin.y + frame.size.height)
		}
		CGContextClosePath(context)

		CGContextDrawPath(context, CGPathDrawingMode.Fill)
	}
}
