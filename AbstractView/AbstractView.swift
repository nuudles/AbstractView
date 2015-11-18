//
//  AbstractView.swift
//  AbstractView
//
//  Created by Christopher Luu on 11/17/15.
//  Copyright © 2015 Nuudles. All rights reserved.
//

import UIKit

public typealias ShapeInitializer = (frame: CGRect, color: UIColor) -> (AbstractShape)

public class AbstractView: UIView
{
	// MARK: - Private properties
	private var shapeArray: [AbstractShape] = []

	// MARK: - Private UI properties
	private lazy var visualEffectView: UIVisualEffectView =
	{
		let visualEffectView = UIVisualEffectView(effect: UIBlurEffect())
		return visualEffectView
	}()

	// MARK: - Public properties
	public var visualEffect: UIVisualEffect?
	{
		get
		{
			return visualEffectView.effect
		}
		set
		{
			let newVisualEffectView = UIVisualEffectView(effect: newValue)
			visualEffectView.contentView.subviews.forEach({ newVisualEffectView.contentView.addSubview($0) })
			visualEffectView.removeFromSuperview()
			visualEffectView = newVisualEffectView
			addSubview(visualEffectView)

			setNeedsLayout()
		}
	}
	public var contentView: UIView
	{
		get
		{
			return visualEffectView.contentView
		}
	}
	public var backgroundView: UIView?
	{
		didSet
		{
			oldValue?.removeFromSuperview()
			if let view = backgroundView
			{
				insertSubview(view, atIndex: 0)
			}
		}
	}
	public var shapeInitializers: [ShapeInitializer] = [OvalShape.circleShapeInitializer, OvalShape.ovalShapeInitializer, RectangleShape.rectangleShapeInitializer, RectangleShape.squareShapeInitializer]
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
		createShapes()

		contentMode = .Redraw

		addSubview(visualEffectView)
	}

	private func createShapes()
	{
		shapeArray = []
		guard shapeInitializers.count > 0 else { return }

		for _ in 0 ..< shapeCount
		{
			let randomIndex = Int(arc4random_uniform(UInt32(shapeInitializers.count)))
			let shapeInitializer = shapeInitializers[randomIndex]

			let shape = shapeInitializer(frame: randomFrame(), color: randomColor())
			shapeArray.append(shape)
		}
		setNeedsDisplay()
	}

	private func randomFrame() -> CGRect
	{
		let width = max(min(CGFloat(arc4random_uniform(UInt32(bounds.size.width / 2.0))), maxShapeSize), minShapeSize)
		let height = max(min(CGFloat(arc4random_uniform(UInt32(bounds.size.height / 2.0))), maxShapeSize), minShapeSize)
		return CGRect(x: CGFloat(arc4random_uniform(UInt32(bounds.size.width + width))) - width / 2.0,
			y: CGFloat(arc4random_uniform(UInt32(bounds.size.height + height))) - height / 2.0,
			width: width,
			height: height)
	}

	private func randomColor() -> UIColor
	{
		return UIColor(red: CGFloat(arc4random_uniform(1000)) / 1000.0, green: CGFloat(arc4random_uniform(1000)) / 1000.0, blue: CGFloat(arc4random_uniform(1000)) / 1000.0, alpha: 1.0)
	}

	// MARK: - Layout methods
	public override func layoutSubviews()
	{
		super.layoutSubviews()

		visualEffectView.frame = bounds
	}

	// MARK: - Drawing methodss
	public override func drawRect(rect: CGRect)
	{
		super.drawRect(rect)

		guard let context = UIGraphicsGetCurrentContext() else { return }
		for shape in shapeArray
		{
			shape.drawInContext(context)
		}
	}
}
