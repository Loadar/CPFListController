//
//  CollectionBaseTarget.h
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import <UIKit/UIKit.h>
#import "BaseTarget.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionBaseTarget : BaseTarget

/// 配置指定indexPath的cell(UICollectionView)
@property (nonatomic, copy, nullable) void (^cellConfiguring)(NSIndexPath *_Nonnull, UICollectionViewCell *_Nonnull);

@end

NS_ASSUME_NONNULL_END
