//
//  KeyboardTouchEventHandler.h
//  SoundBoard
//
//  Created by Klein, Greg on 1/26/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardMapUpdateListener.h"

@interface KeyboardTouchEventHandler : UIViewController <KeyboardKeyFrameTextMapUpdater>

+ (instancetype)handlerWithTextDocumentProxy:(id<UITextDocumentProxy>)proxy;
- (void)updateKeyboardKeyFrameTextMap:(KeyboardKeyFrameTextMap*)keyFrameTexMap;

@end
