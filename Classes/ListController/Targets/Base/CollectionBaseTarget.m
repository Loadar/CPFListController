//
//  CollectionBaseTarget.m
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import "CollectionBaseTarget.h"

@implementation CollectionBaseTarget

@synthesize cellConfiguring;

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    NSMutableArray<NSString *> *selectors = [[super supportedSelectors] mutableCopy];
    [selectors addObjectsFromArray:@[
        NSStringFromSelector(@selector(numberOfSectionsInCollectionView:)),
        NSStringFromSelector(@selector(collectionView:numberOfItemsInSection:)),
        NSStringFromSelector(@selector(collectionView:cellForItemAtIndexPath:)),
        NSStringFromSelector(@selector(collectionView:didSelectItemAtIndexPath:))
    ]];
    return selectors;
}

// MARK: - UICollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [self sectionCount];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self itemCountOfSection:section];
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [self cellIdentifierAt:indexPath];
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    if (self.cellConfiguring != nil) {
        self.cellConfiguring(indexPath, cell);
    }
    return  cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self itemDidSelectedAt:indexPath];
}


@end
