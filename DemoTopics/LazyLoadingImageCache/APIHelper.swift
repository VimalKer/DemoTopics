//
//  APIHelper.swift
//  DemoTopics
//
//  Created by Apple on 24/09/24.
//

import Foundation

struct ModelImages:Decodable{
    var id:String!
    var author:String!
    var url:String!
}


class APIHelper{
    
    static var sharedInstance  =  APIHelper()
    
    func getImagesData(){
    
        guard let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=100") else {
            return
        }
        
        
        var request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error !=  nil{
                print(data)
                
                guard data != nil else{
                    return
                }
                
                do {
                    let decoder  =  JSONDecoder()
                    let ImagesArry = try decoder.decode([ModelImages].self, from: data!)
                    print(ImagesArry)
                    // print: 1,2,3,4,5,6,7,8,9
                }catch{
                    print("Error in Serialization")
                }
            }else
            {
                print(error?.localizedDescription)
            }
        }.resume()
    }
}
