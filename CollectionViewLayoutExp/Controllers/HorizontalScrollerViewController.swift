import Foundation
import UIKit


class HorizontalScrollerViewController: UICollectionViewController, HorizontalScrollerLayoutDelegate {
    
    // MARK: Properties
    
    var count: Int = 3
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let layout = collectionView?.collectionViewLayout as? HorizontalScrollerLayout {
            layout.delegate = self
        }
    }
    
    // MARK: UICollectionView
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TestCustomCell", forIndexPath: indexPath)
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = collectionView.collectionViewLayout as? HorizontalScrollerLayout {
        }
        return count
    }
    
    // MARK: Methods
    
    func incrementCount() {
        count++
        collectionView?.reloadData()
    }
    
    func decrementCount() {
        count++
        collectionView?.reloadData()
    }
    
    // MARK: HorizontalScrollerLayoutDelegate
    
    func horizontalScrollerItemSize() -> CGSize {
        return CGSizeMake(50.0, 50.0)
    }
}
