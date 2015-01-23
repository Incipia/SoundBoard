//
//  KeyboardKeysUtility.h
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KeyboardMode)
{
   KeyboardModeLetters,
   KeyboardModeNumbers,
   KeyboardModeSymbols
};

typedef NS_ENUM(NSUInteger, KeyboardRow)
{
   KeyboardRowTop,
   KeyboardRowMiddle,
   KeyboardRowBottom
};

@interface KeyboardKeysUtility : NSObject

+ (NSArray*)characterArrayForMode:(KeyboardMode)mode row:(KeyboardRow)row;

@end
