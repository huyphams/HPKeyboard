//
//  HPKeyboardCollectionLayout.h
//  HPKeyboard
//
//  Created by Huy Pham on 1/16/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HPKeyboardCollectionLayout : UICollectionViewLayout

@property (nonatomic, assign) CGSize       itemSize;
@property (nonatomic, assign) CGFloat      lineSpacing;
@property (nonatomic, assign) CGFloat      columSpacing;
@property (nonatomic, assign) UIEdgeInsets sectionInset;

- (NSInteger)numberOfItemsPerPage;

@end
