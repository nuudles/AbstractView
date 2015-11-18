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
		(relativeFrame: CGRect, color: UIColor) in
		return TriangleShape(relativeFrame: relativeFrame, color: color)
	}
	
	// MARK: - Public properties
	public var relativeFrame: CGRect
	public var color: UIColor
	public var orientation: Orientation

	// MARK: - Initialization methods
	public init(relativeFrame: CGRect, color: UIColor, orientation: Orientation)
	{
		self.relativeFrame = relativeFrame
		self.color = color
		self.orientation = orientation
		
	}

	init(relativeFrame: CGRect, color: UIColor)
	{
		self.init(relativeFrame: relativeFrame, color: color, orientation: Orientation.allValues[Int(arc4random_uniform(UInt32(Orientation.count)))])
	}

	// MARK: - AbstractShape methods
	public func drawInContext(context: CGContextRef, forRect rect: CGRect)
	{
		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextBeginPath(context)
		switch orientation
		{
		case .Normal:
			CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height)
			CGContextAddLineToPoint(context, rect.origin.x + rect.size.width / 2.0, rect.origin.y)
			CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height)
		case .UpsideDown:
			CGContextMoveToPoint(context, rect.origin.x, rect.origin.y)
			CGContextAddLineToPoint(context, rect.origin.x + rect.size.width / 2.0, rect.origin.y + rect.size.height)
			CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y)
		case .PointingLeft:
			CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height / 2.0)
			CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y)
			CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height)
		case .PointingRight:
			CGContextMoveToPoint(context, rect.origin.x, rect.origin.y)
			CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 2.0)
			CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y + rect.size.height)
		}
		CGContextClosePath(context)

		CGContextDrawPath(context, CGPathDrawingMode.Fill)
	}
}
