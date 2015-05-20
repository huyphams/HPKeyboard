//
//  HPKeyboardCollectionCell.m
//  HPKeyboard
//
//  Created by Huy Pham on 1/17/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#import "HPKeyboardCollectionCell.h"

@implementation HPKeyboardCollectionCell {
    
    UIButton *_keyButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (!(self = [super initWithFrame:frame])) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (void)commonInit {
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:[self keyButton]];
}

- (UIButton *)keyButton {
    if (!_keyButton) {
        _keyButton = [[UIButton alloc] initWithFrame:self.bounds];
        [_keyButton.titleLabel setFont:[UIFont systemFontOfSize:33]];
        [_keyButton setUserInteractionEnabled:NO];
    }
    return _keyButton;
}

- (void)setKeyItem:(HPKeyboardCollectionItem *)keyItem {
    _keyItem = keyItem;
    [[self keyButton] setImage:_keyItem.image forState:UIControlStateNormal];
    [[self keyButton] setTitle:_keyItem.title forState:UIControlStateNormal];
    [[self keyButton] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

@end
