//
//  ViewController.swift
//  PickzySoftTest
//
//  Created by Logesh on 30/12/17.
//  Copyright © 2017 Logesh. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var array2 = [String]()
    @IBOutlet weak var collectionShow: UICollectionView!
    final let url = URL(string: "dsdds")
    
    let elements = ["11","22","11","22","11","22","11","22","11","22"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "http://temp1.pickzy.com/interview_pickzy/interview.json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("errorrrrr")
            }
            else{
                if let mydata = data {
                    do{
                        let myJson = try JSONSerialization.jsonObject(with: mydata, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                        print("eeeeeee",myJson)                        
                        let jsonArray = myJson?.value(forKey: "Item") as? NSDictionary
                        if let jsonNxt = jsonArray!.value(forKey: "Content") as? NSArray
                        {
                            for json in jsonNxt{
                                if let jsonDict = json as? NSDictionary{
                                    if let name = jsonDict.value(forKey: "URL"){
                                        self.array2.append(name as! String)
                                    }
                                    OperationQueue.main.addOperation({
                                        self.collectionShow.reloadData()
                                    })
                                }
                            }
                        }
                        print("werrrrrr",self.array2)
                    }catch{
                    }     //catch error
                }
            }
        }
        task.resume()
    }
    
    

        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return array2.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath)as! CustomCollectionViewCell
            
            let imgURL = NSURL(string: array2[indexPath.row])
            
            if imgURL != nil {
                let datas = NSData(contentsOf: (imgURL as URL?)!)
                cell.customImage.image = UIImage(data: datas! as Data)
                cell.customImage.layer.cornerRadius = cell.customImage.frame.height/2
            }
            return cell
        }
    
}



