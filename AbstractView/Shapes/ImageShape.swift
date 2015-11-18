//
//  ImageShape.swift
//  AbstractView
//
//  Created by Christopher Luu on 11/18/15.
//  Copyright © 2015 Nuudles. All rights reserved.
//

import Foundation

public struct ImageShape: AbstractShape
{
	// MARK: - Public properties
	public var relativeFrame: CGRect
	public var image: UIImage

	// MARK: - Initialization methods
	public init(relativeFrame: CGRect, image: UIImage)
	{
		self.relativeFrame = relativeFrame
		self.image = image
	}
	
	// MARK: - AbstractShape methods
	public func drawInContext(context: CGContextRef, forRect rect: CGRect)
	{
		image.drawInRect(rect)
	}
}

