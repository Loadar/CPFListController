//
//  AnyBaseTarget.h
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import <UIKit/UIKit.h>
#import "AnyTarget.h"

#ifndef AnyBaseTarget_h
#define AnyBaseTarget_h

@protocol AnyBaseTarget <AnyTarget>

/// 分段数目
@property (nonatomic, copy, nullable) NSInteger (^sectionCountProviding)(void);
/// 指定分段列表项数目
@property (nonatomic, copy, nullable) NSInteger (^itemListCountProviding)(NSInteger);
/// 指定indexPath的cell的identifier
@property (nonatomic, copy, nullable) NSString *_Nonnull(^cellIdentifierProviding)(NSIndexPath *_Nonnull);
/// 配置指定indexPath的cell(UITableView)
@property (nonatomic, copy, nullable) void (^cellConfiguring)(NSIndexPath *_Nonnull, UIView *_Nonnull);

/// 默认的cell identifier, 未指定cellIdentifierProviding时尝试使用此项的值
@property (nonatomic, copy, nullable) NSString *defaultCellIdentifier;

/// 列表项已选中
@property (nonatomic, copy, nullable) void (^itemDidSelected)(NSIndexPath *_Nonnull);

/// 列表滚动
@property (nonatomic, copy, nullable) void(^scrolled)(UIScrollView *_Nonnull);

@end


#endif /* AnyBaseTarget_h */
