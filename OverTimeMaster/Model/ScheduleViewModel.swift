//
//  ScheduleViewModel.swift
//  OverTimeMaster
//
//  Created by cpark on 3/7/19.
//  Copyright © 2019 4Dot. All rights reserved.
//

import Foundation
import JTAppleCalendar



///
var scheduledDayFormatString: String = "yyyy MM dd"



class ScheduleViewModel {
    // [date : [schedule]] day only
    var scheduleGroup: [String : [Schedule]] = [:]
    
    
    
    
    // MARK: - public
    func getSchedules(with date: Date) -> [Schedule] {
        guard let data = scheduleGroup[date.toString(scheduledDayFormatString)] else {
            return []
        }
        return data.sorted()
    }
    
    // MARK: - test
    
    func generateRandomSchedules(fromDate: Date, toDate: Date) {
        var schedules: [Schedule] = []
        for _ in 1...100 {
            schedules.append(Schedule(fromStartDate: fromDate))
        }
        
        scheduleGroup = schedules.group{ $0.startTime.toString(scheduledDayFormatString) }
    }
}

extension ScheduleViewModel {
    // MARK: - cell configures
    
    func dateCellConfigure(cell: DateViewCell, cellState: CellState) -> UICollectionViewCell {
        cell.dayLabel.text = cellState.text
        let cellHidden = cellState.dateBelongsTo != .thisMonth
        
        cell.isHidden = cellHidden
        cell.selectedView.backgroundColor = UIColor.black
        
        if Calendar.current.isDateInToday(cellState.date) {
            cell.selectedView.backgroundColor = UIColor.red
        }
        
        //handleCellTextColor(view: myCustomCell, cellState: cellState)
        //handleCellSelection(view: myCustomCell, cellState: cellState)
        
        if scheduleGroup[cellState.date.toString(scheduledDayFormatString)] != nil {
            cell.eventView.isHidden = false
        }
        else {
            cell.eventView.isHidden = true
        }
        
        return cell
    }
    
    func scheduleCellConfigure(cell: ScheduleTableViewCell, selectedDate: Date, indexPath: IndexPath) -> UITableViewCell {
        let schedules = getSchedules(with: selectedDate)
        
        guard let schedule = schedules[safe: indexPath.row] else {
            return cell
        }
        
        cell.titleLabel.text = schedule.title
        cell.noteLabel.text = schedule.note
        
        cell.startTimeLabel.text =  schedule.startTime.toString("HH:mm")
        cell.endTimeLabel.text = schedule.endTime.toString("HH:mm")
        cell.categoryLine.backgroundColor = schedule.categoryColor
        
        return cell
    }
}
