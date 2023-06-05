//
//  TableSupplementaryTarget.m
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import "TableSupplementaryTarget.h"

@implementation TableSupplementaryTarget

@synthesize headerConfiguring;
@synthesize footerConfiguring;

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    return @[
        NSStringFromSelector(@selector(tableView:viewForHeaderInSection:)),
        NSStringFromSelector(@selector(tableView:viewForFooterInSection:))
    ];
}

// MARK: - UITableView
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.headerConfiguring == nil) {
        return nil;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    NSString *identifier = [self headerIdentifierAt:indexPath];
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (self.headerConfiguring != nil && header != nil) {
        self.headerConfiguring(indexPath, header);
    }
    return header;

}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.footerConfiguring == nil) {
        return nil;
    }
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
    NSString *identifier = [self footerIdentifierAt:indexPath];
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (self.footerConfiguring != nil && footer != nil) {
        self.footerConfiguring(indexPath, footer);
    }
    return footer;
}

@end
