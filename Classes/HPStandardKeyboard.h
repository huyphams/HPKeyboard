//
//  HPStandardKeyboard.h
//  HPKeyboard
//
//  Created by Huy Pham on 1/17/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPKeyboard.h"

@interface HPStandardKeyboard : NSObject

+ (HPKeyboard *)sharedKeyboard;
+ (void)saveRecentTags:(NSArray *)array;

@end
