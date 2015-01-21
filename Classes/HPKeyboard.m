//
//  HPKeyboard.m
//  HPKeyboard
//
//  Created by Huy Pham on 1/16/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#import "HPKeyboard.h"

#import "UIResponder+WriteableInputView.h"
#import "HPStandardKeyboard.h"
#import "HPKeyboardCollectionItem.h"
#import "HPKeyboardCollection.h"

CGSize  const HPKeyboardDefaultSize = (CGSize){320,216};
CGFloat const HPKeyboardTabDefaultHeight = 35;
NSString * const HPKeyboardDidSwitchToDefaultKeyboardNotification = @"HPKeyboardDidSwitchToDefaultKeyboardNotification";

@interface HPKeyboard () <HPKeyboardColelctionDelegate>

@property (nonatomic, weak, readwrite) UIResponder<UITextInput> *textInput;
@property (nonatomic, weak) HPKeyboardCollection *currentCollection;

@end

@implementation HPKeyboard {
    
    UIButton *_hideKeyboardButton;
    UIButton *_backspaceButton;
    UIButton *_switchButton;
    UIScrollView *_collectionButtonsBar;
}

+ (instancetype)sharedInstance {
    
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [HPKeyboard keyboard];
    });
    return sharedInstance;
}

+ (instancetype)keyboard {
    
    return [[HPKeyboard alloc] init];
}

- (instancetype)init {
    
    if (!(self = [super init])) {
        return nil;
    }
    [self commonInit];
    return self;
}

