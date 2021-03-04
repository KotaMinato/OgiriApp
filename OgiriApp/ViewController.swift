//
//  ViewController.swift
//  OgiriApp
//
//  Created by minato on 2021/03/04.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage
import Photos

class ViewController: UIViewController {

    
    @IBOutlet weak var odaiImageView: UIImageView!
    
    
    @IBOutlet weak var commentTextView: UITextView!
    
    
    @IBOutlet weak var searchTextFild: UITextField!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        commentTextView.layer.cornerRadius = 20.0
        
        PHPhotoLibrary.requestAuthorization { (status) in
            
            switch(status){
           
            case .authorized:
                break
            case .notDetermined:
                break
            case .restricted:
                break
            case .denied:
                break
            
            @unknown default: break
            
            
            
            
            }
        
        }
        
        getImage(keyword: "funny")
        
        
        
    }

    func getImage(keyword:String){
       
        let url = "https://pixabay.com/api/?key=20522124-02cd8f245052497f87173d683&q=\(keyword)"
        
        AF.request(url, method: .get, parameters: nil, encoding:  JSONEncoding.default).responseJSON { [self] (response) in
            
            switch response.result{
            case .success:
                let json:JSON = JSON(response.data as Any)
                var imageString = json["hits"][ self.count]["wbformatURL"].string
                
                if imageString == nil{
                    
                    imageString = json["hits"][0]["wbformatURL"].string
                
                }else{
                    
                    
                    self.odaiImageView.sd_setImage(with: URL(string: imageString!), completed: nil)
                }
                
                
                
               
                
                
            
                    case .failure(let error):
                        print("error")
            
            
            
            
            
            
            }
            
            
        }
    
    }

    
    @IBAction func nextOdai(_ sender: Any) {
   
    count = count + 1
        
        if searchTextFild.text == ""{
          
            getImage(keyword: "funny")
      
        }else{
        
            
            getImage(keyword: searchTextFild.text!)
        }
        
    





    }
    
    
    
    @IBAction func searchAction(_ sender: Any) {
    
        self.count = 0
        
        if searchTextFild.text == ""{
          
            getImage(keyword: "funny")
      
        }else{
        
            getImage(keyword: searchTextFild.text!)
        }
        
    
    
    }
    
    
    
    @IBAction func next(_ sender: Any) {
    
    performSegue(withIdentifier: "next", sender: nil)
    
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let shareVC = segue.destination as?
        ShareViewController
        shareVC?.commentString = commentTextView.text
        shareVC?.resultImage = odaiImageView.image!
    
    }
    
    
    
}

