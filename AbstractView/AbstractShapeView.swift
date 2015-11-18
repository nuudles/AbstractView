//
//  AbstractShapeView.swift
//  AbstractView
//
//  Created by Christopher Luu on 11/18/15.
//  Copyright © 2015 Nuudles. All rights reserved.
//

import Foundation

public class AbstractShapeView: UIView
{
	// MARK: - Private properties
	private var shapeArray: [AbstractShape] = []

	// MARK: - Public properties
	public var shapeInitializers: [ShapeInitializer] = [OvalShape.circleShapeInitializer, OvalShape.ovalShapeInitializer, RectangleShape.rectangleShapeInitializer, RectangleShape.squareShapeInitializer, TriangleShape.triangleShapeInitializer]
	{
		didSet
		{
			createShapes()
		}
	}
	public var shapeCount = 100
	{
		didSet
		{
			setNeedsDisplay()
		}
	}
	public var minShapeSize = CGFloat(0.0)
	{
		didSet
		{
			createShapes()
		}
	}
	public var maxShapeSize = CGFloat(FLT_MAX)
	{
		didSet
		{
			createShapes()
		}
	}

	// MARK: - Initialization methods
	public override init(frame: CGRect)
	{
		super.init(frame: frame)
		initializeView()
	}

	public required init?(coder aDecoder: NSCoder)
	{
		super.init(coder: aDecoder)
		initializeView()
	}

	// MARK: - Private methods
	private func initializeView()
	{
		backgroundColor = .clearColor()
		contentMode = .Redraw
		createShapes()
	}

	private func createShapes()
	{
		shapeArray = []
		guard shapeInitializers.count > 0 else { return }
		
		for _ in 0 ..< shapeCount
		{
			let randomIndex = Int(arc4random_uniform(UInt32(shapeInitializers.count)))
			let shapeInitializer = shapeInitializers[randomIndex]
			
			let shape = shapeInitializer(relativeFrame: randomRelativeFrame(), color: randomColor())
			shapeArray.append(shape)
		}
		setNeedsDisplay()
	}
	
	private func randomRelativeFrame() -> CGRect
	{
		return CGRect(x: CGFloat(arc4random_uniform(1000)) / 1000.0, y: CGFloat(arc4random_uniform(1000)) / 1000.0, width: CGFloat(arc4random_uniform(1000)) / 1000.0, height: CGFloat(arc4random_uniform(1000)) / 1000.0)
	}
	
	private func randomColor() -> UIColor
	{
		return UIColor(red: CGFloat(arc4random_uniform(1000)) / 1000.0, green: CGFloat(arc4random_uniform(1000)) / 1000.0, blue: CGFloat(arc4random_uniform(1000)) / 1000.0, alpha: 1.0)
	}

	// MARK: - Drawing methodss
	public override func drawRect(rect: CGRect)
	{
		super.drawRect(rect)

		guard let context = UIGraphicsGetCurrentContext() else { return }
		for shape in shapeArray
		{
			let minDimension = min(bounds.size.width, bounds.size.height)
			var shapeRect = CGRect(x: shape.relativeFrame.minX * bounds.size.width, y: shape.relativeFrame.minY * bounds.size.height, width: shape.relativeFrame.size.width * minDimension, height: shape.relativeFrame.size.height * minDimension)
			shapeRect.size.width = min(max(shapeRect.size.width, minShapeSize), maxShapeSize)
			shapeRect.size.height = min(max(shapeRect.size.height, minShapeSize), maxShapeSize)
			shape.drawInContext(context, forRect: shapeRect)
		}
	}
}
