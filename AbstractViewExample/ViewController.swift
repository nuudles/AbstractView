//
//  ViewController.swift
//  AbstractViewExample
//
//  Created by Christopher Luu on 11/17/15.
//  Copyright © 2015 Nuudles. All rights reserved.
//

import UIKit
import AbstractView

class ViewController: UIViewController
{
	// MARK: - Private properties
	@IBOutlet private weak var abstractView: AbstractView!

	// MARK: - Private UI properties
	private lazy var backgroundButton: UIButton =
	{
		let button = UIButton(type: UIButtonType.System)
		button.setTitle("Turn on background image", forState: .Normal)
		button.addTarget(self, action: Selector("toggleButtonTapped:"), forControlEvents: .TouchUpInside)
		return button
	}()
	private lazy var visualEffectButton: UIButton =
	{
		let button = UIButton(type: UIButtonType.System)
		button.setTitle("Light blur", forState: .Normal)
		button.addTarget(self, action: Selector("toggleButtonTapped:"), forControlEvents: .TouchUpInside)
		return button
	}()
	private lazy var shapeButton: UIButton =
	{
		let button = UIButton(type: UIButtonType.System)
		button.setTitle("Only circles", forState: .Normal)
		button.addTarget(self, action: Selector("toggleButtonTapped:"), forControlEvents: .TouchUpInside)
		return button
	}()
	private lazy var paletteButton: UIButton =
	{
		let button = UIButton(type: UIButtonType.System)
		button.setTitle("Blue palette", forState: .Normal)
		button.addTarget(self, action: Selector("toggleButtonTapped:"), forControlEvents: .TouchUpInside)
		return button
	}()
	private lazy var shapeCountLabel: UILabel =
	{
		let label = UILabel()
		label.textAlignment = .Center
		label.text = "Shape Count: \(self.abstractView.shapeCount)"
		label.font = UIFont.systemFontOfSize(14)
		return label
	}()
	private lazy var shapeCountSlider: UISlider =
	{
		let slider = UISlider()
		slider.minimumValue = 0
		slider.maximumValue = 200
		slider.value = Float(self.abstractView.shapeCount)
		slider.addTarget(self, action: Selector("sliderValueChanged:"), forControlEvents: .ValueChanged)
		return slider
	}()
	private lazy var minShapeSizeLabel: UILabel =
	{
		let label = UILabel()
		label.textAlignment = .Center
		label.text = "Min Shape Size: None"
		label.font = UIFont.systemFontOfSize(14)
		return label
	}()
	private lazy var minShapeSizeSlider: UISlider =
	{
		let slider = UISlider()
		slider.minimumValue = -1
		slider.maximumValue = 300
		slider.value = -1
		slider.addTarget(self, action: Selector("sliderValueChanged:"), forControlEvents: .ValueChanged)
		return slider
	}()
	private lazy var maxShapeSizeLabel: UILabel =
	{
		let label = UILabel()
		label.textAlignment = .Center
		label.text = "Max Shape Size: None"
		label.font = UIFont.systemFontOfSize(14)
		return label
	}()
	private lazy var maxShapeSizeSlider: UISlider =
	{
		let slider = UISlider()
		slider.minimumValue = -1
		slider.maximumValue = 300
		slider.value = -1
		slider.addTarget(self, action: Selector("sliderValueChanged:"), forControlEvents: .ValueChanged)
		return slider
	}()

	private lazy var backgroundImageView: UIImageView =
	{
		let imageView = UIImageView(image: UIImage(named: "space-wallpaper-29"))
		imageView.contentMode = .ScaleAspectFill
		return imageView
	}()

