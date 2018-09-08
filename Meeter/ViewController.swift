//
//  ViewController.swift
//  Meeter
//
//  Created by Julian Fortune on 8/28/18.
//  Copyright © 2018 Julian Fortune. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	enum State {
		case running
		case paused
		case stopped
	}

	enum ActionState {
		case start
		case stop
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

	// MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		let defaultMemberCount = 0
		let defaultSalary = 0

		// Try to get default values

		meeting = Meeting(withMemberCount: defaultMemberCount, atSalary: defaultSalary)

		state = .stopped
		updateInterfaceForNewState()
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
		} else {
			// Make changes common to paused and stopped states
			state = .running
			updateInterfaceForNewState()
		}

	}

	@IBAction func resetButtonPressed() {
		state = .stopped
		updateInterfaceForNewState()
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
			resetButton.backgroundColor = UIColor.darkGray
			memberCountButton.isEnabled = false
			salaryButton.isEnabled = false
			updateActionButton(for: .stop)
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
				resetButton.backgroundColor = UIColor.black
				memberCountButton.isEnabled = true
				salaryButton.isEnabled = true
			}
		}
	}

	func updateActionButton(for state: ActionState) {
		switch state {
		case .start:
			actionButton.backgroundColor = UIColor.green
			actionButton.setTitleColor(UIColor.green, for: .normal)
			actionButton.titleLabel?.text = "Start"
		case .stop:
			actionButton.backgroundColor = UIColor.orange
			actionButton.setTitleColor(UIColor.orange, for: .normal)
			actionButton.titleLabel?.text = "Stop"
		}
	}

	func updateInputValues() {
		memberCountButton.titleLabel?.text = String(meeting.numberOfMembers)
		salaryButton.titleLabel?.text = String(meeting.averageSalary)
	}

	func updateCounter() {
		costLabel.text = meeting.totalCost(after: 0.0).presentableCost()
		timeLabel.text = ""
	}

}

private extension Double {

	func presentableCost() -> String {
		if self < 1000 {

		} else if self < 1000000 {

		} else if self < 1000000000 {

		} else if self < 1000000000000 {

		} else {
			return "A lot."
		}

		return ""
	}

}
