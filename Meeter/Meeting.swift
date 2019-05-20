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
		static var secondsInAYear = secondsInAnHour * hoursInAWorkWeek * workWeeksInAYear
	}
	
	var averageSalary: Int { didSet { updateCostPerSecond() } }
	var numberOfMembers: Int { didSet { updateCostPerSecond() } }
	var costPerSecond = 0.0

	var startTime: TimeInterval = 0
	var timeElapsed: TimeInterval {
		if startTime > 0 {
			return Date().timeIntervalSinceReferenceDate - startTime
		} else {
			return 0
		}
	}
	var timeElapsedBeforePause: TimeInterval?
	
	init(withMemberCount employees: Int, atSalary salary: Int) {
		numberOfMembers = employees
		averageSalary = salary
		updateCostPerSecond()
	}

	private func updateCostPerSecond() {
		costPerSecond = Double(averageSalary) * Double(numberOfMembers) / // Divided by the number of seconds of work in a year
			( Double(constants.workWeeksInAYear) * Double(constants.hoursInAWorkWeek) * Double(constants.secondsInAnHour) )
	}

	func startMeeting() {
		startTime = Date().timeIntervalSinceReferenceDate
	}

	func stopMeeting() {
		startTime = 0
	}

	func pauseMeeting() {
		timeElapsedBeforePause = timeElapsed
	}

	func resumeMeeting() {
		startTime = Date().timeIntervalSinceReferenceDate - timeElapsedBeforePause!
	}

	var totalCost: Double {
		return timeElapsed * costPerSecond
	}
	
}
