//
//  QosImageLoadingVC.swift
//  DemoTopics
//
//  Created by Apple on 20/09/24.
//

import UIKit

class ImagesCVC:UICollectionViewCell{
    
    @IBOutlet weak var imgQOS: UIImageView!
    
}
class QosImageLoadingVC: UIViewController {
    
    @IBOutlet weak var collectionImages: UICollectionView!
    
    var arrURLs = [UIImage]()
    let strlURL = "https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //It will Crash when value is more
        for _ in 0...50{
            downloadingWithURlSesstion()
        }
       // downloadingWithURlSesstion()
    }
    //MARK: - downloadingWithURlSesstion Networking code \\ utlity use
    private func downloadingWithURlSesstion(){
        
        DispatchQueue.global(qos: .utility).async {[weak self] in
            
            //MARK: - Perform your work here
            URLSession.shared.dataTask(with: URL(string: self!.strlURL)!){
                [weak self] data, response ,error in
                guard let self = self,
                      let data = data,
                      let image  = UIImage(data: data) else {
                    return
                }
                self.arrURLs.append(image)
                
                DispatchQueue.main.async{
                    self.collectionImages.reloadData()
                }
                
            }.resume()
            
        }
    }
}
//MARK: - UICollectionViewDelegate UICollectionViewDataSource
extension QosImageLoadingVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionImages.dequeueReusableCell(withReuseIdentifier: "ImagesCVC", for: indexPath)as! ImagesCVC
        cell.layer.shouldRasterize =  true
        cell.layer.rasterizationScale = UIScreen.main.scale
        cell.imgQOS.image =    arrURLs[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionImages.frame.size.width / 2.0 - 8, height: collectionImages.frame.size.width / 2.0 - 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


//MARK: - LOAD DATA JSON USING DECODABLE AND PARSE Using URLSession
/*
 struct TestModel: Decodable {
     var name: String
 }

 loadRemoteJSON("urlstring") { (data: TestModel) in
     print(data.name)
 }
 
func loadRemoteJSON<T: Decodable>(_ urlString: String, completion: @escaping  ((T) -> Void)) {
    let data: Data
    
    guard let url = URL(string: urlString) else {
        fatalError("Invalid URL")
    }
    
    let request = URLRequest(url: url)
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            fatalError(error?.localizedDescription ?? "Unknown Error")
        }
        
        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(T.self, from: data)
            completion(data)
        } catch {
            fatalError("Couldn't parse data from \(urlString)\n\(error)")
        }
    }
}
 */
