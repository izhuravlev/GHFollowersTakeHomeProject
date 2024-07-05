//
//  UIHelper.swift
//  TakeHomePrep
//
//  Created by Ilya Zhuravlev on 2024-06-22.
//

import UIKit

enum UIHelper {

    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                   = view.bounds.width
        let padding: CGFloat        = 12
        let minItemSpacing: CGFloat = 10
        let availableWidth: CGFloat = width - (padding * 2) - (minItemSpacing * 2)
        let itemWidth: CGFloat      = availableWidth / 3

        let flowLayout              = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)

        return flowLayout
    }
}
