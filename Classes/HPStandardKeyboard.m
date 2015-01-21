//
//  HPStandardKeyboard.m
//  HPKeyboard
//
//  Created by Huy Pham on 1/17/15.
//  Copyright (c) 2015 CoreDump. All rights reserved.
//

#define KeyboardRecentTagsPlist @"HPKeyboardRecentTags.plist"

#import "HPStandardKeyboard.h"
#import "HPKeyboardCollection.h"
#import "HPKeyboardCollectionItem.h"

@implementation HPStandardKeyboard

+ (HPKeyboard *)sharedKeyboard {
    
    static dispatch_once_t once;
    static id sharedKeyboard;
    dispatch_once(&once, ^{
        sharedKeyboard = [HPKeyboard keyboard];
        [self initKeyboard:sharedKeyboard];
        
    });
    return sharedKeyboard;
}

+ (void)initKeyboard:(HPKeyboard *)keyboard {
    
    NSString *facesString = @"😄 😃 😀 😊 ☺️ 😉 😍 😘 😚 😗 😙 😜 😝 😛 😳 😁 😔 😌 😒 😞 😣 😢 😂 😭 😪 😥 😰 😅 😓 😩 😫 😨 😱 😠 😡 😤 😖 😆 😋 😷 😎 😴 😵 😲 😟 😦 😧 😈 👿 😮 😬 😐 😕 😯 😶 😇 😏 😑 👲 👳 👮 👷 💂 👶 👦 👧 👨 👩 👴 👵 👱 👼 👸 😺 😸 😻 😽 😼 🙀 😿 😹 😾 👹 👺 🙈 🙉 🙊 💀 👽 💩 🔥 ✨ 🌟 💫 💥 💢 💦 💧 💤 💨 👂 👀 👃 👅 👄 👍 👎 👌 👊 ✊ ✌️ 👋 ✋ 👐 👆 👇 👉 👈 🙌 🙏 ☝️ 👏 💪 🚶 🏃 💃 👫 👪 👬 👭 💏 💑 👯 🙆 🙅 💁 🙋 💆 💇 💅 👰 🙎 🙍 🙇 🎩 👑 👒 👟 👞 👡 👠 👢 👕 👔 👚 👗 🎽 👖 👘 👙 💼 👜 👝 👛 👓 🎀 🌂 💄 💛 💙 💜 💚 ❤ 💔 💗 💓 💕 💖 💞 💘 💌 💋 💍 💎 👤 👥 💬 👣 💭";
    NSString *flowersString = @"🐶 🐺 🐱 🐭 🐹 🐰 🐸 🐯 🐨 🐻 🐷 🐽 🐮 🐗 🐵 🐒 🐴 🐑 🐘 🐼 🐧 🐦 🐤 🐥 🐣 🐔 🐍 🐢 🐛 🐝 🐜 🐞 🐌 🐙 🐚 🐠 🐟 🐬 🐳 🐋 🐄 🐏 🐀 🐃 🐅 🐇 🐉 🐎 🐐 🐓 🐕 🐖 🐁 🐂 🐲 🐡 🐊 🐫 🐪 🐆 🐈 🐩 🐾 💐 🌸 🌷 🍀 🌹 🌻 🌺 🍁 🍃 🍂 🌿 🌾 🍄 🌵 🌴 🌲 🌳 🌰 🌱 🌼 🌐 🌞 🌝 🌚 🌑 🌒 🌓 🌔 🌕 🌖 🌗 🌘 🌜 🌛 🌙 🌍 🌎 🌏 🌋 🌌 🌠 ⭐️ ☀️ ⛅️ ☁️ ⚡️ ☔️ ❄️ ⛄️ 🌀 🌁 🌈 🌊";
    
    NSString *bellString = @"🎍 💝 🎎 🎒 🎓 🎏 🎆 🎇 🎐 🎑 🎃 👻 🎅 🎄 🎁 🎋 🎉 🎊 🎈 🎌 🔮 🎥 📷 📹 📼 💿 📀 💽 💾 💻 📱 ☎️ 📞 📟 📠 📡 📺 📻 🔊 🔉 🔈 🔇 🔔 🔕 📢 📣 ⏳ ⌛️ ⏰ ⌚️ 🔓 🔒 🔏 🔐 🔑 🔎 💡 🔦 🔆 🔅 🔌 🔋 🔍 🛁 🛀 🚿 🚽 🔧 🔩 🔨 🚪 🚬 💣 🔫 🔪 💊 💉 💰 💴 💵 💷 💶 💳 💸 📲 📧 📥 📤 ✉️ 📩 📨 📯 📫 📪 📬 📭 📮 📦 📝 📄 📃 📑 📊 📈 📉 📜 📋 📅 📆 📇 📁 📂 ✂️ 📌 📎 ✒️ ✏️ 📏 📐 📕 📗 📘 📙 📓 📔 📒 📚 📖 🔖 📛 🔬 🔭 📰 🎨 🎬 🎤 🎧 🎼 🎵 🎶 🎹 🎻 🎺 🎷 🎸 👾 🎮 🃏 🎴 🀄️ 🎲 🎯 🏈 🏀 ⚽️ ⚾️ 🎾 🎱 🏉 🎳 ⛳️ 🚵 🚴 🏁 🏇 🏆 🎿 🏂 🏊 🏄 🎣 ☕️ 🍵 🍶 🍼 🍺 🍻 🍸 🍹 🍷 🍴 🍕 🍔 🍟 🍗 🍖 🍝 🍛 🍤 🍱 🍣 🍥 🍙 🍘 🍚 🍜 🍲 🍢 🍡 🍳 🍞 🍩 🍮 🍦 🍨 🍧 🎂 🍰 🍪 🍫 🍬 🍭 🍯 🍎 🍏 🍊 🍋 🍒 🍇 🍉 🍓 🍑 🍈 🍌 🍐 🍍 🍠 🍆 🍅 🌽";
    
    NSString *carString = @"🏠 🏡 🏫 🏢 🏣 🏥 🏦 🏪 🏩 🏨 💒 ⛪️ 🏬 🏤 🌇 🌆 🏯 🏰 ⛺️ 🏭 🗼 🗾 🗻 🌄 🌅 🌃 🗽 🌉 🎠 🎡 ⛲️ 🎢 🚢 ⛵️ 🚤 🚣 ⚓️ 🚀 ✈️ 💺 🚁 🚂 🚊 🚉 🚞 🚆 🚄 🚅 🚈 🚇 🚝 🚋 🚃 🚎 🚌 🚍 🚙 🚘 🚗 🚕 🚖 🚛 🚚 🚨 🚓 🚔 🚒 🚑 🚐 🚲 🚡 🚟 🚠 🚜 💈 🚏 🎫 🚦 🚥 ⚠️ 🚧 🔰 ⛽️ 🏮 🎰 ♨️ 🗿 🎪 🎭 📍 🚩 🇯🇵 🇰🇷 🇩🇪 🇨🇳 🇺🇸 🇫🇷 🇪🇸 🇮🇹 🇷🇺 🇬🇧";
    
    
    HPKeyboardCollection *historyCollection = [self keyboardCollectionFromArrayString:[HPStandardKeyboard loadRecentTags]];
    [historyCollection.title setText:@"Recent tags"];
    [historyCollection.pageControl setHidden:YES];
    [historyCollection.barButton setImage:[UIImage imageNamed:@"HPKeyboardClock"] forState:UIControlStateNormal];
    [historyCollection.barButton setImage:[UIImage imageNamed:@"HPKeyboardClockSelected"] forState:UIControlStateSelected];

    HPKeyboardCollection *facesCollection = [self keyboardCollectionFromString:facesString];
    [facesCollection.barButton setImage:[UIImage imageNamed:@"HPKeyboardSmile"] forState:UIControlStateNormal];
    [facesCollection.barButton setImage:[UIImage imageNamed:@"HPKeyboardSmileSelected"] forState:UIControlStateSelected];
    
    HPKeyboardCollection *flowersCollection = [self keyboardCollectionFromString:flowersString];
    [flowersCollection.barButton setImage:[UIImage imageNamed:@"HPKeyboardFlower"] forState:UIControlStateNormal];
    [flowersCollection.barButton setImage:[UIImage imageNamed:@"HPKeyboardFlowerSelected"] forState:UIControlStateSelected];
    
    HPKeyboardCollection *bellCollection = [self keyboardCollectionFromString:bellString];
    [bellCollection.barButton setImage:[UIImage imageNamed:@"HPKeyboardBell"] forState:UIControlStateNormal];
    [bellCollection.barButton setImage:[UIImage imageNamed:@"HPKeyboardBellSelected"] forState:UIControlStateSelected];

    HPKeyboardCollection *carCollection = [self keyboardCollectionFromString:carString];
    [carCollection.barButton setImage:[UIImage imageNamed:@"HPKeyboardCar"] forState:UIControlStateNormal];
    [carCollection.barButton setImage:[UIImage imageNamed:@"HPKeyboardCarSelected"] forState:UIControlStateSelected];
    
    [keyboard setKeyBoardCollections:@[ historyCollection, facesCollection, flowersCollection, bellCollection, carCollection]];
}

