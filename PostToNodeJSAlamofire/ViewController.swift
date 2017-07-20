//
//  ViewController.swift
//  PostToNodeJSAlamofire
//
//  Created by ben on 19/07/2017.
//  Copyright © 2017 ben. All rights reserved.
//

import UIKit
import Alamofire
class ViewController: UIViewController {

    @IBOutlet var labelCollection: [UILabel]!
    var patient1 = ""
    @IBOutlet weak var getID: UITextField!
    @IBOutlet weak var postID: UITextField!
    @IBOutlet weak var editName: UITextField!

    @IBOutlet weak var outputLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        for label in labelCollection {
            print(label.text)
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func postFamily(_ sender: Any) {
        let idFamily1 = "58EAC467-E69F-4B4F-8F7A-554D82F6371D"
              /*
        let parameters: Parameters = [
            "id": id,
            "name": "ben",
            "patientID": "id1"
        ]
 */
        var human1 = NSUUID().uuidString
        var human2 = idFamily1
        var human3 = NSUUID().uuidString

        let familyTree1: Parameters = [
            human1:
            [
                "id": human1,
                "name": "ben",
                "patientID": human2
            ],
            human2:
            [
                 "id": human2,
                 "name": "Ton",
                 "patientID": human2
            ],
            human3:
                [
                    "id": human3,
                    "name": "Ton",
                    "patientID": human2
            ]
        ]
        //http://localhost:3000/api/savetree?treeid=1&treedata=[:]
        
        Alamofire.request("http://localhost:3000/api/savetree/",
                          method: .post,
                          parameters: familyTree1,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                            switch response.result {
                            case .success(let jsonData):
                                self.outputLabel.text = "Success \(jsonData)"
                                print("Success \(jsonData)")
                            case .failure(let error):
                                self.outputLabel.text = "error \(error)"
                                print("error \(error)")
                            }
        }
        
        
        patient1 = NSUUID().uuidString
        human2 = NSUUID().uuidString
        human3 = NSUUID().uuidString
        
        let familyTree2: Parameters =
            ["familyID":[
                patient1:
                    [
                        "id": patient1,
                        "name": "ben",
                        "patientID": patient1
                ],
                human2:
                    [
                        "id": human2,
                        "name": "Ton",
                        "patientID": patient1
                ],
                human3:
                    [
                        "id": human3,
                        "name": "Ton",
                        "patientID": patient1
                ]
            ]
        ]
 

        Alamofire.request("http://localhost:3000/api/savetree/",
                          method: .post,
                          parameters: familyTree2,
                          encoding: JSONEncoding.default).responseJSON { (response) in
                            switch response.result {
                            case .success(let jsonData):
                                self.outputLabel.text = "Success \(jsonData)"
                                print("Success \(jsonData)")
                            case .failure(let error):
                                self.outputLabel.text = "error \(error)"
                                print("error \(error)")
                            }
        }
    }
    @IBAction func getFamily(_ sender: Any) {
        let id = "58EAC467-E69F-4B4F-8F7A-554D82F6371D"//getID.text ?? "1"
        print(id)
        Alamofire.request("http://localhost:3000/api/gettree?patientID=\(id)").validate().responseJSON { (response) in
            switch response.result {
            case .success(let jsonData):
                if let jsonArray = response.result.value as? NSArray {
                    print("Success array for requested data \(jsonArray)")
                    if let firstElement = jsonArray[0] as? NSDictionary,
                        let dictName = firstElement["name"],
                        let patientID = firstElement["patientID"] {
                        print("Test getting name param: \(dictName)")
                        print("Test getting patientID param: \(patientID)")

                        self.outputLabel.text = "Success array for requested data \(jsonArray)"
                    }
                } else { //else we have a dictionary...
                    print("Success dictionary for requested data \(jsonData)")
                    self.outputLabel.text = "Success dictionary for requested data \(jsonData)" 

                    
                }
            case .failure(let error):
                self.outputLabel.text = "error \(error)"
                print("error \(error)")
            }
        }
    }
    
    @IBAction func editHuman(_ sender: Any) {
        //http://localhost:3000/api/edithuman?id=58EAC467-E69F-4B4F-8F7A-554D82F6371D
        let id = "58EAC467-E69F-4B4F-8F7A-554D82F6371D"//getID.text ?? "1"
        print(id)
        let nametochange = editName.text ?? "ben"

        let humanUpdate: Parameters = [
            "name": nametochange,
        ]
        Alamofire.request("http://localhost:3000/api/edithuman?id=\(id)",
                          method: .post,
                          parameters: humanUpdate,
                          encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result {
            case .success(let jsonData):
                if let jsonArray = response.result.value as? NSArray {
                    print("Success array for requested data \(jsonArray)")
                    if let firstElement = jsonArray[0] as? NSDictionary,
                        let dictName = firstElement["name"],
                        let patientID = firstElement["patientID"] {
                        print("Test getting name param: \(dictName)")
                        print("Test getting patientID param: \(patientID)")
                        
                        self.outputLabel.text = "Success array for requested data \(jsonArray)"
                    }
                } else { //else we have a dictionary...
                    print("Success dictionary for requested data \(jsonData)")
                    self.outputLabel.text = "Success dictionary for requested data \(jsonData)"
                    
                    
                }
            case .failure(let error):
                self.outputLabel.text = "error \(error)"
                print("error \(error)")
            }
        }
    }
}
