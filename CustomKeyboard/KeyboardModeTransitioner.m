//
//  KeyboardModeTransitioner.m
//  SoundBoard
//
//  Created by Gregory Klein on 2/8/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardModeTransitioner.h"
#import "KeyboardModeManager.h"

static KeyboardModeTransitioner* s_transitioner;
static NSString* const s_spacebarInput = @"SPACE";

@interface KeyboardModeTransitioner ()
@property (nonatomic) BOOL readyToTransition;
@property (nonatomic) KeyboardMode nextMode;
@property (nonatomic) KeyboardMode disabledRequestsMode;
@property (nonatomic) NSString* transitionTriggerInput;
@end

@implementation KeyboardModeTransitioner

+ (KeyboardModeTransitioner*)transitioner
{
   if (s_transitioner == nil)
   {
      s_transitioner = [KeyboardModeTransitioner new];
   }
   return s_transitioner;
}

+ (void)giveTextInput:(NSString*)input
{
   KeyboardModeTransitioner* transitioner = [[self class] transitioner];
   if (transitioner.readyToTransition && [input isEqualToString:transitioner.transitionTriggerInput])
   {
      [KeyboardModeManager updateKeyboardMode:transitioner.nextMode];
      transitioner.readyToTransition = NO;
   }
}

+ (void)giveSpacebarInput
{
   [[self class] giveTextInput:s_spacebarInput];
}

+ (void)disableRequestsWhileInMode:(KeyboardMode)mode
{
   [[self class] transitioner].disabledRequestsMode = mode;
}

+ (void)requestTransitionToMode:(KeyboardMode)mode afterNextInput:(NSString*)input
{
   KeyboardModeTransitioner* transitioner = [[self class] transitioner];
   if ([KeyboardModeManager currentMode] != transitioner.disabledRequestsMode)
   {
      transitioner.readyToTransition = YES;
      transitioner.nextMode = mode;
      transitioner.transitionTriggerInput = input;
   }
}

+ (void)requestTransitionToModeAfterNextSpacebarInput:(KeyboardMode)mode
{
   [[self class] requestTransitionToMode:mode afterNextInput:s_spacebarInput];
}

+ (void)resetPreviousRequest
{
   [[self class] transitioner].readyToTransition = NO;
   [[self class] transitioner].transitionTriggerInput = nil;
}

@end
