//
//  AbstractView.swift
//  AbstractView
//
//  Created by Christopher Luu on 11/17/15.
//  Copyright © 2015 Nuudles. All rights reserved.
//

import UIKit

public typealias ShapeInitializer = (relativeFrame: CGRect, color: UIColor) -> (AbstractShape)

public class AbstractView: UIView
{
	// MARK: - Private UI properties
	private lazy var abstractShapeView: AbstractShapeView =
	{
		let abstractShapeView = AbstractShapeView()
		return abstractShapeView
	}()
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
				insertSubview(view, belowSubview: abstractShapeView)
				setNeedsLayout()
			}
		}
	}
	public var shapeInitializers: [ShapeInitializer]
	{
		get { return abstractShapeView.shapeInitializers }
		set { abstractShapeView.shapeInitializers = newValue }
	}
	public var shapeCount: Int
	{
		get { return abstractShapeView.shapeCount }
		set { abstractShapeView.shapeCount = newValue }
	}
	public var minShapeSize: CGFloat
	{
		get { return abstractShapeView.minShapeSize }
		set { abstractShapeView.minShapeSize = newValue }
	}
	public var maxShapeSize: CGFloat
	{
		get { return abstractShapeView.maxShapeSize }
		set { abstractShapeView.maxShapeSize = newValue }
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
		addSubview(abstractShapeView)
		addSubview(visualEffectView)
	}

	// MARK: - Layout methods
	public override func layoutSubviews()
	{
		super.layoutSubviews()

		backgroundView?.frame = bounds
		abstractShapeView.frame = bounds
		visualEffectView.frame = bounds
	}
}
