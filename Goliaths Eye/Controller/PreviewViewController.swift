//
//  PreviewViewController.swift
//  Goliaths Eye
//
//  Created by HaiDer's Macbook Pro on 19/08/2022.
//

import UIKit
import SDWebImage

class PreviewViewController: BaseViewController {
    
    
    //MARK: - Variables
    
    var userScreenShots : [UserScreenShotData]?
    var index = 0
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var screenShotLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.reloadData()
        self.countLbl.text = "\((1))/\(self.userScreenShots?.count ?? 1)"
        self.screenShotLbl.text = "ScreenShot-1"
        DispatchQueue.main.async {
            self.countLbl.text = "\((self.index+1))/\(self.userScreenShots?.count ?? 1)"
            self.screenShotLbl.text = "ScreenShot-\(self.index+1)"
            self.collectionView.scrollToItem(at: IndexPath(item: self.index, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
    
    
    //MARK: - IBAction
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //MARK: - Functions
    

}

extension PreviewViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.userScreenShots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.register(ImageCollectionViewCell.self, indexPath: indexPath)
        cell.config(url: self.userScreenShots?[indexPath.item].imagePath ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width-100), height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentCenteredPoint = CGPoint(x: collectionView.contentOffset.x + collectionView.bounds.width, y: collectionView.contentOffset.y + collectionView.bounds.height/2)
        let index = collectionView.indexPathForItem(at: currentCenteredPoint)
        if index == nil {
            self.countLbl.text = "\((self.userScreenShots?.count ?? 1))/\(self.userScreenShots?.count ?? 1)"
            self.screenShotLbl.text = "ScreenShot-\(self.userScreenShots?.count ?? 1)"
        }
        else {
            self.countLbl.text = "\((index?.item ?? 1))/\(self.userScreenShots?.count ?? 1)"
            self.screenShotLbl.text = "ScreenShot-\(index?.item ?? 1)"
        }
        
    }
    
}

