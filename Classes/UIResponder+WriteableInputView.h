//
//  UIResponder+WriteableInputView.h
//  HPKeyboard
//
//  Created by Huy Pham on 1/16/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (WriteableInputView)

@property (nonatomic, readwrite) UIView *inputView;

@end
