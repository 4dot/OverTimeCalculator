//
//  ScheduleViewModel.swift
//  OverTimeMaster
//
//  Created by cpark on 3/7/19.
//  Copyright © 2019 4Dot. All rights reserved.
//

import Foundation
import JTAppleCalendar



class ScheduleViewModel {
    // [date : [schedule]] day only
    var scheduleGroup: [String : [Schedule]] = [:]
    
    
    // helper
    func dayOnly(date: Date) -> String {
        return date.toString(Settings.dayFormat)
    }
    
    
    
    // MARK: - public
    func getSchedules(with date: Date) -> [Schedule] {
        guard let data = scheduleGroup[dayOnly(date: date)] else {
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
        
        scheduleGroup = schedules.group{ self.dayOnly(date: $0.startTime) }
    }
}

extension ScheduleViewModel {
    // MARK: - cell configures
    
    @discardableResult func dateCellConfigure(cell: DateViewCell, cellState: CellState) -> DateViewCell {
        cell.dayLabel.text = cellState.text
        let cellHidden = cellState.dateBelongsTo != .thisMonth
        
        cell.isHidden = cellHidden
        cell.selectedView.backgroundColor = UIColor.black
        cell.selectedView.isHidden = !cellState.isSelected
        
        setCellColor(cellState: cellState, cell: cell)
        
        
        if scheduleGroup[dayOnly(date: cellState.date)] != nil {
            cell.eventView.isHidden = false
        }
        else {
            cell.eventView.isHidden = true
        }
        
        return cell
    }
    
    fileprivate func setCellColor(cellState: CellState, cell: DateViewCell) {
        cell.dayLabel.textColor = cellState.isSelected ? .white : .black
        
        // check today
        if Calendar.current.isDateInToday(cellState.date) {
            cell.selectedView.backgroundColor = .red
            cell.dayLabel.textColor = cellState.isSelected ? .white : .red
        }
        
        if cellState.isSelected == false {
            if cellState.day == .sunday || cellState.day == .saturday {
                cell.dayLabel.textColor = UIColor.gray
            }
        }
    }
    
    @discardableResult func scheduleCellConfigure(cell: ScheduleTableViewCell, selectedDate: Date?, indexPath: IndexPath) -> UITableViewCell {
        cell.selectionStyle = .none
        
        guard let selectedDate = selectedDate,
              let schedule = getSchedules(with: selectedDate)[safe: indexPath.row] else {
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
