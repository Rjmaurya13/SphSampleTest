//
//  SPHDataViewController.swift
//  SPHSampleTest
//
//  Created by Rajeshkumar on 12/8/20.
//  Copyright © 2020 rajesh. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol SPHDataProtocol: class {
    func displayMobileData(viewModel: [SPHDataViewModel])
}
class SPHDataViewController: UITableViewController, SPHDataProtocol {
    var interactor: MobileDataDetailsBusinessLogic?
    var router: (NSObjectProtocol & SPHDetailsRoutingLogic & SPHDetailsDataPassing)?
    var postData: [SPHDataViewModel]?
    
    private func setup() {
        
        let viewController = self
        let interactor = MobileDataInteractor()
        let presenter = MobileDataPresenter()
        let router = SPHDataRouter()
        viewController.interactor = interactor
        viewController.router = router as? (NSObjectProtocol & SPHDetailsDataPassing & SPHDetailsRoutingLogic)
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        self.tableView.register(SPHDataTableViewCell.nib, forCellReuseIdentifier: SPHDataTableViewCell.reuseIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        let refreshControl = UIRefreshControl()
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl = refreshControl
        } else {
            self.tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        self.fetchMobileData()
        navigationItem.title = "Mobile Data Usage"
        
    }
    func fetchMobileData()  {
        let request = SPHDataModel.Data.Request()
        interactor?.fetchMobileData(request: request)
        refreshControl?.endRefreshing()
    }
    
    func displayMobileData(viewModel: [SPHDataViewModel]) {
        postData = viewModel
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
            self.tableView.reloadData()
        }
    }
    
    @objc func refreshData() {
        self.postData?.removeAll()
        tableView.reloadData()
        self.fetchMobileData()
    }
}
extension SPHDataViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.postData?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SPHDataTableViewCell.reuseIdentifier, for: indexPath) as? SPHDataTableViewCell  else {
            return UITableViewCell()
        }
        cell.delegate = self
        if let data = self.postData?[indexPath.row] {
            cell.ConfigureCellWithData(data: data)
        }
        return cell
    }
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension SPHDataViewController: SPHDataTableViewCellDelegate {
    func showPopUpWithMessage() {
        let alert = UIAlertController(title: "Alert", message: "Decrease in volume data.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.view.window?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}
