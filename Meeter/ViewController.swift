//
//  ViewController.swift
//  Meeter
//
//  Created by Julian Fortune on 8/28/18.
//  Copyright © 2018 Julian Fortune. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	struct ActionButtonColor {
		struct Background {
			static let start = #colorLiteral(red: 0.03387554814, green: 0.1029147539, blue: 0, alpha: 1)
			static let stop = #colorLiteral(red: 0.1959092882, green: 0.1012412079, blue: 0, alpha: 1)
		}
		struct Text {
			static let start = #colorLiteral(red: 0.1657570453, green: 0.7795952691, blue: 0.1657570453, alpha: 1)
			static let stop = #colorLiteral(red: 1, green: 0.5916797093, blue: 0.07212999132, alpha: 1)
		}
	}

	struct ResetButtonColor {
		struct Background {
			static let enabled = #colorLiteral(red: 0.1400000006, green: 0.1400000006, blue: 0.1400000006, alpha: 1)
			static let disabled = #colorLiteral(red: 0.05999999866, green: 0.05999999866, blue: 0.05999999866, alpha: 1)
		}
		struct Text {
			static let enabled = UIColor.lightGray
			static let disabled = UIColor.darkGray
		}
	}

	enum State {
		case running
		case paused
		case stopped
	}

	enum ActionState {
		case start
		case stop
	}

	enum ResetState {
		case enabled
		case disabled
	}

	private var meeting: Meeting!
	private var state: State!

	// MARK: Outlets
	@IBOutlet weak var costLabel: UILabel!
	@IBOutlet weak var timeLabel: UILabel!

	@IBOutlet weak var actionButton: UIButton!
	@IBOutlet weak var resetButton: UIButton!

	@IBOutlet weak var memberCountButton: UIButton!
	@IBOutlet weak var memberCountOutline: UIView!
	@IBOutlet weak var memberCountMinusButton: UIButton!
	@IBOutlet weak var memberCountPlusButton: UIButton!
	@IBOutlet weak var memberCountLabel: UILabel!

	@IBOutlet weak var salaryButton: UIButton!
	@IBOutlet weak var salaryButtonOutline: UIView!
	@IBOutlet weak var salaryLabel: UILabel!
	@IBOutlet weak var dollarSignLabel: UILabel!

	weak var timer: Timer?

	// MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		let defaultMemberCount = 1
		let defaultSalary = 75000

		// Try to get default values

		meeting = Meeting(withMemberCount: defaultMemberCount, atSalary: defaultSalary)
		updateInputValues()

		state = .stopped
		updateInterfaceForNewState()
		updateActionButton(for: .start)
		updateResetButton(for: .disabled)

		costLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 200, weight: .thin)
		timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 100, weight: .ultraLight)
	}
	
	// MARK: Statusbar
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}

	// MARK: Actions
	@IBAction func actionButtonPressed() {
		if state == .running {
			state = .paused
			updateInterfaceForNewState()
			pauseMeeting()
		} else {
			if state == .stopped {
				startMeeting()
			} else {
				resumeMeeting()
			}
			// Make changes common to paused and stopped states
			state = .running
			updateInterfaceForNewState()
		}

	}

	@IBAction func resetButtonPressed() {
		state = .stopped
		updateInterfaceForNewState()
		resetMeeting()
	}

	@IBAction func memberCountButtonPressed() {
	}

	@IBAction func memberCountMinusButtonPressed() {
	}

	@IBAction func memberCountPlusButtonPressed() {
	}

	@IBAction func salaryButtonPressed() {
	}

}

private extension ViewController {

	func startMeeting() {
		timer = Timer.scheduledTimer(timeInterval: 0.05,
									 target: self,
									 selector: #selector(updateCounter),
									 userInfo: nil,
									 repeats: true)
		meeting.startMeeting()
	}

	func pauseMeeting() {
		timer?.invalidate()
		meeting.pauseMeeting()
		updateCounter()
	}

	func resumeMeeting() {
		timer = Timer.scheduledTimer(timeInterval: 0.05,
									 target: self,
									 selector: #selector(updateCounter),
									 userInfo: nil,
									 repeats: true)
		meeting.resumeMeeting()
	}

