//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Igor Chernyshov on 19.06.2021.
//

import UIKit

class ViewController: UIViewController {

	// MARK: - Outlets
	@IBOutlet var button1: UIButton!
	@IBOutlet var button2: UIButton!
	@IBOutlet var button3: UIButton!

	// MARK: - Properties
	var countries: [String] = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
	var score = 0

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		[button1, button2, button3].forEach {
			$0?.layer.borderWidth = 1
			$0?.layer.borderColor = UIColor.lightGray.cgColor
		}
		askQuestion()
	}

	func askQuestion() {
		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)
	}
}

