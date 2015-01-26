//
//  KeyboardTouchEventHandler.h
//  SoundBoard
//
//  Created by Klein, Greg on 1/26/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardMapUpdateListener.h"

@interface KeyboardTouchEventHandler : UIViewController <KeyboardMapUpdateListener>

+ (instancetype)handlerWithTextDocumentProxy:(id<UITextDocumentProxy>)proxy;
- (void)updateKeyboardMapDictionary:(NSDictionary*)dictionary;

@end
