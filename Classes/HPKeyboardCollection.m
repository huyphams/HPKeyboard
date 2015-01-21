//
//  HPKeyboardCollection.m
//  HPKeyboard
//
//  Created by Huy Pham on 1/17/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#define KEY_CELL @"KeyCell"

#import "HPKeyboardCollection.h"

#import "HPKeyboardCollectionLayout.h"
#import "HPKeyboardCollectionCell.h"
#import "HPKeyboard.h"
#import "HPKeyboardKeyPopup.h"

@interface HPKeyboardCollection () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) HPKeyboardCollectionLayout *keyboardCollectionLayout;

@end

@implementation HPKeyboardCollection {
    
    HPKeyboardKeyPopup *_keyPopup;
    UIButton *_barButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    HPKeyboardCollectionLayout *keyboardCollectionLayout = [[HPKeyboardCollectionLayout alloc] init];
    _keyboardCollectionLayout = keyboardCollectionLayout;
    if (!(self = [super initWithFrame:frame collectionViewLayout:keyboardCollectionLayout])) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (void)commonInit {
    
    [self setDelegate:self];
    [self setDataSource:self];
    [self setShowsHorizontalScrollIndicator:NO];
    [self setShowsVerticalScrollIndicator:NO];
    [self setPagingEnabled:YES];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setAutoresizingMask:(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)];
    
    [self setFrame:(CGRect){0, 0, HPKeyboardDefaultSize.width, HPKeyboardDefaultSize.height-HPKeyboardTabDefaultHeight}];
    [self registerClass:[HPKeyboardCollectionCell class] forCellWithReuseIdentifier:KEY_CELL];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.bounds), 20)];
    [_pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
    [_pageControl setCurrentPageIndicatorTintColor:UIColorFromRGB(0x1C6CB5)];
    [_pageControl setBackgroundColor:[UIColor clearColor]];
    [_pageControl setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin];
    [_pageControl setUserInteractionEnabled:NO];
    
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, CGRectGetWidth(self.bounds), 20)];
    [_title setBackgroundColor:[UIColor clearColor]];
    [_title setTextColor:[UIColor grayColor]];
    [_title setTextAlignment:NSTextAlignmentCenter];
    [_title setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    
    _barButton = [[UIButton alloc] init];
    [_barButton setContentMode:UIViewContentModeScaleAspectFit];
    [_barButton addTarget:self action:@selector(barButtonDidWhenTouchDown:) forControlEvents:UIControlEventTouchDown];
    
    // Long touch.
    UILongPressGestureRecognizer *longTouch = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(handleLongTouch:)];
    [longTouch setMinimumPressDuration:0.09];
    [self addGestureRecognizer:longTouch];
    
    [self addSubview:_title];
    _keyPopup = [[HPKeyboardKeyPopup alloc] init];
}

- (void)barButtonDidWhenTouchDown:(UIButton *)button {
    
    if ([self.collectionDelegate respondsToSelector:@selector(collectionBarButtonPressed:)]) {
        [self.collectionDelegate collectionBarButtonPressed:button];
    }
}

- (void)handleLongTouch:(UILongPressGestureRecognizer *)gestureRecognizer {
    
    CGPoint touchedLocation = [gestureRecognizer locationInView:self];
    NSIndexPath *touchedIndexPath = [self indexPathForItemAtPoint:touchedLocation];
    HPKeyboardCollectionCell *cell = (HPKeyboardCollectionCell *)[self cellForItemAtIndexPath:touchedIndexPath];
    if (!cell) {
        [self removePopView];
        return;
    }
    [self showKeyPopup:cell];
    if (touchedIndexPath.item == NSNotFound || gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if ([self.collectionDelegate respondsToSelector:@selector(collectionKeyPressed:)]) {
            HPKeyboardCollectionItem *keyItem = [_keyItems objectAtIndex:touchedIndexPath.row];
            [self.collectionDelegate collectionKeyPressed:keyItem];
        }
        [self removePopView];
    }
}

- (void)showKeyPopup:(HPKeyboardCollectionCell *)cell {
    
    CGFloat x = fmod(CGRectGetMidX(cell.frame), CGRectGetWidth(self.bounds));
    CGFloat y = CGRectGetMaxY(cell.frame)-CGRectGetHeight(_keyPopup.frame)/2.0;
    [_keyPopup setCenter:CGPointMake(x, y)];
    [_keyPopup setKeyItem:cell.keyItem];
    [self.superview addSubview:_keyPopup];
    [self.superview bringSubviewToFront:cell];
}

- (void)setKeyItems:(NSMutableArray *)keyItems {
    
    _keyItems = keyItems;
    [self reloadData];
}

- (void)addKeyItem:(HPKeyboardCollectionItem *)keyItem {
    
    NSMutableArray *itemsToRemmove = [NSMutableArray array];
    for (HPKeyboardCollectionItem *item in _keyItems) {
        if ([item.title isEqualToString:keyItem.title]) {
            [itemsToRemmove addObject:item];
        }
    }
    if ([itemsToRemmove count]>0) {
        [_keyItems removeObjectsInArray:itemsToRemmove];
        [self reloadData];
    }
    if ([_keyItems count] >= _keyboardCollectionLayout.numberOfItemsPerPage) {
        [_keyItems removeLastObject];
        [self reloadData];
    }
    if ([_keyItems count] < _keyboardCollectionLayout.numberOfItemsPerPage) {
        [self.keyItems insertObject:[self cloneKeyItem:keyItem] atIndex:0];
        [self reloadData];
    }
}

- (HPKeyboardCollectionItem *)cloneKeyItem:(HPKeyboardCollectionItem *)keyItem {
    HPKeyboardCollectionItem *cloneItem = [[HPKeyboardCollectionItem alloc] init];
    [cloneItem setTitle:keyItem.title];
    [cloneItem setImage:keyItem.image];
    [cloneItem setCharacter:keyItem.character];
    return cloneItem;
}

#pragma mark - CollectionView Delegate, DataSource

- (void)refreshPageControl {
    
    [self.pageControl setNumberOfPages:ceil(self.contentSize.width/CGRectGetWidth(self.bounds))];
    [self.pageControl setCurrentPage:floor(self.contentOffset.x/CGRectGetWidth(self.bounds))];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self refreshPageControl];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (!_keyItems) {
        return 0;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self refreshPageControl];
    });
    return [_keyItems count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HPKeyboardCollectionItem *item = [_keyItems objectAtIndex:indexPath.row];
    HPKeyboardCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:KEY_CELL forIndexPath:indexPath];
    [cell setKeyItem:item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self showKeyPopup:(HPKeyboardCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath]];
    if ([self.collectionDelegate respondsToSelector:@selector(collectionKeyPressed:)]) {
        HPKeyboardCollectionItem *keyItem = [_keyItems objectAtIndex:indexPath.row];
        [self.collectionDelegate collectionKeyPressed:keyItem];
    }
    [self performSelector:@selector(removePopView) withObject:nil afterDelay:0.2];
}

- (void)removePopView {
    
    [_keyPopup removeFromSuperview];
}

@end
