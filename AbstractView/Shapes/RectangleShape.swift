//
//  RectangleShape.swift
//  AbstractView
//
//  Created by Christopher Luu on 11/17/15.
//  Copyright © 2015 Nuudles. All rights reserved.
//

import Foundation

public struct RectangleShape: AbstractShape
{
	// MARK: - Public constants
	public static let rectangleShapeInitializer: ShapeInitializer =
	{
		(relativeFrame: CGRect, color: UIColor) in
		return RectangleShape(relativeFrame: relativeFrame, color: color)
	}
	public static let squareShapeInitializer: ShapeInitializer =
	{
		(relativeFrame: CGRect, color: UIColor) in
		let radius = min(relativeFrame.size.width, relativeFrame.size.height)
		return RectangleShape(relativeFrame: CGRect(x: relativeFrame.origin.x, y: relativeFrame.origin.y, width: radius, height: radius), color: color)
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
		CGContextSetStrokeColorWithColor(context, color.CGColor)
		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextFillRect(context, rect)
		CGContextStrokeRect(context, rect)
	}
}
