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

    @IBOutlet weak var getID: UITextField!
    @IBOutlet weak var postID: UITextField!
    @IBOutlet weak var outputLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func postFamily(_ sender: Any) {
        let id = postID.text ?? "1"
        let parameters: Parameters = [
            "id": id,
            "name": "ben",
            "patientID": "id1"
        ]
        //http://localhost:3000/api/savetree?treeid=1&treedata=[:]
        
        Alamofire.request("http://localhost:3000/api/savetree/",
                          method: .post,
                          parameters: parameters,
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
        let id = getID.text ?? "1"

        Alamofire.request("http://localhost:3000/api/gettree?id=\(id)").validate().responseJSON { (response) in
            switch response.result {
            case .success(let jsonData):
                if let jsonArray = response.result.value as? NSArray {
                    print("Success array for requested data \(jsonArray)")
                    if let firstElement = jsonArray[0] as? NSDictionary,
                        let dictName = firstElement["name"] {
                        print("Test getting name param: \(dictName)")
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