	// MARK: - View methods
	override func viewDidLoad()
	{
		super.viewDidLoad()

		abstractView.contentView.addSubview(backgroundButton)
		abstractView.contentView.addSubview(visualEffectButton)
		abstractView.contentView.addSubview(shapeButton)
		abstractView.contentView.addSubview(paletteButton)
		abstractView.contentView.addSubview(shapeCountLabel)
		abstractView.contentView.addSubview(shapeCountSlider)
		abstractView.contentView.addSubview(minShapeSizeLabel)
		abstractView.contentView.addSubview(minShapeSizeSlider)
		abstractView.contentView.addSubview(maxShapeSizeLabel)
		abstractView.contentView.addSubview(maxShapeSizeSlider)

		abstractView.shapeInitializers = [OvalShape.circleShapeInitializer, OvalShape.ovalShapeInitializer, RectangleShape.squareShapeInitializer, RectangleShape.rectangleShapeInitializer, TriangleShape.triangleShapeInitializer, DiamondShape.diamondShapeInitializer, { (relativeFrame, _) in return ImageShape(relativeFrame: relativeFrame, image: UIImage(named: "sparkle")!) }]
	}

	override func viewDidLayoutSubviews()
	{
		super.viewDidLayoutSubviews()

		backgroundButton.frame = CGRect(x: 10, y: topLayoutGuide.length + 10, width: view.bounds.size.width - 20, height: 40)
		visualEffectButton.frame = CGRect(x: 10, y: backgroundButton.frame.maxY + 10, width: view.bounds.size.width - 20, height: 40)
		shapeButton.frame = CGRect(x: 10, y: visualEffectButton.frame.maxY + 10, width: view.bounds.size.width - 20, height: 40)
		paletteButton.frame = CGRect(x: 10, y: shapeButton.frame.maxY + 10, width: view.bounds.size.width - 20, height: 40)
		shapeCountLabel.frame = CGRect(x: 10, y: paletteButton.frame.maxY + 10, width: view.bounds.size.width - 20, height: 15)
		shapeCountSlider.frame = CGRect(x: 10, y: shapeCountLabel.frame.maxY + 5, width: view.bounds.size.width - 20, height: shapeCountSlider.bounds.size.height)
		minShapeSizeLabel.frame = CGRect(x: 10, y: shapeCountSlider.frame.maxY + 10, width: view.bounds.size.width - 20, height: 15)
		minShapeSizeSlider.frame = CGRect(x: 10, y: minShapeSizeLabel.frame.maxY + 5, width: view.bounds.size.width - 20, height: minShapeSizeSlider.bounds.size.height)
		maxShapeSizeLabel.frame = CGRect(x: 10, y: minShapeSizeSlider.frame.maxY + 10, width: view.bounds.size.width - 20, height: 15)
		maxShapeSizeSlider.frame = CGRect(x: 10, y: maxShapeSizeLabel.frame.maxY + 5, width: view.bounds.size.width - 20, height: maxShapeSizeSlider.bounds.size.height)
	}

