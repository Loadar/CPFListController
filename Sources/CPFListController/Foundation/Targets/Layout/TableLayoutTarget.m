//
//  TableLayoutTarget.m
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import "TableLayoutTarget.h"

@implementation TableLayoutTarget

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    return @[
        NSStringFromSelector(@selector(tableView:heightForRowAtIndexPath:)),
        NSStringFromSelector(@selector(tableView:heightForHeaderInSection:)),
        NSStringFromSelector(@selector(tableView:heightForFooterInSection:))
    ];
}

// MARK: - UITableView
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.rowHeightProviding != nil ? self.rowHeightProviding(indexPath) : tableView.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.headerHeightProviding != nil ? self.headerHeightProviding(section) : tableView.sectionHeaderHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return self.footerHeightProviding != nil ? self.footerHeightProviding(section) : tableView.sectionFooterHeight;
}

@end
