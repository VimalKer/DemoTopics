//
//  LazyLoadingAsyncVC.swift
//  DemoTopics
//
//  Created by Apple on 24/09/24.


//https://picsum.photos/v2/list?page=2&limit=100

import UIKit


class LazyLoadingAsyncVC: UIViewController {
    
    @IBOutlet weak var collectionImages: UICollectionView!
    
    var arrURLs = [UIImage]()
    let strlURL = "https://picsum.photos/v2/list?page=2&limit=100"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIHelper.sharedInstance.getImagesData()
        
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
extension LazyLoadingAsyncVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
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
