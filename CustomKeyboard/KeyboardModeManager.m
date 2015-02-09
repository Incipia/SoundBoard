//
//  KeyboardModeManager.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/31/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardModeManager.h"

static KeyboardModeManager* s_manager = nil;

@interface KeyboardModeManager ()
@property (weak, nonatomic) NSObject<KeyboardModeUpdater>* updater;
@property (nonatomic) KeyboardMode currentMode;
@property (nonatomic) KeyboardShiftMode currentShiftMode;
@end

@implementation KeyboardModeManager

#pragma mark - Helper
+ (KeyboardModeManager*)manager
{
   if (s_manager == nil)
   {
      s_manager = [KeyboardModeManager new];
   }
   return s_manager;
}

#pragma mark - Class Methods
+ (void)setKeyboardModeUpdater:(NSObject<KeyboardModeUpdater>*)updater
{
   [[self class] manager].updater = updater;
}

+ (void)updateKeyboardMode:(KeyboardMode)mode
{
   [[self class] manager].currentMode = mode;
   dispatch_async(dispatch_get_main_queue(), ^{
      [[[self class] manager].updater updateKeyboardMode:mode];
   });
}

+ (KeyboardMode)currentMode
{
   return [[self class] manager].currentMode;
}

+ (void)updateKeyboardShiftMode:(KeyboardShiftMode)shiftMode
{
   [[self class] manager].currentShiftMode = shiftMode;
   dispatch_async(dispatch_get_main_queue(), ^{
      [[[self class] manager].updater updateKeyboardShiftMode:shiftMode];
   });
}

+ (KeyboardShiftMode)currentShiftMode
{
   return [[self class] manager].currentShiftMode;
}

+ (void)advanceToNextKeyboard
{
   [[[self class] manager].updater advanceToNextKeyboard];
}

@end
