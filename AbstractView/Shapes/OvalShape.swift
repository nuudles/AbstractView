//
//  OvalShape.swift
//  AbstractView
//
//  Created by Christopher Luu on 11/17/15.
//  Copyright © 2015 Nuudles. All rights reserved.
//

import Foundation

public struct OvalShape: AbstractShape
{
	// MARK: - Public constants
	public static let ovalShapeInitializer: ShapeInitializer =
	{
		(frame: CGRect, color: UIColor) in
		return OvalShape(frame: frame, color: color)
	}
	public static let circleShapeInitializer: ShapeInitializer =
	{
		(frame: CGRect, color: UIColor) in
		let radius = min(frame.size.width, frame.size.height)
		return OvalShape(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: radius, height: radius), color: color)
	}

	// MARK: - Public properties
	public var frame: CGRect
	public var color: UIColor

	// MARK: - Initialization methods
	public init(frame: CGRect, color: UIColor)
	{
		self.frame = frame
		self.color = color
	}

	// MARK: - AbstractShape methods
	public func drawInContext(context: CGContextRef)
	{
		CGContextSetStrokeColorWithColor(context, color.CGColor)
		CGContextSetFillColorWithColor(context, color.CGColor)
		CGContextFillEllipseInRect(context, frame)
		CGContextStrokeEllipseInRect(context, frame)
	}
}
