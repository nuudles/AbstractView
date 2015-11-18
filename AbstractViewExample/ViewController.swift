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

	// MARK: - View methods
	override func viewDidLoad()
	{
		super.viewDidLoad()

		let imageView = UIImageView(image: UIImage(named: "space-wallpaper-29"))
		imageView.contentMode = .ScaleAspectFill

		abstractView.visualEffect = UIBlurEffect(style: .Light)
//		abstractView.backgroundColor = UIColor.blackColor()
		abstractView.shapeCount = 50
		abstractView.backgroundView = imageView
		abstractView.colorPalette = [UIColor(red: 0.0, green: 0.0, blue: 0.7, alpha: 1.0), UIColor(red: 0.0, green: 0.05, blue: 0.6, alpha: 1.0), UIColor(red: 0.0, green: 0.3, blue: 0.8, alpha: 1.0), UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 0.5)]
		abstractView.shapeInitializers = [{ (relativeFrame, _) in return ImageShape(relativeFrame: relativeFrame, image: UIImage(named: "sparkle")!) }]
//		abstractView.minShapeSize = 10
//		abstractView.maxShapeSize = 50
	}
}
