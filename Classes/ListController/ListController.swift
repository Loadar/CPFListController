//
//  ListController.swift
//  ListController
//
//  Created by Aaron on 2021/5/13.
//

import Foundation

public class ListController<Item, ListView>: ListProxy, AnyListController {

    public var listView: ListView?
    public var itemListProviding: ((Int) -> [Item])?
    public var configurers: [AnyListComponentConfigurer] = []
    
    public var shouldReLink: Bool = false
    
    public func target<T>(of feature: ListFeature, with type: T.Type) -> T? {
        if let target = targetInfo[feature] as? T {
            return target
        } else {
            if let target = Self.target(of: feature) {
                targetInfo[feature] = target
                appendTarget(target)
                shouldReLink = true
                return target as? T
            }
            assert(false, "未找到对应的target")
            return nil
        }
    }
    
    public func isTargetExist(of feature: ListFeature) -> Bool {
        targetInfo[feature] != nil
    }
    
    class func target(of feature: ListFeature) -> AnyObject? {
        assert(false, "子类实现")
        return nil
    }

    /// feature与target的映射表
    private var targetInfo: [ListFeature: AnyObject]
    
    public init() {
        var targets = [AnyObject]()
        var info: [ListFeature: AnyObject] = [:]
        if let target = Self.target(of: .base) {
            info[.base] = target
            targets.append(target)
        }
        targetInfo = info
        
        super.init(targets: targets)
    }
}
