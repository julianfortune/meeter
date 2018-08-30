//
//  ViewController.swift
//  Meeter
//
//  Created by Julian Fortune on 8/28/18.
//  Copyright © 2018 Julian Fortune. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var meetingCost: MeetingCost!

	// MARK: Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()

		let defaultMemberCount = 0
		let defaultSalary = 0

		// Try to get default values

		meetingCost = MeetingCost(withMemberCount: defaultMemberCount, atSalary: defaultSalary)
	}
	
	// MARK: Statusbar
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
}

