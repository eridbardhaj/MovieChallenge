//
//  SearchMoviesTableViewController.swift
//  MovieChallenge
//
//  Created by Erid Bardhaj on 8/26/16.
//  Copyright © 2016 trivago GmbH. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchMoviesTableViewController: UITableViewController {
    // Vars
    var searchController: UISearchController! = nil
    let disposeBag = DisposeBag()
    let viewModel = SearchMovieViewModel(baseRequest: MovieRequest.Search(query: "", page: 1))
    var latestMovieName: Observable<String> {
        return searchController
            .searchBar
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .filter { $0.characters.count >= 3 }
            .distinctUntilChanged()
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
        configureRx()
    }
    
    // MARK: - Setups
    
    func configureRx() {
        latestMovieName
            .bindTo(viewModel.query)
            .addDisposableTo(disposeBag)
        
        viewModel.elements.asDriver()
            .drive(tableView.rx_itemsWithCellIdentifier(PopularMoviesTableViewCell.cellIdentifier, cellType: PopularMoviesTableViewCell.self)) { _, movie, cell in
                cell.updateUI(movie)
            }
            .addDisposableTo(disposeBag)
        
        tableView.rx_reachedBottom
            .bindTo(viewModel.loadNextPageTrigger)
            .addDisposableTo(disposeBag)
        
        tableView
            .rx_itemSelected
            .subscribeNext { indexPath in
                if self.searchController.searchBar.isFirstResponder() == true {
                    self.view.endEditing(true)
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    func setupSearchBar() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func setupTableView() {
        tableView.dataSource = nil
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.registerNib(UINib(nibName: String(PopularMoviesTableViewCell.self), bundle: nil), forCellReuseIdentifier: PopularMoviesTableViewCell.cellIdentifier)
    }
}

extension SearchMoviesTableViewController {
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
