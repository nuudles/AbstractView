//
//  AbstractShape.swift
//  AbstractView
//
//  Created by Christopher Luu on 11/17/15.
//  Copyright © 2015 Nuudles. All rights reserved.
//

import Foundation

public protocol AbstractShape
{
	func drawInContext(context: CGContextRef)
}
