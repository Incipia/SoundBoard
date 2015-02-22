//
//  LetterView.h
//  SoundBoard
//
//  Created by Gregory Klein on 1/21/15.
//  Copyright (c) 2015 gPure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardKeyLayer.h"

typedef void (^keyActionBlock)(NSInteger repeatCount);

@interface KeyView : UIView
- (instancetype)initWithText:(NSString*)text fontSize:(CGFloat)fontSize frame:(CGRect)frame;
+ (instancetype)viewWithText:(NSString*)text fontSize:(CGFloat)fontSize frame:(CGRect)frame;

- (void)updateFrame:(CGRect)frame;
- (void)setActionBlock:(keyActionBlock)block;
- (void)executeActionBlock:(NSInteger)repeatCount;

- (void)giveFocus;
- (void)removeFocus;

@property (readonly) BOOL hasFocus;
@property (nonatomic, copy) NSString* displayText;
@property (nonatomic) BOOL shouldTriggerActionOnTouchDown;
@property (nonatomic) BOOL shouldShowEnlargedKeyOnTouchDown;
@property (readonly) BOOL wantsToHandleTouchEvents;

@property (nonatomic, readonly) KeyboardKeyLayer* keyLayer;

@end
