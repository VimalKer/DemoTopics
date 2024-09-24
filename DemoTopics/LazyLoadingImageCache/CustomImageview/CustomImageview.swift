//
//  CustomImageview.swift
//  DemoTopics
//
//  Created by Apple on 24/09/24.

//TODO: - Custom imageCache Load Image from Cache Memory

import UIKit


class CustomImageview :UIImageView{
    
    var task:URLSessionDataTask!
    var imageCache =  NSCache<AnyObject, AnyObject>()
    
    func loadingImages(url:URL){
        self.image =  UIImage(named: "Placeholder")
        
        //MARK: -if task then task will cancel and start next task
        if let task = task{
            task.cancel()
        }
        
        //TODO: - If image From Cache Find then It will set image and Return not call other code
        if let imageFromCache =  imageCache.object(forKey: url.absoluteString as AnyObject)as? UIImage{
            self.image =  imageFromCache
            return
        }
        
        task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data,let myImage = UIImage(data: data)  else {
                print("Could not load image from url \(url)")
                return
            }
        
            self.imageCache.setObject(myImage, forKey: url.absoluteString as AnyObject)
            DispatchQueue.main.async {
                self.image = myImage
            }
        }
        task.resume()
       
    }
}
