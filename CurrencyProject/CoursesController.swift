//
//  CoursesController.swift
//  CurrencyProject
//
//  Created by GPM IMac on 17.02.2020.
//  Copyright © 2020 GPM IMac. All rights reserved.
//

import UIKit

class CoursesController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed"), object: nil, queue:
            nil) {
                (notification) in
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.navigationItem.title = Model.shared.currentDate
                    print("notoficationCatch")
                }
                
        }
        
        navigationItem.title = Model.shared.currentDate

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Model.shared.currencies.count
    }

//    <Valute ID="R01335">
//    <NumCode>398</NumCode>
//    <CharCode>KZT</CharCode>
//    <Nominal>100</Nominal>
//    <Name> ‡Á‡ıÒÚ‡ÌÒÍËı ÚÂÌ„Â</Name>
//    <Value>20,3393</Value>
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let courseForCell = Model.shared.currencies[indexPath.row]
        
        cell.textLabel?.text = courseForCell.Name
        cell.detailTextLabel?.text = courseForCell.Value
        // Configure the cell...

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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
