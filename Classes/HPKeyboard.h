//
//  HPKeyboard.h
//  HPKeyboard
//
//  Created by Huy Pham on 1/16/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HPKeyboardType) {
    HPKeyboardDefault,
    HPKeyboardStandard
};

extern CGFloat const HPKeyboardDefaultSizeHeigt;

extern CGFloat const HPKeyboardTabDefaultHeight;

extern NSString * const HPKeyboardDidSwitchToDefaultKeyboardNotification;

@interface HPKeyboard : UIView

+ (instancetype)sharedInstance;

+ (instancetype)keyboard;

@property (nonatomic, strong) NSArray *keyBoardCollections;

- (void)switchToDefaultKeyboard;

@end

@interface UIResponder (HPKeyboard)

@property (readonly, strong) HPKeyboard *keyboard;

- (void)switchToKeyboard:(HPKeyboard *)keyboard;

- (void)switchToKeyboardType:(HPKeyboardType)keyboardType;

@end
