//
//  MeetingCost.swift
//  Meeter
//
//  Created by Julian Fortune on 8/29/18.
//  Copyright © 2018 Julian Fortune. All rights reserved.
//

import Foundation

class Meeting {
	
	enum constants {
		static var secondsInAnHour = 3600
		static var hoursInAWorkWeek = 40
		static var workWeeksInAYear = 52
	}
	
	var averageSalary: Int { didSet { updateCostPerSecond() } }
	var numberOfMembers: Int { didSet { updateCostPerSecond() } }
	var costPerSecond = 0.0
	
	init(withMemberCount employees: Int, atSalary salary: Int) {
		numberOfMembers = employees
		averageSalary = salary
		updateCostPerSecond()
	}

	private func updateCostPerSecond() {
		costPerSecond = Double(averageSalary) / // Divided by the number of seconds of work in a year
			Double(constants.workWeeksInAYear) * Double(constants.hoursInAWorkWeek) * Double(constants.secondsInAnHour)
	}

	func totalCost(after timeInterval: Double) -> Double {
		return timeInterval * costPerSecond
	}
	
}
