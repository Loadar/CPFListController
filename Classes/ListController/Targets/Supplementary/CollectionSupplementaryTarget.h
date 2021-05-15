//
//  CollectionSupplementaryTarget.h
//  ListModelTest
//
//  Created by Aaron on 2021/5/14.
//

#import <UIKit/UIKit.h>
#import "SupplementaryTarget.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionSupplementaryTarget : SupplementaryTarget

/// 配置指定indexPath的header
@property (nonatomic, copy, nullable) void (^headerConfiguring)(NSIndexPath *_Nonnull, UICollectionReusableView *_Nonnull);
/// 配置指定indexPath的header
@property (nonatomic, copy, nullable) void (^footerConfiguring)(NSIndexPath *_Nonnull, UICollectionReusableView *_Nonnull);


@end

NS_ASSUME_NONNULL_END
