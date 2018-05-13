//
//  UITableViewExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        T.register(to: self, bundle: bundle)
    }
    
    func register<T: UITableViewCell>(cellTypes:[T.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    func dequeResusableCell<T: UITableViewCell>(with type:T.Type, for indexPath:IndexPath) -> T {
        return T.dequeue(from: self, for: indexPath)
    }
}
//usage
//tableView.register(cellType: MyCell.self)
//tableView.register(cellTypes: [MyCell1.self, MyCell2.self])
//
//let cell = tableView.dequeueReusableCell(with: MyCell.self, for: indexPath)

extension UITableViewCell {
    static var reusableIdentifire: String {
        return UITableViewCell.className
    }
    
    static func register(to tableView:UITableView, bundle:Bundle? = nil) {
        let nib = UINib(nibName: self.reusableIdentifire, bundle: bundle)
        tableView.register(nib, forCellReuseIdentifier: self.reusableIdentifire)
    }
    
    static func dequeue<T: UITableViewCell>(from tableView:UITableView, for indexPath:IndexPath) -> T {
        return tableView.dequeueReusableCell(withIdentifier: self.reusableIdentifire, for: indexPath) as! T
    }
}

//usage
//UITableViewCell.register(to: tableView)
//let cell = UITableViewCell.dequeue(from: tableView for indexPath)