+ (HPKeyboardCollection *)keyboardCollectionFromString:(NSString *)string {
    
    HPKeyboardCollection *collection = [[HPKeyboardCollection alloc] init];
    if (string) {
        NSMutableArray *items = [NSMutableArray array];
        NSArray *itemsSet = [string componentsSeparatedByString:@" "];
        for(int i = 0; i < itemsSet.count; i++) {
            NSString *character = [itemsSet objectAtIndex:i];
            HPKeyboardCollectionItem *item = [[HPKeyboardCollectionItem alloc] init];
            [item setTitle:character];
            [item setCharacter:character];
            [items addObject:item];
        }
        [collection setKeyItems:items];
    } else {
        [collection setKeyItems:[NSMutableArray array]];
    }
    return collection;
}

+ (HPKeyboardCollection *)keyboardCollectionFromArrayString:(NSArray *)array {
    
    HPKeyboardCollection *collection = [[HPKeyboardCollection alloc] init];
    if (array) {
        NSMutableArray *items = [NSMutableArray array];
        for(int i = 0; i < array.count; i++) {
            NSString *character = [array objectAtIndex:i];
            HPKeyboardCollectionItem *item = [[HPKeyboardCollectionItem alloc] init];
            [item setTitle:character];
            [item setCharacter:character];
            [items addObject:item];
        }
        [collection setKeyItems:items];
    } else {
        [collection setKeyItems:[NSMutableArray array]];
    }
    return collection;
}


+ (NSArray *)loadRecentTags {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:KeyboardRecentTagsPlist];
    NSArray *tagsArray = [NSArray arrayWithContentsOfFile:stringsPlistPath];
    return tagsArray;
}

+ (void)saveRecentTags:(NSArray *)array {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *stringsPlistPath = [[paths objectAtIndex:0] stringByAppendingPathComponent:KeyboardRecentTagsPlist];
    [array writeToFile:stringsPlistPath atomically:YES];
}

@end
