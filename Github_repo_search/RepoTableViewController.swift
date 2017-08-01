//
//  RepoTableViewController.swift
//  Github_repo_search
//
//  Created by YUHUI ZHENG on 2017/07/30.
//  Copyright © 2017 YUHUI ZHENG. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RepoTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: Properties
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTable: UITableView!
    
    // basic part of URL
    let baseURL = "https://api.github.com/search/repositories?q="
    
    // search keyword
    var keyword : String!
    
    // search parameter
    var sortp : String!
    
    // the array of repo
    var repos = [Repo]()
    
    // timer for smooth search behavior
    let timerInterval = 1.0
    var timer : Timer!
    var timeCount = 0
    var preKeyword: String!
    var preSortp: String!
    
    // URL sent to InfoView
    var url: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the search bar’s user input through delegate callbacks.
        searchBar.delegate = self
        
        // Initialize search bar: keyword and parameters
        keyword = "haveFun"
        preKeyword = "haveFun"
        sortp = ""
        preSortp = ""
        searchBar.selectedScopeButtonIndex = 0
        
        // Initialize Timer
        timer = Timer.scheduledTimer(timeInterval: timerInterval, target: self, selector: #selector(self.timeEvent), userInfo: nil, repeats: true)
        
        // Load th sample data
        loadSampleRepos()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RepoTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RepoTableViewCell else {
            fatalError("The duqueued cell is not an instance of RepoTableViewCell.")
        }
        
        let repo = repos[indexPath.row]
        
        cell.nameLabel.text = repo.name
        cell.desLabel.text = repo.description
        cell.starLabel.text = String(repo.starCount)
        cell.forkLabel.text = String(repo.forkCount)

        return cell
    }
    
    // Test: Get the url of Repo Cell selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(repos[indexPath.row].url)
    }

    
    // Hide the keyboard when scroll the table view
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.resignFirstResponder()
    }
    
    
    // MARK: Timer event
    
    func timeEvent() {
        
        // Check: keyword change or not within this timer interval
        if preKeyword != keyword || preSortp != sortp {
            preKeyword = keyword
            preSortp = sortp
            self.search(keyword: keyword, sort: sortp)
            print("now search")
        }
    }
    
    
    // MARK: UISearchBarDelegate
    
    // get text changed
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if !searchText.isEmpty {
            keyword = searchText
            print(keyword)
        } else {
            print("Nothing inputed")
        }
    }
    
    // get scope index changed
    @objc(searchBar:selectedScopeButtonIndexDidChange:) func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
        guard let sort = searchBar.scopeButtonTitles?[selectedScope] else {
            fatalError("Unable to get sort parameter.")
        }
        if sort == "default" {
            self.sortp = ""
        } else {
            self.sortp = sort
        }
    }
    
    
    // MARK: Navigation
    
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller
        if(segue.identifier == "sendURL") {
            // Get targetView and Index of cell selected
            if let infoView: InfoViewController = segue.destination as? InfoViewController,
                let repoIndex = tableView.indexPathForSelectedRow?.row {
                
                // send URL to infoView
                infoView.paramURL = repos[repoIndex].url
            }
        }
    }


    // MARK: Private Methods
    
    // Load Sample
    private func loadSampleRepos() {
        
        guard let repo1 = Repo(name: "repo01", owner: "univoid", des: "testtest", star: 0, fork:0, url: "https://github.com/univoid/Github_repo_search") else {
            fatalError("Unable to instantiate repo1")
        }
        guard let repo2 = Repo(name: "repo02", owner: "wantedly", des: "testtest", star: 99, fork:0, url: "https://github.com/univoid/Github_repo_search") else {
            fatalError("Unable to instantiate repo2")
        }
        guard let repo3 = Repo(name: "repo03", owner: "God", des: "testtesttest", star: 98, fork: 42, url: "https://github.com/univoid/Github_repo_search") else {
            fatalError("Unable to instantiate repo3")
        }
        
        repos += [repo1, repo2, repo3]
    }
    
    // Get search result as array of Repo by using Github API
    private func search(keyword: String, sort: String) {
        
        // Request urbaseURL + keywordl
        var url = baseURL + keyword
        if !sort.isEmpty {
            url += "&sort=" + sort
        }
        
        // Get response by Alamofire
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.createRepos(json: json)
                // Reload table view
                self.searchTable.reloadData()
            case .failure(let error):
                print(error)
            }
        }

    }
    private func createRepos(json: JSON) {
        
        // Clear the repos array
        repos.removeAll()
        
        // Iterate
        for (_, subJson) in json["items"] {
            
            // Value check
            guard let name = subJson["name"].string else {
                fatalError("Name error")
            }
            
            guard let owner = subJson["owner"]["login"].string else {
                fatalError("Owner error")
            }
            
            guard let star = subJson["stargazers_count"].int else {
                fatalError("Star error")
            }
            
            guard let fork = subJson["forks_count"].int else {
                fatalError("Fork error")
            }
            
            guard let url = subJson["html_url"].string else {
                fatalError("URL error")
            }
            
            // nil is allowed
            let des = subJson["description"].string
            

            // Append new Repo instance to repos
            guard let repo = Repo(name: name, owner: owner, des: des, star: star, fork: fork, url: url) else {
                fatalError("Unable to instantiate Repo")
            }
            repos.append(repo)

        }
    }
    

}
