//
//  PlugsViewController.swift
//  Takehome
//
//  Created by Christelle Nieves on 8/7/21.
//

import UIKit

class PlugsViewController: UIViewController {
    
    var tableView = UITableView(frame: CGRect.zero, style: .grouped)
    let dataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainView()
        setupTableView()
        populateTableView()
    }
}

// MARK: - UI Setup

extension PlugsViewController {
    private func setupMainView() {
        title = "PLUGS"
        view.backgroundColor = UIColor.white
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CampaignCell.self, forCellReuseIdentifier: "CampaignCell")
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        
        // Constraints
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - TableView Delegate

extension PlugsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataManager.campaigns.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CampaignCell", for: indexPath) as! CampaignCell
        
        cell.setupCell(mediasData: dataManager.campaigns[indexPath.row].medias)
        cell.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: false)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = CampaignHeaderView(frame: CGRect.zero)
        
        headerView.backgroundColor = UIColor.white
        headerView.campaignData = dataManager.campaigns[section]
        headerView.setupCampaignIcon()
        headerView.setupTitleLabel()
        headerView.setupPayPerInstallLabel()
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 1/3
    }
}


// MARK: - Helper Functions

extension PlugsViewController {
    private func populateTableView() {
        dataManager.getAllCampaignsFromAPI {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

