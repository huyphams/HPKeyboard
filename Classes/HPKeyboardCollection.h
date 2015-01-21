//
//  HPKeyboardCollection.h
//  HPKeyboard
//
//  Created by Huy Pham on 1/17/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import <UIKit/UIKit.h>

#import "HPKeyboardCollectionItem.h"

@protocol HPKeyboardColelctionDelegate <NSObject>

- (void)collectionKeyPressed:(HPKeyboardCollectionItem *)keyItem;
- (void)collectionBarButtonPressed:(UIButton *)button;

@end

@interface HPKeyboardCollection : UICollectionView

@property (nonatomic, strong) NSMutableArray *keyItems;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIButton *barButton;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, weak) id <HPKeyboardColelctionDelegate> collectionDelegate;

- (void)addKeyItem:(HPKeyboardCollectionItem *)keyItem;

@end
