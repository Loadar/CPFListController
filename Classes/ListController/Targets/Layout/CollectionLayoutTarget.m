//
//  CollectionLayoutTarget.m
//  ListController
//
//  Created by Aaron on 2021/5/14.
//

#import "CollectionLayoutTarget.h"

@implementation CollectionLayoutTarget

// MARK: - AnyTarget
- (nonnull NSArray<NSString *> *)supportedSelectors {
    return @[
        NSStringFromSelector(@selector(collectionView:layout:sizeForItemAtIndexPath:)),
        NSStringFromSelector(@selector(collectionView:layout:insetForSectionAtIndex:)),
        NSStringFromSelector(@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)),
        NSStringFromSelector(@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)),
        NSStringFromSelector(@selector(collectionView:layout:referenceSizeForHeaderInSection:)),
        NSStringFromSelector(@selector(collectionView:layout:referenceSizeForFooterInSection:))
    ];
}

// MARK: - UICollectionView
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellSizeProviding != nil) {
        return self.cellSizeProviding(indexPath);
    }
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    if (layout != nil && [layout respondsToSelector:@selector(itemSize)]) {
        return layout.itemSize;
    }
    return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (self.sectionInsetsProviding != nil) {
        return self.sectionInsetsProviding(section);
    }
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    if (layout != nil && [layout respondsToSelector:@selector(sectionInset)]) {
        return layout.sectionInset;
    }
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.lineSpacingProviding != nil) {
        return self.lineSpacingProviding(section);
    }
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    if (layout != nil && [layout respondsToSelector:@selector(minimumLineSpacing)]) {
        return layout.minimumLineSpacing;
    }
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (self.interitemSpacingProviding != nil) {
        return self.interitemSpacingProviding(section);
    }
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    if (layout != nil && [layout respondsToSelector:@selector(minimumInteritemSpacing)]) {
        return layout.minimumInteritemSpacing;
    }
    return 0;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (self.headerSizeProviding != nil) {
        return self.headerSizeProviding(section);
    }
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    if (layout != nil && [layout respondsToSelector:@selector(headerReferenceSize)]) {
        return layout.headerReferenceSize;
    }
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (self.footerSizeProviding != nil) {
        return self.footerSizeProviding(section);
    }
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)collectionView.collectionViewLayout;
    if (layout != nil && [layout respondsToSelector:@selector(footerReferenceSize)]) {
        return layout.footerReferenceSize;
    }
    return CGSizeZero;
}

@end
