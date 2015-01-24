//
//  KeyboardKeysUtility.h
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyboardTypedefs.h"

@interface KeyboardKeysUtility : NSObject

+ (NSArray*)characterArrayForMode:(KeyboardMode)mode row:(KeyboardRow)row;

@end
