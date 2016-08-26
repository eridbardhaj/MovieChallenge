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
    // Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    // Vars
    let disposeBag = DisposeBag()
    let viewModel = SearchMovieViewModel(baseRequest: MovieRequest.Search(query: "", page: 1))
    var latestMovieName: Observable<String> {
        return searchBar
            .rx_text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .filter { $0.characters.count > 0 }
            .distinctUntilChanged()
    }
    
    // MARK - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        tableView
            .rx_itemSelected
            .subscribeNext { indexPath in
                if self.searchBar.isFirstResponder() == true {
                    self.view.endEditing(true)
                }
            }
            .addDisposableTo(disposeBag)
    }
    
    func setupTableView() {
        tableView.dataSource = nil
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
