//
//  MeetingCost.swift
//  Meeter
//
//  Created by Julian Fortune on 8/29/18.
//  Copyright © 2018 Julian Fortune. All rights reserved.
//

import Foundation

class MeetingCost {
	
	enum constants: Int {
		typealias RawValue = Int
		
		case yearInSeconds = 31536000
	}
	
	var averageSalary: Int { didSet { updateCostPerSecond() } }
	var numberOfMembers: Int { didSet { updateCostPerSecond() } }
	var costPerSecond: Float!
	
	init(withMemberCount employees: Int, atSalary salary: Int) {
		numberOfMembers = employees
		averageSalary = salary
		updateCostPerSecond()
	}

	private func updateCostPerSecond() {
		costPerSecond = Float(numberOfMembers) * Float(averageSalary) / Float(constants.yearInSeconds.rawValue)
	}

	func after(timeInterval interval: Float) -> Float {
		return 0.0
	}
	
}
