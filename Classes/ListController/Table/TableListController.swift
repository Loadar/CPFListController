//
//  TableListController.swift
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

import UIKit

public class TableListController<Item>: ListController<Item, UITableView> {
    override class func target(of feature: ListFeature) -> AnyObject? {
        switch feature {
        case .base:
            return TableBaseTarget()
        case .selectable:
            return TableSelectableTarget()
        case .supplementary:
            return TableSupplementaryTarget()
        case .layout:
            return TableLayoutTarget()
        case .scrollable:
            return ScrollableTarget()
        case .custom(_, let closour):
            return closour?()
        default:
            break
        }
        return nil
    }

}
