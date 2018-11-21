//
//  WeekViewController.swift
//  Rainstorm
//
//  Created by Brandon Jacobi on 11/8/18.
//  Copyright © 2018 Brandon Jacobi. All rights reserved.
//

import UIKit

protocol WeekViewControllerDelegate: class {
    func controllerDidRefresh(_ controller: WeekViewController)
}

final class WeekViewController: UIViewController {
    
    //MARK: - View Models
    
    weak var delegate: WeekViewControllerDelegate?
    
    var viewModel: WeekViewModel? {
        didSet {
            refreshControl.endRefreshing()
            if let viewModel = viewModel {
                // Setup View Model
                setupViewModel(with: viewModel)
            }
        }
    }
    
    //MARK: - UI Properites
    
    lazy var weekTableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true
        tableView.backgroundColor = .white
        tableView.separatorInset = .zero
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor.RainStorm.baseTintColor
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weekTableView.dataSource = self
        weekTableView.register(WeekDayTableViewCell.self, forCellReuseIdentifier: "WeekDayTableViewCell")
        
        // Setup views
        setupView()
        
    }
    
    // MARK: -  Helper Methods
    
    private func setupView() {
        view.addSubview(weekTableView)
        
        weekTableView.fillSuperview()
        
        view.backgroundColor = .white
    }
    
    private func setupViewModel(with viewModel: WeekViewModel) {
        weekTableView.reloadData()
        weekTableView.isHidden = false
    }
    
    @objc private func refresh(_ sender: UIRefreshControl) {
        delegate?.controllerDidRefresh(self)
    }

}

extension WeekViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfDays ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WeekDayTableViewCell", for: indexPath) as? WeekDayTableViewCell else {
            fatalError("unable to Dequeue Week Day Table View Cell")
        }
        
        guard let viewModel = viewModel else {
            fatalError("No View Model Present")
        }
        
        cell.configure(with: viewModel.viewModel(for: indexPath.row))
        
        return cell
    }
    
}
