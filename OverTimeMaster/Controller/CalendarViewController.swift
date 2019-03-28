//
//  CalendarViewController.swift
//  OverTimeCalculator
//
//  Created by chanick park on 2/19/19.
//  Copyright © 2019 4Dot. All rights reserved.
//

import UIKit
import JTAppleCalendar



//
// CalendarViewController
//
class CalendarViewController : UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showTodayButton: UIBarButtonItem!
    
    @IBOutlet weak var separatorViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - DataSource
    lazy var scheduleViewModel: ScheduleViewModel = ScheduleViewModel()
    
    var firstDateInMonth: Date?
    
    // MARK: - Helpers
    var numOfRowIsSix: Bool {
        get {
            return calendarView.visibleDates().outdates.count < 7
        }
    }
    
    var currentMonthSymbol: String {
        get {
            let startDate = (calendarView.visibleDates().monthDates.first?.date)!
            let month = Calendar.current.dateComponents([.month], from: startDate).month!
            let monthString = DateFormatter().monthSymbols[month-1]
            return monthString
        }
    }
    
    
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewNibs()
        initUI()
    }
    

    // MARK: - init
    
    fileprivate func initUI() {
        showTodayButton.target = self
        showTodayButton.action = #selector(showTodayWithAnimate)
        showToday(animate: false)
        
        // add longtap gesture to calendar view
        calendarView.addLongTapGestureRecognizer { (gesture) in
            let point = gesture.location(in: self.calendarView)
            guard let cellStatus = self.calendarView.cellStatus(at: point) else {
                return
            }
            
            if self.calendarView.selectedDates.first != cellStatus.date {
                self.calendarView.deselectAllDates()
                self.calendarView.selectDates([cellStatus.date])
            }
        }
    }
    
    fileprivate func setupViewNibs() {
        let dateCell = UINib(nibName: "DateViewCell", bundle: Bundle.main)
        calendarView.register(dateCell, forCellWithReuseIdentifier: DateViewCell.reuseIdentifier)
        
        let scheduleCell = UINib(nibName: "ScheduleTableViewCell", bundle: Bundle.main)
        tableView.register(scheduleCell, forCellReuseIdentifier: ScheduleTableViewCell.reuseIdentifier)
    }
    
    fileprivate func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
        
        let year = Calendar.current.component(.year, from: startDate)
        title = "\(year) \(currentMonthSymbol)"
    }
}

// MARK: Helpers
extension CalendarViewController {
    func select(onVisibleDates visibleDates: DateSegmentInfo) {
        guard let firstDateInMonth = visibleDates.monthDates.first?.date else
        { return }
        
        if firstDateInMonth.isThisMonth() {
            calendarView.selectDates([Date()])
        } else {
            calendarView.selectDates([firstDateInMonth])
        }
    }
}

// MARK: - Button events
extension CalendarViewController {
    @objc func showTodayWithAnimate() {
        showToday(animate: true)
    }
    
    func showToday(animate:Bool) {
        calendarView.scrollToDate(Date(), triggerScrollToDateDelegate: true, animateScroll: animate, preferredScrollPosition: nil, extraAddedOffset: 0) { [unowned self] in
            self.getSchedule()
            self.calendarView.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
                self.setupViewsOfCalendar(from: visibleDates)
            }
            
            self.adjustCalendarViewHeight()
            self.calendarView.selectDates([Date()])
        }
    }
}

// MARK: - Dynamic CalendarView's height

extension CalendarViewController {
    func adjustCalendarViewHeight() {
        adjustCalendarViewHeight(higher: self.numOfRowIsSix)
    }
    
    func adjustCalendarViewHeight(higher: Bool) {
        separatorViewTopConstraint.constant = higher ? 0 : -calendarView.frame.height / CGFloat(Settings.numOfRowsInCalendar)
    }
}

// MARK: - Prepere dataSource

extension CalendarViewController {
    func getSchedule() {
        if let startDate = calendarView.visibleDates().monthDates.first?.date  {
            let endDate = Calendar.current.date(byAdding: .month, value: 1, to: startDate)
            getSchedule(fromDate: startDate, toDate: endDate!)
        }
    }
    
    
    func getSchedule(fromDate: Date, toDate: Date) {
        var schedules: [Schedule] = []
        for _ in 1...Settings.maxNumOfRandomEvent {
            schedules.append(Schedule(fromStartDate: fromDate))
        }
        
        scheduleViewModel.scheduleGroup = schedules.group { self.scheduleViewModel.dayOnly(date: $0.startTime) }
    }
}

// MARK: - JTAppleCalendarViewDataSource

extension CalendarViewController: JTAppleCalendarViewDataSource {
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let parameters = ConfigurationParameters(startDate: Settings.calendarStartDate,
                                                 endDate: Settings.calendarEndDate,
                                                 numberOfRows: Settings.numOfRowsInCalendar,
                                                 calendar: Calendar.current,
                                                 generateInDates: .forAllMonths,
                                                 generateOutDates: .tillEndOfGrid,
                                                 firstDayOfWeek: .sunday,
                                                 hasStrictBoundaries: true)
        return parameters
    }
}

// MARK: - JTAppleCalendarViewDelegate

extension CalendarViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = calendar.dequeueReusable(cellClass: DateViewCell.self, for: indexPath)
        scheduleViewModel.dateCellConfigure(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusable(cellClass: DateViewCell.self, for: indexPath)
        return scheduleViewModel.dateCellConfigure(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
        if visibleDates.monthDates.first?.date == firstDateInMonth {
            return
        }
        
        firstDateInMonth = visibleDates.monthDates.first?.date
        
        getSchedule()
        select(onVisibleDates: visibleDates)
        
        view.layoutIfNeeded()
        
        adjustCalendarViewHeight()
        
        UIView.animate(withDuration: 0.5) { [unowned self] in
            self.view.layoutIfNeeded()
        }
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if let dateCell = cell as? DateViewCell {
            scheduleViewModel.dateCellConfigure(cell: dateCell, cellState: cellState)
        }
        tableView.reloadData()
        tableView.contentOffset = .zero
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        if let dateCell = cell as? DateViewCell {
            scheduleViewModel.dateCellConfigure(cell: dateCell, cellState: cellState)
        }
    }
}

// MARK: - UITableViewDataSource
extension CalendarViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusable(cellClass: ScheduleTableViewCell.self, for: indexPath)
        return scheduleViewModel.scheduleCellConfigure(cell: cell, selectedDate: calendarView.selectedDates.first, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectedDate = calendarView.selectedDates.first else {
            return 0
        }
        return  scheduleViewModel.getSchedules(with: selectedDate).count
    }
}

// MARK: - UITableViewDelegate
extension CalendarViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedDate = calendarView.selectedDates.first {
            let schedules = scheduleViewModel.getSchedules(with: selectedDate)
            let schedule = schedules[safe: indexPath.row]
            
            print(schedule)
            print("schedule selected")
        }
    }
}
