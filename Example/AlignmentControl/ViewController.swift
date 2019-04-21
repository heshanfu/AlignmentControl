//
//  ViewController.swift
//  AlignmentControl
//
//  Created by tularovbeslan@gmail.com on 04/16/2019.
//  Copyright (c) 2019 tularovbeslan@gmail.com. All rights reserved.
//

import UIKit
import AlignmentControl

class ViewController: UIViewController {

	@IBOutlet weak var alignView: AlingmentView!
	var contentView: UIView!
	var redView: UIView!

	var axisX: CGFloat = 0
	var axisY: CGFloat = 0

	var padding: CGFloat = 40
	var width: CGFloat {
		return contentView.frame.width - padding
	}

	var height: CGFloat {
		return contentView.frame.height - padding
	}

    override func viewDidLoad() {
        super.viewDidLoad()

		alignView.setBackgroundImage(UIImage(named: "Group"))
        alignView.delegate = self
		alignView.dataSource = self
	}

	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)

 		contentViewSetup()
		generatePositions()
		redViewSetup()
	}

	fileprivate func contentViewSetup() {

		contentView = UIView(frame: CGRect(x: view.frame.origin.x + 15, y: 200, width: view.frame.width - 30, height: view.frame.height / 2))
		contentView.layer.cornerRadius = 30
		contentView.clipsToBounds = true
		contentView.backgroundColor = .white
		view.addSubview(contentView)

		let lineDash = CAShapeLayer()
		lineDash.strokeColor = UIColor.black.cgColor
		lineDash.lineDashPattern = [3, 3]
		lineDash.frame = contentView.bounds
		lineDash.fillColor = nil
		lineDash.lineWidth = 2
		lineDash.path = UIBezierPath(roundedRect: contentView.bounds, cornerRadius:  30).cgPath
		contentView.layer.addSublayer(lineDash)
	}

	fileprivate func redViewSetup() {

		redView = UIView(frame: CGRect(x: 10,
									   y: 10,
									   width: width / 3,
									   height: height / 3))
		redView.layer.cornerRadius = 20
		redView.backgroundColor = .red
		redView.clipsToBounds = true
		contentView.addSubview(redView)
	}

	fileprivate func generatePositions() {
		for i in 0..<3 {

			let y = ((height / 3 + 10) * CGFloat(i)) + 10
			for j in 0..<3 {
				let x = ((width / 3 + 10) * CGFloat(j)) + 10
				let view = UIView(frame: CGRect(x: x,
												y: y,
												width: width / 3,
												height: height / 3))
				view.backgroundColor = UIColor.init(red: 239/255.0, green: 240/255.0, blue: 246/255.0, alpha: 0.6)
				view.layer.cornerRadius = 20
				view.clipsToBounds = true
				contentView.addSubview(view)
			}
		}
	}
}

extension ViewController: AlingmentViewDelegate {
    
	func didSelectOptionFor(_ aligment: AlignmentMode) {
		switch aligment {
		case .Left:
			axisX = 0

			UIView.animate(withDuration: 0.3,
						   delay: 0,
						   usingSpringWithDamping: 0.7,
						   initialSpringVelocity: 0.7,
						   options: [.curveEaseOut],
						   animations: {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)

			}, completion: nil)
		case .Center:
			axisX = (width / 2) -  (self.redView.frame.width / 2) + 10
			UIView.animate(withDuration: 0.3,
						   delay: 0,
						   usingSpringWithDamping: 0.7,
						   initialSpringVelocity: 0.7,
						   options: [.curveEaseOut],
						   animations: {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}, completion: nil)
		case .Right:
			axisX = width - self.redView.frame.width + 20
			UIView.animate(withDuration: 0.3,
						   delay: 0,
						   usingSpringWithDamping: 0.7,
						   initialSpringVelocity: 0.7,
						   options: [.curveEaseOut],
						   animations: {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}, completion: nil)
		case .Top:
			axisY = 0
			UIView.animate(withDuration: 0.3,
						   delay: 0,
						   usingSpringWithDamping: 0.7,
						   initialSpringVelocity: 0.7,
						   options: [.curveEaseOut],
						   animations: {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}, completion: nil)
		case .Middle:
			axisY = (height / 2) -  (self.redView.frame.height / 2) + 10

			UIView.animate(withDuration: 0.3,
						   delay: 0,
						   usingSpringWithDamping: 0.7,
						   initialSpringVelocity: 0.7,
						   options: [.curveEaseOut],
						   animations: {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}, completion: nil)
		case .Bottom:
			axisY = height - self.redView.frame.height + 20

			UIView.animate(withDuration: 0.3,
						   delay: 0,
						   usingSpringWithDamping: 0.7,
						   initialSpringVelocity: 0.7,
						   options: [.curveEaseOut],
						   animations: {
				self.redView.transform = CGAffineTransform(translationX: self.axisX, y: self.axisY)
			}, completion: nil)
		}
	}
}

extension ViewController: AlingmentViewDataSource {

	func optionsForAlignment() -> [AlignmentMode] {
		return [.Left, .Center, .Right, .Top, .Middle, .Bottom]
	}
}