	func resetMeeting() {
		timer?.invalidate()
		meeting.stopMeeting()
		updateCounter()
	}

	func updateInterfaceForNewState() {
		if state == .running {
			// Members
			memberCountButton.setTitleColor(UIColor.darkGray, for: .normal)
			memberCountOutline.isHidden = true
			memberCountLabel.textColor = UIColor.darkGray
			memberCountPlusButton.isHidden = true
			memberCountMinusButton.isHidden = true

			// Salary
			salaryButton.setTitleColor(UIColor.darkGray, for: .normal)
			salaryButtonOutline.isHidden = true
			salaryLabel.textColor = UIColor.darkGray
			dollarSignLabel.textColor = UIColor.darkGray

			// Buttons
			resetButton.isEnabled = true
			memberCountButton.isEnabled = false
			salaryButton.isEnabled = false
			updateActionButton(for: .stop)
			updateResetButton(for: .enabled)
		} else {
			// Buttons
			updateActionButton(for: .start)

			if state == .stopped {
				// Members
				memberCountButton.setTitleColor(UIColor.white, for: .normal)
				memberCountOutline.isHidden = false
				memberCountLabel.textColor = UIColor.lightGray
				memberCountPlusButton.isHidden = false
				memberCountMinusButton.isHidden = false

				// Salary
				salaryButton.setTitleColor(UIColor.white, for: .normal)
				salaryButtonOutline.isHidden = false
				salaryLabel.textColor = UIColor.lightGray
				dollarSignLabel.textColor = UIColor.lightGray

				// Buttons
				resetButton.isEnabled = false
				memberCountButton.isEnabled = true
				salaryButton.isEnabled = true
				updateResetButton(for: .disabled)
			}
		}
	}

	func updateActionButton(for state: ActionState) {
		switch state {
		case .start:
			actionButton.backgroundColor = ActionButtonColor.Background.start
			actionButton.setTitleColor(ActionButtonColor.Text.start, for: .normal)
			actionButton.setTitle("Start", for: .normal)
		case .stop:
			actionButton.backgroundColor = ActionButtonColor.Background.stop
			actionButton.setTitleColor(ActionButtonColor.Text.stop, for: .normal)
			actionButton.setTitle("Pause", for: .normal)
		}
	}

	func updateResetButton(for state: ResetState) {
		switch state {
		case .enabled:
			resetButton.backgroundColor = ResetButtonColor.Background.enabled
			resetButton.setTitleColor(ResetButtonColor.Text.enabled, for: .normal)
		case .disabled:
			resetButton.backgroundColor = ResetButtonColor.Background.disabled
			resetButton.setTitleColor(ResetButtonColor.Text.disabled, for: .normal)
		}
	}

	func updateInputValues() {
		memberCountButton.setTitle(String(meeting.numberOfMembers), for: .normal)
		salaryButton.setTitle(String(meeting.averageSalary), for: .normal)
	}

	@objc func updateCounter() {
		costLabel.text = meeting.presentableCost()
		timeLabel.text = meeting.presentableTime()
	}

}

private extension Meeting {

	func presentableCost() -> String {
		if totalCost < 1000 {
			return String(format: "$%.2f",totalCost)
		} else if totalCost < 1000000 {
			return String(format: "$%.2fk",totalCost / 1000)
		} else if totalCost < 1000000000 {
			return String(format: "$%.2fM",totalCost / 1000000)
		} else if totalCost < 1000000000000 {
			return String(format: "$%.2fB",totalCost / 1000000000)
		} else {
			return "A lot."
		}
	}

	func presentableTime() -> String {
		let minutes = Int(timeElapsed / 60)
		let seconds = Int(timeElapsed) - minutes * 60
		var outputString = ":"
		if seconds < 10 {
			outputString = outputString + "0" + String(seconds)
		} else {
			outputString += String(seconds)
		}
		if minutes < 10 {
			outputString = "0" + String(minutes) + outputString
		} else {
			outputString = "0" + String(minutes) + outputString
		}
		return outputString
	}

}