	// MARK: - Button action methods
	func toggleButtonTapped(sender: UIButton)
	{
		sender.tag++
		switch (sender, sender.tag)
		{
		case (backgroundButton, 1):
			abstractView.backgroundView = backgroundImageView
			sender.setTitle("Turn off background image", forState: .Normal)
		case (backgroundButton, 2):
			abstractView.backgroundView = nil
			sender.setTitle("Turn on background image", forState: .Normal)
			sender.tag = 0

		case (visualEffectButton, 1):
			abstractView.visualEffect = UIBlurEffect(style: .Light)
			sender.setTitle("Dark blur", forState: .Normal)
		case (visualEffectButton, 2):
			abstractView.visualEffect = UIBlurEffect(style: .Dark)
			sender.setTitle("No visual effect", forState: .Normal)
		case (visualEffectButton, 3):
			abstractView.visualEffect = nil
			sender.setTitle("Extra light blur", forState: .Normal)
		case (visualEffectButton, 4):
			abstractView.visualEffect = UIBlurEffect(style: .ExtraLight)
			sender.setTitle("Light blur", forState: .Normal)
			sender.tag = 0

		case (shapeButton, 1):
			abstractView.shapeInitializers = [OvalShape.circleShapeInitializer]
			sender.setTitle("Circles and ovals", forState: .Normal)
		case (shapeButton, 2):
			abstractView.shapeInitializers = [OvalShape.circleShapeInitializer, OvalShape.ovalShapeInitializer]
			sender.setTitle("Only squares", forState: .Normal)
		case (shapeButton, 3):
			abstractView.shapeInitializers = [RectangleShape.squareShapeInitializer]
			sender.setTitle("Squares and rectangles", forState: .Normal)
		case (shapeButton, 4):
			abstractView.shapeInitializers = [RectangleShape.squareShapeInitializer, RectangleShape.rectangleShapeInitializer]
			sender.setTitle("Only triangles", forState: .Normal)
		case (shapeButton, 5):
			abstractView.shapeInitializers = [TriangleShape.triangleShapeInitializer]
			sender.setTitle("Only diamonds", forState: .Normal)
		case (shapeButton, 6):
			abstractView.shapeInitializers = [DiamondShape.diamondShapeInitializer]
			sender.setTitle("Only sparkle images", forState: .Normal)
		case (shapeButton, 7):
			abstractView.shapeInitializers = [{ (relativeFrame, _) in return ImageShape(relativeFrame: relativeFrame, image: UIImage(named: "sparkle")!) }]
			sender.setTitle("All shapes", forState: .Normal)
		case (shapeButton, 8):
			abstractView.shapeInitializers = [OvalShape.circleShapeInitializer, OvalShape.ovalShapeInitializer, RectangleShape.squareShapeInitializer, RectangleShape.rectangleShapeInitializer, TriangleShape.triangleShapeInitializer, DiamondShape.diamondShapeInitializer, { (relativeFrame, _) in return ImageShape(relativeFrame: relativeFrame, image: UIImage(named: "sparkle")!) }]
			sender.setTitle("Only circles", forState: .Normal)
			sender.tag = 0

		case (paletteButton, 1):
			abstractView.colorPalette = [UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0), UIColor(red: 0.0, green: 0.0, blue: 0.8, alpha: 1.0), UIColor(red: 0.0, green: 0.1, blue: 0.6, alpha: 1.0), UIColor(red: 0.0, green: 0.0, blue: 0.3, alpha: 1.0), UIColor(red: 0.0, green: 0.2, blue: 0.5, alpha: 1.0), UIColor(red: 0.0, green: 0.1, blue: 0.1, alpha: 1.0)]
			sender.setTitle("Red palette", forState: .Normal)
		case (paletteButton, 2):
			abstractView.colorPalette = [UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0), UIColor(red: 0.7, green: 0.0, blue: 0.0, alpha: 1.0), UIColor(red: 0.5, green: 0.0, blue: 0.0, alpha: 1.0), UIColor(red: 0.3, green: 0.0, blue: 0.0, alpha: 1.0), UIColor(red: 0.2, green: 0.0, blue: 0.0, alpha: 1.0)]
			sender.setTitle("Green palette", forState: .Normal)
		case (paletteButton, 3):
			abstractView.colorPalette = [UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 1.0), UIColor(red: 0.0, green: 0.7, blue: 0.0, alpha: 1.0), UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0), UIColor(red: 0.0, green: 0.3, blue: 0.0, alpha: 1.0), UIColor(red: 0.0, green: 0.2, blue: 0.0, alpha: 1.0)]
			sender.setTitle("No palette", forState: .Normal)
		case (paletteButton, 4):
			abstractView.colorPalette = nil
			sender.setTitle("Blue palette", forState: .Normal)
			sender.tag = 0

		default:
			break
		}
	}

	// MARK: - UIControl action methods
	func sliderValueChanged(sender: UISlider)
	{
		switch sender
		{
		case shapeCountSlider:
			abstractView.shapeCount = Int(sender.value)
			shapeCountLabel.text = "Shape Count: \(abstractView.shapeCount)"
		case minShapeSizeSlider:
			if sender.value > 0
			{
				abstractView.minShapeSize = CGFloat(sender.value)
				minShapeSizeLabel.text = "Min Shape Size: \(Int(sender.value))"
			}
			else
			{
				abstractView.minShapeSize = nil
				minShapeSizeLabel.text = "Min Shape Size: None"
			}
		case maxShapeSizeSlider:
			if sender.value > 0
			{
				abstractView.maxShapeSize = CGFloat(sender.value)
				maxShapeSizeLabel.text = "Max Shape Size: \(Int(sender.value))"
			}
			else
			{
				abstractView.maxShapeSize = nil
				maxShapeSizeLabel.text = "Max Shape Size: None"
			}
		default:
			break
		}
	}
}
