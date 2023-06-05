//
//  CollectionListController.swift
//  ListController
//
//  Created by Aaron on 2021/5/13.
//

import UIKit
import CPFListController_Foundation

public class CollectionListController<Item>: ListController<Item, UICollectionView> {
    override class func target(of feature: ListFeature) -> AnyObject? {
        switch feature {
        case .base:
            return CollectionBaseTarget()
        case .selectable:
            return CollectionSelectableTarget()
        case .supplementary:
            return CollectionSupplementaryTarget()
        case .layout:
            return CollectionLayoutTarget()
        case .scrollable:
            return ScrollableTarget()
        case .custom(_, let closour):
            return closour?()
        default:
            break
        }
        return nil
    }
    
    public override var shouldReLink: Bool {
        didSet {
                reLink()
        }
    }
}
