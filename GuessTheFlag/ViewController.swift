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
	var score = 0
	var correctAnswer = 0
	var countries: [String] = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		[button1, button2, button3].forEach {
			$0?.layer.borderWidth = 1
			$0?.layer.borderColor = UIColor.lightGray.cgColor
		}
		askQuestion(action: nil)
	}

	// MARK: - Game Progress
	private func askQuestion(action: UIAlertAction?) {
		countries.shuffle()
		button1.setImage(UIImage(named: countries[0]), for: .normal)
		button2.setImage(UIImage(named: countries[1]), for: .normal)
		button3.setImage(UIImage(named: countries[2]), for: .normal)
		correctAnswer = Int.random(in: 0...2)
		title = countries[correctAnswer].uppercased()
	}

	// MARK: - Actions
	@IBAction func buttonTapped(_ sender: UIButton) {
		var title: String

		if sender.tag == correctAnswer {
			title = "Correct!"
			score += 1
		} else {
			title = "Wrong!"
			score -= 1
		}

		let alertController = UIAlertController(title: title, message: "Your score is \(score)", preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
		present(alertController, animated: true)
	}
}

