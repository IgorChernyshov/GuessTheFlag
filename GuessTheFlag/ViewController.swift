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
	var questionsAnswered = 0
	var countries: [String] = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapScoreButton))

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
		title = "\(countries[correctAnswer].uppercased()). Score \(score)"
	}

	// MARK: - Actions
	@IBAction func buttonTapped(_ sender: UIButton) {
		var title: String
		var message: String?
		UIView.animate(withDuration: 0.2, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [.autoreverse]) {
			sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
		} completion: { _ in
			sender.transform = .identity
		}

		if sender.tag == correctAnswer {
			title = "Correct!"
			message = nil
			score += 1
		} else {
			title = "Wrong!"
			message = "That's \(countries[sender.tag].uppercased())"
			score -= 1
		}

		questionsAnswered += 1
		if questionsAnswered >= 5 {
			let highestScoreKey = "highestScore"
			let highestScore = UserDefaults.standard.integer(forKey: highestScoreKey)
			if self.score > highestScore {
				UserDefaults.standard.set(self.score, forKey: highestScoreKey)
			}
			let alertController = UIAlertController(title: "Game Over", message: "You scored \(score). Your highest score is \(highestScore) so far.", preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "Reset", style: .default) { _ in
				self.score = 0
				self.questionsAnswered = 0
				self.askQuestion(action: nil)
			})
			present(alertController, animated: true)
		} else {
			let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
			alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
			present(alertController, animated: true)
		}
	}

	@objc func didTapScoreButton() {
		let alertController = UIAlertController(title: "Your score is \(score)", message: "In case like you can't read it in the navigation bar", preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "M'kay", style: .default))
		present(alertController, animated: true)
	}
}

