//
//  TableBaseTarget.h
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import <UIKit/UIKit.h>
#import "BaseTarget.h"

NS_ASSUME_NONNULL_BEGIN

@interface TableBaseTarget : BaseTarget

/// 配置指定indexPath的cell(UITableView)
@property (nonatomic, copy, nullable) void (^cellConfiguring)(NSIndexPath *_Nonnull, UITableViewCell *_Nonnull);

@end

NS_ASSUME_NONNULL_END
