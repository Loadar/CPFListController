//
//  TableSelectableTarget.m
//  ListModelTest
//
//  Created by Aaron on 2021/5/14.
//

#import "TableSelectableTarget.h"

@implementation TableSelectableTarget

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    return @[
        NSStringFromSelector(@selector(tableView:shouldHighlightRowAtIndexPath:)),
        NSStringFromSelector(@selector(tableView:didHighlightRowAtIndexPath:)),
        NSStringFromSelector(@selector(tableView:didUnhighlightRowAtIndexPath:)),
        NSStringFromSelector(@selector(tableView:willSelectRowAtIndexPath:)),
        NSStringFromSelector(@selector(tableView:willDeselectRowAtIndexPath:)),
        NSStringFromSelector(@selector(tableView:didDeselectRowAtIndexPath:))
    ];
}

// MARK: - UITableView
- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self itemShouldHighlightAt:indexPath];
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    [self itemDidHighlightAt:indexPath];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    [self itemDidUnhighlightAt:indexPath];
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self itemShouldSelecttAt:indexPath] ? indexPath : nil;
}

- (nullable NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self itemShouldDeselecttAt:indexPath] ? indexPath : nil;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self itemDidDeselectedAt:indexPath];
}

@end
