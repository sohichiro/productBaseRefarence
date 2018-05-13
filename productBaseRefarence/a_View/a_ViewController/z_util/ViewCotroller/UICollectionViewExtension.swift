//
//  UICollectionViewExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        T.register(to: self)
    }
    
    func register<T: UICollectionViewCell>(cellTypes: [T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { self.register(cellType: $0, bundle: bundle) }
    }
    
    func register<T: UICollectionReusableView>(reusableCellType:T.Type, ofKind kind: String = UICollectionElementKindSectionHeader, bundle:Bundle? = nil) {
        T.register(reusableCellType: T.self, ofKind: kind, to: self, bundle: bundle)
    }
    
    func register<T: UICollectionReusableView>(reusableCellTypes:[T.Type], ofKind kind: String = UICollectionElementKindSectionHeader, bundle:Bundle? = nil) {
        reusableCellTypes.forEach { self.register(reusableCellType: $0, ofKind:kind, bundle:bundle) }
    }
    
    func dequeReusableCell<T:UICollectionViewCell>(with type: T.Type, for indexPath:IndexPath) -> T {
        return T.dequeue(from: self, for: indexPath)
    }
    
    func dequeReusableView<T:UICollectionReusableView>(with type: T.Type, for indexPath:IndexPath, ofKind kind:String = UICollectionElementKindSectionHeader) -> T {
        return T.deque(from: self, with: T.self, for: indexPath)
    }
}
//usage
//collectionView.register(cellType: MyCell.self)
//collectionView.register(cellTypes: [MyCell1.self, MyCell2.self])
//let cell = collectionView.dequeueReusableCell(with: MyCell.self, for: indexPath)
//
//collectionView.register(reusableViewType: MyReusableView.self)
//collectionView.register(reusableViewTypes: [MyReusableView1.self, MyReusableView2.self])
//let view = collectionView.dequeueReusableView(with: MyReusableView.self, for: indexPath)

extension UICollectionViewCell {
    static func register(to collectionView:UICollectionView, bundle:Bundle? = nil) {
        let nib = UINib(nibName: self.reusableIdentifire, bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: self.reusableIdentifire)
    }
    
    static func dequeue<T:UICollectionViewCell>(from collectionView:UICollectionView, for indexPath:IndexPath) -> T {
        return collectionView.dequeueReusableCell(withReuseIdentifier: self.reusableIdentifire, for: indexPath) as! T
    }
}
//usage
//UICollectionViewCell.register(to: collectionView)
//let cell = UIcollectionViewCell.dequeue(from: collectionView for indexPath)

extension UICollectionReusableView {
    static var reusableIdentifire: String {
        return UICollectionReusableView.className
    }
    
    static func register<T: UICollectionReusableView>(reusableCellType: T.Type,
                                                      ofKind kind:String = UICollectionElementKindSectionHeader,
                                                      to collectionView: UICollectionView,
                                                      bundle:Bundle? = nil) {
        let nib = UINib(nibName: self.reusableIdentifire, bundle: bundle)
        collectionView.register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: self.reusableIdentifire)
    }
    
    static func deque<T:UICollectionReusableView>(from collectionView:UICollectionView, with type: T.Type, for indexPath: IndexPath, ofKind kind:String = UICollectionElementKindSectionHeader) -> T {
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reusableIdentifire, for: indexPath) as! T
    }
}
