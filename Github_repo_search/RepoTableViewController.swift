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
    
    // basic part of URL
    let baseURL = "https://api.github.com/search/repositories?q="
    // the array of repo
    var repos = [Repo]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Handle the search bar’s user input through delegate callbacks.
        searchBar.delegate = self
        
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

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        
        if !searchText.isEmpty {
            print(searchText)
            if searchText.characters.count > 5 {
                
                // make request url
                let url = baseURL + searchText
                
                // get response by Alamofire
                Alamofire.request(url, method: .get).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        print("JSON: \(json)")
                    case .failure(let error):
                        print(error)
                    }
                }
            }
            
        } else {
            print("Nothin inputed")
        }
    }


    // MARK: Private Methods
    
    private func loadSampleRepos() {
        
        guard let repo1 = Repo(name: "repo01", owner: "univoid", des: "testtest", star: 0) else {
            fatalError("Unable to instantiate repo1")
        }
        guard let repo2 = Repo(name: "repo02", owner: "wantedly", des: "testtest", star: 0) else {
            fatalError("Unable to instantiate repo2")
        }
        guard let repo3 = Repo(name: "repo03", owner: "God", des: "testtesttest", star: 0) else {
            fatalError("Unable to instantiate repo3")
        }
        
        repos += [repo1, repo2, repo3]
    }
    
    

}
