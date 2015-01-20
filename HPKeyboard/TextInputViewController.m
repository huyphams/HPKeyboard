//
//  TextInputViewController.m
//  HPKeyboard
//
//  Created by Huy Pham on 1/16/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#import "TextInputViewController.h"

#import "HPKeyboard.h"

@interface TextInputViewController ()

@end

@implementation TextInputViewController {
    
    UIScrollView *_scrollView;
    UITextView *_textView;
    UIButton *_switchKeyboard;
}

- (void)loadView {
    
    [super loadView];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [_scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)+10)];
    [self.view addSubview:_scrollView];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 50, CGRectGetWidth(self.view.bounds)-40, 200)];
    [_textView setTextColor:[UIColor whiteColor]];
    [_textView setFont:[UIFont fontWithName:@"HelveticaNeue" size:16]];
    [_textView.layer setCornerRadius:5];
    [_textView setBackgroundColor:[UIColor grayColor]];
    [_scrollView addSubview:_textView];
    
    _switchKeyboard = [[UIButton alloc] initWithFrame:CGRectMake(20, 260, 150, 60)];
    [_switchKeyboard addTarget:self action:@selector(switchKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    [_switchKeyboard setTitle:@"Change keyboard" forState:UIControlStateNormal];
    [_switchKeyboard setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_switchKeyboard setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    [_scrollView addSubview:_switchKeyboard];
    
    UIButton *endEditing = [[UIButton alloc] initWithFrame:CGRectMake(170, 260, 160, 60)];
    [endEditing addTarget:self action:@selector(endEditing) forControlEvents:UIControlEventTouchUpInside];
    [endEditing setTitle:@"End editing" forState:UIControlStateNormal];
    [endEditing setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_scrollView addSubview:endEditing];
}

- (void)switchKeyBoard {
    
    if (_textView.isFirstResponder) {
        [_textView resignFirstResponder];
        [_switchKeyboard setSelected:!_switchKeyboard.selected];
        [self performSelector:@selector(forcusTextView) withObject:nil afterDelay:0.15];
    } else {
        
        [self forcusTextView];
    }
}

- (void)forcusTextView {
    
    if (_switchKeyboard.isSelected) {
        [_textView switchToKeyboardType:HPKeyboardStandard];
    } else {
        [_textView switchToKeyboardType:HPKeyboardDefault];
    }
    [_textView becomeFirstResponder];
}

- (void)endEditing {
    
    [_textView resignFirstResponder];
}

@end
