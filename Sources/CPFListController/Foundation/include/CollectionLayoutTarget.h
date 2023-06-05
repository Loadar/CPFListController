//
//  CollectionLayoutTarget.h
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import <UIKit/UIKit.h>
#import "AnyLayoutTarget.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionLayoutTarget : NSObject<AnyLayoutTarget>

/// cell尺寸
@property (nonatomic, copy, nullable) CGSize (^cellSizeProviding)(NSIndexPath *_Nonnull);
/// section的insets
@property (nonatomic, copy, nullable) UIEdgeInsets (^sectionInsetsProviding)(NSInteger);
/// 指定section内最小行间距
@property (nonatomic, copy, nullable) CGFloat (^lineSpacingProviding)(NSInteger);
/// 指定section内最小cell间距
@property (nonatomic, copy, nullable) CGFloat (^interitemSpacingProviding)(NSInteger);
/// 指定section的header尺寸
@property (nonatomic, copy, nullable) CGSize (^headerSizeProviding)(NSInteger);
/// 指定section的footer尺寸
@property (nonatomic, copy, nullable) CGSize (^footerSizeProviding)(NSInteger);


@end

NS_ASSUME_NONNULL_END
