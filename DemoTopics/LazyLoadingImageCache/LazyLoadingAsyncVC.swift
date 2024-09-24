//
//  LazyLoadingAsyncVC.swift
//  DemoTopics
//
//  Created by Apple on 24/09/24.


//https://picsum.photos/v2/list?page=2&limit=100

import UIKit


class LazyImagesCVC:UICollectionViewCell{
    
    @IBOutlet weak var lazyImages: CustomImageview!
    
}
class LazyLoadingAsyncVC: UIViewController {
    
    @IBOutlet weak var collectionImages: UICollectionView!
    
    var arrData  =  [ModelImages]()
    var arrURLs = [UIImage]()
   // let strlURL = "https://unsplash.com/photos/pJILiyPdrXI"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // APIHelper.sharedInstance.getImagesData()
        
        arrData.removeAll()
        
        self.loadingImages(url: URL(string: "https://picsum.photos/v2/list?page=2&limit=100")!)
    }
    //MARK: - downloadingWithURlSesstion Networking code \\ utlity use
        
    func loadingImages(url:URL){
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                print("Could not load image from url \(url)")
                return
            }
            
            do {
                var arrImages = try JSONDecoder().decode([ModelImages].self, from: data)
                print(arrImages)
                self.arrData =  arrImages
                DispatchQueue.main.async {
                    self.collectionImages.reloadData()
                }
                
                // print: 1,2,3,4,5,6,7,8,9
            }catch{
                print("Error in Serialization")
            }
            
        }
        task.resume()
        
    }
}
//MARK: - UICollectionViewDelegate UICollectionViewDataSource
extension LazyLoadingAsyncVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionImages.dequeueReusableCell(withReuseIdentifier: "LazyImagesCVC", for: indexPath)as! LazyImagesCVC
        cell.layer.shouldRasterize =  true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        if let url =  URL(string: arrData[indexPath.row].download_url){
            cell.lazyImages.loadingImages(url: url)
       }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionImages.frame.size.width / 2.0 - 8, height: collectionImages.frame.size.width / 2.0 - 8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
