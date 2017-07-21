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
        
        patient1 = "TestFamilyID" //NSUUID().uuidString
        var human2 = "human2" //NSUUID().uuidString
        var human3 = "human3" //NSUUID().uuidString
        
        let familyTree2: Parameters =
            [patient1:[
                patient1:
                    [
                        "id": patient1,
                        "patientID": patient1,
                        "name": "Benjamin",
                        "dob": "10/10/198", //"1981",
                        "gender": "male",  //"male"
                        "twin" : true,
                        "adopted" : true,
                        "heightCM" : 1.83,//1.83,
                        "weightKG" : 80,//80 ,
                        "ethnicity" : "Caucasion",
                        "showDiseaseInfoToFamily" : true,
                        "smoker" : false,
                        "workout" : true,
                        "partners": [],
                        "parents": ["human2", "human3"],
                        "siblings": [],
                        "children": []
                ],
                human2:
                    [
                        "id": human2,
                        "name": "Ton",
                        "patientID": patient1,
                        "children": [patient1]
                ],
                human3:
                    [
                        "id": human3,
                        "name": "Ton",
                        "patientID": patient1,
                        "children": [patient1]
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
        let id = "TestFamilyID"//getID.text ?? "1"
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
        let id = "TestFamilyID"//getID.text ?? "1"
        print(id)
        let nametochange = editName.text ?? "ben"
/*
         "id": patient1,
         "patientID": patient1,
         "name": "Benjamin",
         "dob": "10/10/198", //"1981",
         "gender": "male",  //"male"
         "twin" : true,
         "adopted" : true,
         "heightCM" : 1.83,//1.83,
         "weightKG" : 80,//80 ,
         "ethnicity" : "Caucasion",
         "showDiseaseInfoToFamily" : true,
         "smoker" : false,
         "workout" : true,
         "partners": ["id1":"id2" , "id":"id3"],
         "parents": ["id1":"id2" , "id":"id3"],
         "siblings": ["id4":"id2" , "id6":"id3"],
         "children": ["id5":"id2" , "id7":"id3"]
 */
        let humanUpdate: Parameters = [
            "name": nametochange,
            "dob": "10/10/198", //"1981",
            "gender": "male"  //"male"
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
