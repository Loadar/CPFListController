//
//  AnySelectableTarget.h
//  ListModelTest
//
//  Created by Aaron on 2021/5/14.
//

#import <UIKit/UIKit.h>
#import "AnyTarget.h"

#ifndef AnySelectableTarget_h
#define AnySelectableTarget_h

@protocol AnySelectableTarget <AnyTarget>

/// 列表项是否可高亮，影响item是否可选中，未指定时默认可高亮
@property (nonatomic, copy, nullable) BOOL (^itemShouldHighlight)(NSIndexPath *_Nonnull);

/// 列表项已高亮
@property (nonatomic, copy, nullable) void (^itemDidHighlight)(NSIndexPath *_Nonnull);

/// 列表项已结束高亮
@property (nonatomic, copy, nullable) void(^itemDidUnhighlight)(NSIndexPath *_Nonnull);

/// 列表项是否可选中
@property (nonatomic, copy, nullable) BOOL (^itemShouldSelect)(NSIndexPath *_Nonnull);
/// 列表项是否可反选
@property (nonatomic, copy, nullable) BOOL (^itemShouldDeselect)(NSIndexPath *_Nonnull);

/// 列表项已反选
@property (nonatomic, copy, nullable) void (^itemDidDeselected)(NSIndexPath *_Nonnull);

@end

#endif /* AnySelectableTarget_h */