- (void)commonInit {
    
    [self setFrame:(CGRect){0, 0, HPKeyboardDefaultSize}];
    [self setBackgroundColor:UIColorFromRGB(0xF8F8F8)];
    
    _hideKeyboardButton = [[UIButton alloc] initWithFrame:CGRectMake(7, 5, 30, 30)];
    [_hideKeyboardButton addTarget:self
                            action:@selector(hideKeyboardButtonTouchUpInside:)
                  forControlEvents:UIControlEventTouchUpInside];
    [_hideKeyboardButton setContentMode:UIViewContentModeScaleAspectFit];
    [_hideKeyboardButton setImage:[UIImage imageNamed:@"HPKeyboardTriangle"] forState:UIControlStateNormal];
    [_hideKeyboardButton setImage:[UIImage imageNamed:@"HPKeyboardTriangleSelected"] forState:UIControlStateHighlighted];
    
    [self addSubview:_hideKeyboardButton];
    
    _collectionButtonsBar = [[UIScrollView alloc] initWithFrame:(CGRect) {
        0,
        HPKeyboardDefaultSize.height-HPKeyboardTabDefaultHeight,
        CGRectGetWidth(self.bounds),
        HPKeyboardTabDefaultHeight }];
    
    [_collectionButtonsBar setBackgroundColor:UIColorFromRGB(0xE1E1E1)];
    [_collectionButtonsBar setContentSize:CGSizeMake(CGRectGetWidth(self.bounds), HPKeyboardTabDefaultHeight)];
    [self addSubview:_collectionButtonsBar];
    
    _backspaceButton = [[UIButton alloc] initWithFrame:(CGRect) {
        CGRectGetWidth(self.bounds)-HPKeyboardDefaultSize.width/6.0,
        CGRectGetHeight(self.bounds)-HPKeyboardTabDefaultHeight,
        HPKeyboardDefaultSize.width/6.0,
        HPKeyboardTabDefaultHeight }];
    [_backspaceButton setContentMode:UIViewContentModeScaleAspectFit];
    [_backspaceButton addTarget:self action:@selector(backSpaceTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_backspaceButton setImage:[UIImage imageNamed:@"HPKeyboardBackspace"] forState:UIControlStateNormal];
    [_backspaceButton setImage:[UIImage imageNamed:@"HPKeyboardBackspaceSelected"] forState:UIControlStateHighlighted];
    [self addSubview:_backspaceButton];

    _switchButton = [[UIButton alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.bounds)-47, 5, 40, 30)];
    [_switchButton setContentMode:UIViewContentModeScaleAspectFit];
    [_switchButton addTarget:self action:@selector(switchToDefaultKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [_switchButton setImage:[UIImage imageNamed:@"HPKeyboardKeyboard"] forState:UIControlStateNormal];
    [_switchButton setImage:[UIImage imageNamed:@"HPKeyboardKeyboardSelected"] forState:UIControlStateHighlighted];
    [self addSubview:_switchButton];
}

- (void)hideKeyboardButtonTouchUpInside:(UIButton *)button {
    
    [self.textInput resignFirstResponder];
}

- (void)backSpaceTouchDown:(UIButton *)button {
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(autoDelete)
                                               object:nil];
    
    [self canPerformAction:@selector(autoDelete)
                withSender:nil];
    if (self.textInput.selectedTextRange.empty) {
        [self.textInput deleteBackward];
    } else {
        [self replaceTextInRange:self.textInput.selectedTextRange withText:@""];
    }
    
    [self performSelector:@selector(autoDelete)
               withObject:nil
               afterDelay:0.5
                  inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
}

- (void)autoDelete {
    
    if (_backspaceButton.isHighlighted) {
        [self.textInput deleteBackward];
        [self performSelector:@selector(autoDelete)
                   withObject:nil
                   afterDelay:0.2
                      inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    }
}

- (void)setKeyBoardCollections:(NSArray *)keyBoardCollections {
    
    _keyBoardCollections = keyBoardCollections;
    
    for (int i=0; i< [_keyBoardCollections count]; i++) {
        HPKeyboardCollection *collection = [_keyBoardCollections objectAtIndex:i];
        [collection setCollectionDelegate:self];
        CGRect barButtonFrame = CGRectMake(i*HPKeyboardDefaultSize.width/6.0, 0, HPKeyboardDefaultSize.width/6.0, HPKeyboardTabDefaultHeight);
        [collection.barButton setFrame:barButtonFrame];
        [_collectionButtonsBar addSubview:collection.barButton];
    }
    
    HPKeyboardCollection *first = [_keyBoardCollections firstObject];
    [self collectionBarButtonPressed:first.barButton];
}

- (void)collectionKeyPressed:(HPKeyboardCollectionItem *)keyItem {
    
    [self inputText:keyItem.character];
    [UIDevice.currentDevice playInputClick];
    
    HPKeyboardCollection *first = [_keyBoardCollections firstObject];
    if (![_currentCollection isEqual:first]) {
        [first addKeyItem:keyItem];
    }
}

- (void)collectionBarButtonPressed:(UIButton *)button {
    
    [button setBackgroundColor:UIColorFromRGB(0xF8F8F8)];
    [button setSelected:YES];
    if (_currentCollection) {
        if ([_currentCollection.barButton isEqual:button]) {
            return;
        } else {
            [_currentCollection.barButton setBackgroundColor:UIColorFromRGB(0xE1E1E1)];
            [_currentCollection.barButton setSelected:NO];
            [_currentCollection.pageControl removeFromSuperview];
            [_currentCollection removeFromSuperview];
        }
    }
    
    for (HPKeyboardCollection *collection in _keyBoardCollections) {
        if ([collection.barButton isEqual:button]) {
            [self addSubview:collection.pageControl];
            [self addSubview:collection];
            [self bringSubviewToFront:_hideKeyboardButton];
            [self bringSubviewToFront:_collectionButtonsBar];
            [self bringSubviewToFront:_backspaceButton];
            [self bringSubviewToFront:_switchButton];
            _currentCollection = collection;
            return;
        }
    }
    [[HPStandardKeyboard sharedKeyboard] saveRecentTags];
}

- (void)saveRecentTags {
    
    HPKeyboardCollection *first = [_keyBoardCollections firstObject];
    NSMutableArray *arrayString = [NSMutableArray array];
    for (HPKeyboardCollectionItem *item in first.keyItems) {
        [arrayString addObject:item.title];
    }
    [HPStandardKeyboard saveRecentTags:arrayString];
}

#pragma mark - Text Input

- (void)setInputViewToView:(UIView *)view {
    
    [self.textInput setInputView:view];
    [self.textInput reloadInputViews];
}

- (void)attachToTextInput:(UIResponder<UITextInput> *)textInput {
    
    [self setTextInput:textInput];
    [self setInputViewToView:self];
}

- (void)switchToDefaultKeyboard {
    
    [self setInputViewToView:nil];
    [self setTextInput:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:HPKeyboardDidSwitchToDefaultKeyboardNotification
                                                        object:self];
}

- (void)inputText:(NSString *)text {
    
    [self replaceTextInRange:self.textInput.selectedTextRange
                    withText:text];
}

- (void)replaceTextInRange:(UITextRange *)range withText:(NSString *)text {
    
    if (range && [self textInputShouldReplaceTextInRange:range replacementText:text]) {
        [self.textInput replaceRange:range withText:text];
    }
}

- (BOOL)textInputShouldReplaceTextInRange:(UITextRange *)range replacementText:(NSString *)replacementText {
    
    BOOL shouldChange = YES;
    NSInteger startOffset = [self.textInput offsetFromPosition:self.textInput.beginningOfDocument
                                                    toPosition:range.start];
    NSInteger endOffset = [self.textInput offsetFromPosition:self.textInput.beginningOfDocument
                                                  toPosition:range.end];
    
    NSRange replacementRange = NSMakeRange(startOffset, endOffset - startOffset);
    
    if ([self.textInput isKindOfClass:UITextView.class]) {
        UITextView *textView = (UITextView *)self.textInput;
        if ([textView.delegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]){
            shouldChange = [textView.delegate textView:textView
                               shouldChangeTextInRange:replacementRange
                                       replacementText:replacementText];
        }
    }
    
    if ([self.textInput isKindOfClass:UITextField.class]) {
        UITextField *textField = (UITextField *)self.textInput;
        if ([textField.delegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            shouldChange = [textField.delegate textField:textField
                           shouldChangeCharactersInRange:replacementRange
                                       replacementString:replacementText];
        }
    }
    
    return shouldChange;
}

@end

@implementation UIResponder (HPKeyboard)

- (HPKeyboard *)keyboard {
    
    if ([self.inputView isKindOfClass:[HPKeyboard class]]) {
        return (HPKeyboard *)self.inputView;
    }
    return nil;
}

- (void)switchToKeyboard:(HPKeyboard *)keyboard {
    
    if ([self conformsToProtocol:@protocol(UITextInput)] && [self respondsToSelector:@selector(setInputView:)]) {
        [keyboard attachToTextInput:(UIResponder<UITextInput> *)self];
    }
}

- (void)switchToKeyboardType:(HPKeyboardType)keyboardType {
    
    switch (keyboardType) {
        case HPKeyboardDefault:
            [self.keyboard switchToDefaultKeyboard];
            break;
            
        case HPKeyboardStandard:
            [self switchToKeyboard:[HPStandardKeyboard sharedKeyboard]];
            
        default:
            break;
    }
}

@end
