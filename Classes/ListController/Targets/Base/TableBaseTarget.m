//
//  TableBaseTarget.m
//  ListModelTest
//
//  Created by Aaron on 2021/5/14.
//

#import "TableBaseTarget.h"

@implementation TableBaseTarget

@synthesize cellConfiguring;

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    NSMutableArray<NSString *> *selectors = [[super supportedSelectors] mutableCopy];
    [selectors addObjectsFromArray:@[
        NSStringFromSelector(@selector(numberOfSectionsInTableView:)),
        NSStringFromSelector(@selector(tableView:numberOfRowsInSection:)),
        NSStringFromSelector(@selector(tableView:cellForRowAtIndexPath:)),
        NSStringFromSelector(@selector(tableView:didSelectRowAtIndexPath:))
    ]];
    return selectors;
}

// MARK: - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self sectionCount];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self itemCountOfSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self cellIdentifierAt:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    if (self.cellConfiguring != nil) {
        self.cellConfiguring(indexPath, cell);
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self itemDidSelectedAt:indexPath];
}

@end
