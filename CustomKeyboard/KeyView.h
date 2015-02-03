//
//  LetterView.h
//  SoundBoard
//
//  Created by Gregory Klein on 1/21/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardKeyLayer.h"

@interface KeyView : UIView

+ (instancetype)viewWithText:(NSString*)text fontSize:(CGFloat)fontSize frame:(CGRect)frame;

- (void)updateFrame:(CGRect)frame;

- (void)setActionBlock:(dispatch_block_t)block;
- (void)executeActionBlock;

- (void)giveFocus;
- (void)removeFocus;

@property (nonatomic, copy) NSString* displayText;
@property (nonatomic) BOOL shouldTriggerActionOnTouchDown;
@property (nonatomic) BOOL shouldShowEnlargedKeyOnTouchDown;

@property (nonatomic, readonly) KeyboardKeyLayer* keyLayer;
@property (nonatomic, readonly) CALayer* backgroundLayer;

@end
