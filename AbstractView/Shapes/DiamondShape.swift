//
//  DiamondShape.swift
//  AbstractView
//
//  Created by Christopher Luu on 11/18/15.
//  Copyright © 2015 Nuudles. All rights reserved.
//

import Foundation

public struct DiamondShape: AbstractShape
{
	// MARK: - Public constants
	public static let diamondShapeInitializer: ShapeInitializer =
	{
		(relativeFrame: CGRect, color: UIColor) in
		return DiamondShape(relativeFrame: relativeFrame, color: color)
	}

	// MARK: - Public properties
	public var relativeFrame: CGRect
	public var color: UIColor

	// MARK: - Initialization methods
	public init(relativeFrame: CGRect, color: UIColor)
	{
		self.relativeFrame = relativeFrame
		self.color = color
	}

	// MARK: - AbstractShape methods
	public func drawInContext(context: CGContextRef, forRect rect: CGRect)
	{
		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextBeginPath(context)
		CGContextMoveToPoint(context, rect.origin.x, rect.origin.y + rect.size.height / 2.0)
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width / 2.0, rect.origin.y)
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width, rect.origin.y + rect.size.height / 2.0)
		CGContextAddLineToPoint(context, rect.origin.x + rect.size.width / 2.0, rect.origin.y + rect.size.height)
		CGContextClosePath(context)

		CGContextDrawPath(context, CGPathDrawingMode.Fill)
	}
}
