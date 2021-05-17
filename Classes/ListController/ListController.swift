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
    
    public func target<T>(of feature: ListFeature, with type: T.Type) -> T? {
        if let target = targetInfo[feature] as? T {
            return target
        }
        assert(false, "未找到对应的target")
        return nil
    }
    
    class func target(of feature: ListFeature) -> AnyObject? {
        assert(false, "子类实现")
        return nil
    }

    /// feature与target的映射表
    private let targetInfo: [ListFeature: AnyObject]
    
    public init(_ features: [ListFeature] = [.base]) {
        
        var targets = [AnyObject]()
        var info: [ListFeature: AnyObject] = [:]
        
        for aFeature in features {
            guard let target = Self.target(of: aFeature) else { continue }
            info[aFeature] = target
            targets.append(target)
        }
        targetInfo = info
        
        super.init(targets: targets)
    }
}
