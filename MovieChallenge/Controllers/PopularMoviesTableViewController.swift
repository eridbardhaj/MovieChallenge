//
//  PopularMoviesTableViewController.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/21/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import UIKit
import RxSwift

class PopularMoviesTableViewController: UITableViewController {
    // Outlets
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    // Vars
    let disposeBag = DisposeBag()
    let viewModel = PopularMoviesViewModel(baseRequest: MovieRequest.PopularList(page: 1))
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        configureRx()
    }
    
    // MARK: - Setups
    
    func setupTableView() {
        tableView.dataSource = nil
        tableView.registerNib(UINib(nibName: String(PopularMoviesTableViewCell.self), bundle: nil), forCellReuseIdentifier: PopularMoviesTableViewCell.cellIdentifier)
    }
    
    func configureRx() {
        rx_sentMessage(#selector(UIViewController.viewWillAppear(_:)))
            .map { _ in () }
            .bindTo(viewModel.refreshTrigger)
            .addDisposableTo(disposeBag)
        
        tableView.rx_reachedBottom
            .bindTo(viewModel.loadNextPageTrigger)
            .addDisposableTo(disposeBag)
        
        viewModel.loading.asDriver()
            .drive(indicatorView.rx_animating)
            .addDisposableTo(disposeBag)
        
        viewModel.elements.asDriver()
            .drive(tableView.rx_itemsWithCellIdentifier(PopularMoviesTableViewCell.cellIdentifier, cellType: PopularMoviesTableViewCell.self)) { _, movie, cell in
                cell.updateUI(movie)
            }
            .addDisposableTo(disposeBag)
    }
}

extension PopularMoviesTableViewController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
