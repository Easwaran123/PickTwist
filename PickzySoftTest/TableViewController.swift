//
//  TableViewController.swift
//  PickzySoftTest
//
//  Created by Logesh on 31/12/17.
//  Copyright © 2017 Logesh. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 10.0, *)
class TableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var people = [Person]()
    var arrayName = [String]()
    var arrayImg = [String]()
    var arrayTitle = [String]()
    var viewHasMovedToRight = false
   let tableElements = ["11","22","11","22","11","22","11","22","11","22"]

    @IBOutlet weak var tableShow: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // sum and sum
        let url = URL(string: "http://temp1.pickzy.com/interview_pickzy/comments_list.php")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("errorrrrr")
            }
            else{
                if let mydata = data {
                    do{
                        let myJson = try JSONSerialization.jsonObject(with: mydata, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        print("eeeeeee",myJson)
                       if let jsonArray = myJson?.value(forKey: "server_data") as? NSArray
//                        if let jsonNxt = jsonArray!.value(forKey: "Content") as? NSArray
                        {
                            for json in jsonArray{
                                if let jsonDict = json as? NSDictionary{
                                    if let name = jsonDict.value(forKey: "user_name"){
                                        self.arrayName.append(name as! String)
                                    }
                                    if let img = jsonDict.value(forKey: "comments"){
                                        self.arrayTitle.append(img as! String)
                                    }
//                                    if let img = jsonDict.value(forKey: "URL"){
//                                        self.arrayImg.append(img as! String)
//                                    }
                                    OperationQueue.main.addOperation({
                                        self.tableShow.reloadData()
                                    })
                                }
                            }
                        }
                        print("werrrrrr",self.arrayName)
                        print("werrrrrrtttt",self.arrayTitle)
//                        print("werrrrrrttttyyyyy",self.array)
                    }catch{
                    }     //catch error
                }
            }
        }
        task.resume()
        
        }
    
    
    @IBAction func onPlusTapped() {
        
        viewHasMovedToRight = true
        let alert = UIAlertController(title: "Add Person", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Title"
        }
        alert.addTextField { (textField) in
            textField.placeholder = "Body"
            textField.keyboardType = .numberPad
        }
        let action = UIAlertAction(title: "Post", style: .default) { (_) in
            let name = alert.textFields!.first!.text!
            let age = alert.textFields!.last!.text!
            let person = Person(context: PersistenceSt.context)
            person.title = name
            person.body = age
            PersistenceSt.saveContext()
            self.people.append(person)
            self.tableShow.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest: NSFetchRequest<Person> = Person.fetchRequest()
        
        do {
            let people = try PersistenceSt.context.fetch(fetchRequest)
            self.people = people
            self.tableShow.reloadData()
        } catch {}
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !viewHasMovedToRight{
        return arrayTitle.count
        }else{
        return people.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)as! CustomTableViewCell
        
        
        if viewHasMovedToRight
        {
            let person = people[indexPath.row]
            cell.customTitle.text = person.value(forKeyPath: "title") as? String
            cell.customBody.text = person.value(forKeyPath: "body") as? String
            cell.customTableImage.image = UIImage(named: tableElements[indexPath.row])
            cell.customTableImage.layer.cornerRadius = cell.customTableImage.frame.height/2
            return cell
        }
        else{
            cell.customTitle.text = arrayName[indexPath.row]
            cell.customBody.text = arrayTitle[indexPath.row]
            cell.customTableImage.image = UIImage(named: tableElements[indexPath.row])
            cell.customTableImage.layer.cornerRadius = cell.customTableImage.frame.height/2
            return cell
        }
        
}
}

