import Foundation
import UIKit

protocol HorizontalScrollerLayoutDelegate {
    func horizontalScrollerItemSize() -> CGSize
}


class HorizontalScrollerLayout: UICollectionViewLayout {

    var delegate: HorizontalScrollerLayoutDelegate!
    var cellPadding: CGFloat = 10.0
    var itemSize: CGSize {
        return delegate.horizontalScrollerItemSize()
    }
    
    // MARK: Private - Computed properties
    
    private var numOfItems: CGFloat {
       return CGFloat(collectionView!.numberOfItemsInSection(0))
    }
    
    private var collectionViewWidth: CGFloat {
        return collectionView!.frame.width
    }
    
    private var contentHeight: CGFloat {
        return collectionView!.frame.height
    }
    
    private var contentWidth: CGFloat {
        return contentInset.left + (numOfItems * itemSize.width) + aggregateCellPaddingWidth + contentInset.right
    }
    
    private var aggregateCellPaddingWidth: CGFloat {
        return numOfItems > 1 ? (numOfItems - 1) * cellPadding : 0.0
    }
    
    private var contentInset = UIEdgeInsetsZero
    
    // MARK: Private - Variables
    
    private var cache = [UICollectionViewLayoutAttributes]()
    
    // MARK: UICollectionViewLayout

    override func prepareLayout() {
        if cache.isEmpty {
            
            var xOffsets = [CGFloat]()
            let yOffset = (contentHeight - itemSize.height) / 2
            
            // we're dealing with only one section laid out horizontally
            let numItems = collectionView!.numberOfItemsInSection(0)
            print("numItems: \(numItems)")
            
            for index in 0..<numItems {
                print("iter index: \(index)")
                var currentXOffset = index == 0 ? 0.0 : CGFloat(index) * itemSize.width

                // apply interitem spacing
                let innerRange = Range<Int>(start: 1, end: numItems)
                if innerRange.contains(index) {
                    currentXOffset += (cellPadding * CGFloat(index))
                }
                
                print("index: \(index) with xOffset: \(currentXOffset)")
                xOffsets.append(currentXOffset)
                
                // get the index path to look up cell
                let indexPath = NSIndexPath(forItem: index, inSection: 0)
                let frame = CGRectMake(xOffsets[index], yOffset, itemSize.width, itemSize.height)
                
                let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
                attributes.frame = frame
                cache.append(attributes)
            }
            
            
            // calculate the insets
            var contentInset: UIEdgeInsets = UIEdgeInsetsZero
            if contentWidth < collectionViewWidth {
                let inset = (collectionViewWidth - contentWidth) / 2
                contentInset.left = inset
                contentInset.right = inset
            }
            collectionView!.contentInset = contentInset
            print("contentWidth: \(contentWidth)")
            print("collectionViewWidth: \(collectionViewWidth)")
            print("content insets: \(contentInset)")
        }
    }

    override func collectionViewContentSize() -> CGSize {
        return CGSizeMake(contentWidth, contentHeight)
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if CGRectIntersectsRect(attributes.frame, rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    override func initialLayoutAttributesForAppearingItemAtIndexPath(itemIndexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
    
    override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        return nil
    }
}