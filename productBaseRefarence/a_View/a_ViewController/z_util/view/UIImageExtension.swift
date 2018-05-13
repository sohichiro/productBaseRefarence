//
//  UIImageExtension.swift
//  productBaseRefarence
//
//  Created by 長尾聡一郎 on 2018/05/12.
//  Copyright © 2018年 Sohichiro Nagao. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    /// 特定の色で塗りつぶされたUIImageを作成
    ///
    /// - Parameters:
    ///   - color: 色
    ///   - size: サイズ
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContext(size)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else {
            self.init()
            return
        }
        
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()
        
        if let cgImage = image.cgImage {
            self.init(cgImage: cgImage)
        } else {
            self.init()
        }
    }
    /* usage
     UIImage(color: .red, size: .init(width: 100, height: 100))
     */
    
    
    /// 画像を別の色で塗りつぶす（透明色は塗りつぶさない）
    ///
    /// - Parameter color: 色
    /// - Returns: 別の色で塗りつぶされたUIImage
    func image(withTint color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        
        guard let context: CGContext = UIGraphicsGetCurrentContext(), let cgImage = cgImage else {
            return UIImage()
        }
        context.scaleBy(x: 1, y: -1)
        context.translateBy(x: 0, y: -self.size.height)
        context.clip(to: rect, mask: cgImage)
        context.setFillColor(color.cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return UIImage()
        }
        UIGraphicsEndImageContext()
        
        return image
    }
}
