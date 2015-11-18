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
		abstractView.shapeCount = 20
		abstractView.backgroundView = imageView
//		abstractView.shapeInitializers = [OvalShape.circleShapeInitializer]
		abstractView.minShapeSize = 50
		abstractView.maxShapeSize = 100
	}
}
