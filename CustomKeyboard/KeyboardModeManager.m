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
@property (nonatomic) KeyboardShiftMode currentShiftMode;
@end

@implementation KeyboardModeManager

#pragma mark - Helper
+ (KeyboardModeManager*)lazyLoadedManager
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
   [[self class] lazyLoadedManager].updater = updater;
}

+ (void)updateKeyboardMode:(KeyboardMode)mode
{
   dispatch_async(dispatch_get_main_queue(), ^{
      [[[self class] lazyLoadedManager].updater updateKeyboardMode:mode];
   });
}

+ (void)updateKeyboardShiftMode:(KeyboardShiftMode)shiftMode
{
   [[self class] lazyLoadedManager].currentShiftMode = shiftMode;
   dispatch_async(dispatch_get_main_queue(), ^{
      [[[self class] lazyLoadedManager].updater updateKeyboardShiftMode:shiftMode];
   });
}

+ (KeyboardShiftMode)currentShiftMode
{
   return [[self class] lazyLoadedManager].currentShiftMode;
}

+ (void)advanceToNextKeyboard
{
   [[[self class] lazyLoadedManager].updater advanceToNextKeyboard];
}

@end
