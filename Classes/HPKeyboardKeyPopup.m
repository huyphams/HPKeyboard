//
//  HPKeyboardKeyPopup.m
//  HPKeyboard
//
//  Created by Huy Pham on 1/19/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#import "HPKeyboardKeyPopup.h"

@implementation HPKeyboardKeyPopup {
    UIImageView *_background;
    UIButton *_keyButton;
}

- (instancetype)init {
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (UIImageView *)background {
    if (!_background) {
        _background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 83, 110)];
        [_background setBackgroundColor:[UIColor clearColor]];
        [_background setImage:[UIImage imageNamed:@"HPKeyboardKeyPopup"]];
    }
    return _background;
}

- (void)commonInit {
    [self setBackgroundColor:[UIColor clearColor]];
    [self setUserInteractionEnabled:NO];
    [self setFrame:CGRectMake(0, 0, 83, 110)];
    [self addSubview:[self background]];
    [self addSubview:[self keyButton]];
}

- (UIButton *)keyButton {
    if (!_keyButton) {
        _keyButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 7, 43, 43)];
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
