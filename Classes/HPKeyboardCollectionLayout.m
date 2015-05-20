//
//  HPKeyboardCollectionLayout.m
//  HPKeyboard
//
//  Created by Huy Pham on 1/16/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#import "HPKeyboardCollectionLayout.h"

@interface HPKeyboardCollectionLayout ()

@property (nonatomic, readonly) CGSize pageSize;
@property (nonatomic, readonly) CGSize avaliableSizePerPage;
@property (nonatomic, readonly) NSInteger numberOfItems;
@property (nonatomic, readonly) NSInteger numberOfItemsPerPage;
@property (nonatomic, readonly) NSInteger numberOfRowsPerPage;
@property (nonatomic, readonly) NSInteger numberOfItemsPerRow;


@end

@implementation HPKeyboardCollectionLayout

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (void)commonInit {
    _sectionInset = UIEdgeInsetsMake(30, 0, 0, 0);
    _itemSize = CGSizeMake(320/7.0, 146/3.0);
    _columSpacing = 0;
    _lineSpacing = 0;
}

- (CGSize)pageSize {
    return self.collectionView.bounds.size;
}

- (CGSize)avaliableSizePerPage {
    return CGSizeMake(self.pageSize.width - self.sectionInset.left - self.sectionInset.right,
                      self.pageSize.height - self.sectionInset.top - self.sectionInset.bottom);
}

- (NSInteger)numberOfItems {
    return [self.collectionView.dataSource collectionView:self.collectionView
                                   numberOfItemsInSection:0];
}

- (NSInteger)numberOfItemsPerPage {
    
    return self.numberOfItemsPerRow*self.numberOfRowsPerPage;
}

- (NSInteger)numberOfRowsPerPage {
    return floor((self.avaliableSizePerPage.height + self.lineSpacing)/(self.itemSize.height + self.lineSpacing)) ?: 1;
}

- (NSInteger)numberOfItemsPerRow {
    return floor((self.avaliableSizePerPage.width + self.columSpacing)/(self.itemSize.width + self.columSpacing)) ?: 1;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (CGSizeEqualToSize(self.collectionView.bounds.size, newBounds.size)) {
        return NO;
    }else{
        return YES;
    }
}

- (CGSize)collectionViewContentSize {
    CGFloat width = ceil((float)self.numberOfItems/self.numberOfItemsPerPage)*self.pageSize.width;
    CGFloat height = self.pageSize.height;
    return CGSizeMake(width, height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index    = indexPath.row;
    NSInteger page     = floor((float)index/self.numberOfItemsPerPage);
    NSInteger row      = floor((float)(index % self.numberOfItemsPerPage)/self.numberOfItemsPerRow);
    NSInteger rowIndex = index%self.numberOfItemsPerRow;
    CGRect    frame    = CGRectMake(page*self.pageSize.width + self.sectionInset.left + rowIndex*(self.itemSize.width + self.columSpacing),
                                    self.sectionInset.top + row*(self.itemSize.height + self.lineSpacing),
                                    self.itemSize.width,
                                    self.itemSize.height);
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    [attributes setFrame:frame];
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *array = [NSMutableArray array];
    for (int i=0; i<self.numberOfItems; i++){
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:i
                                                                                                                   inSection:0]];
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [array addObject:attributes];
        }
    }
    return array;
}


@end
