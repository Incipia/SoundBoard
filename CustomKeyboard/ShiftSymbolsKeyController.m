//
//  ShiftSymbolsKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "ShiftSymbolsKeyController.h"
#import "KeyboardModeManager.h"
#import "KeyView.h"

@interface ShiftSymbolsKeyController ()
@property (nonatomic) KeyView* shiftKeyView;
@property (nonatomic) KeyView* symbolsKeyView;
@property (nonatomic) KeyView* numbersKeyView;
@end

@implementation ShiftSymbolsKeyController

#pragma mark - Setup
- (void)setupKeyViews
{
   [self setupShiftLetterView];
   [self setupSymbolsLetterView];
   [self setupNumbersLetterView];
   
   self.keyViewArray = @[self.shiftKeyView, self.symbolsKeyView, self.numbersKeyView];
   for (KeyView* letterView in self.keyViewArray)
   {
      [self.view addSubview:letterView];
   }
   
   self.shiftKeyView.hidden = NO;
}

- (void)setupShiftLetterView
{
   self.shiftKeyView = [KeyView viewWithText:@"shift" fontSize:14.f frame:CGRectZero];
   self.shiftKeyView.hidden = YES;
   self.shiftKeyView.shouldTriggerActionOnTouchDown = YES;
   
   [self.shiftKeyView setActionBlock:^
   {
      NSLog(@"shift button pressed");
   }];
}

- (void)setupSymbolsLetterView
{
   self.symbolsKeyView = [KeyView viewWithText:@"#+=" fontSize:14.f frame:CGRectZero];
   self.symbolsKeyView.hidden = YES;
   self.symbolsKeyView.shouldTriggerActionOnTouchDown = YES;
   
   [self.symbolsKeyView setActionBlock:^
   {
      [KeyboardModeManager updateKeyboardMode:KeyboardModeSymbols];
   }];
}

- (void)setupNumbersLetterView
{
   self.numbersKeyView = [KeyView viewWithText:@"123" fontSize:14.f frame:CGRectZero];
   self.numbersKeyView.hidden = YES;
   self.numbersKeyView.shouldTriggerActionOnTouchDown = YES;
   
   [self.numbersKeyView setActionBlock:^
   {
      [KeyboardModeManager updateKeyboardMode:KeyboardModeNumbers];
   }];
}

#pragma mark - Public
- (KeyView*)keyViewForMode:(KeyboardMode)mode
{
   KeyView* keyView;
   switch (mode)
   {
      case KeyboardModeLetters:
         keyView = self.shiftKeyView;
         break;
         
      case KeyboardModeNumbers:
         keyView = self.symbolsKeyView;
         break;
         
      case KeyboardModeSymbols:
         keyView = self.numbersKeyView;
         break;
         
      default:
         break;
   }
   return keyView;
}

- (void)updateMode:(KeyboardMode)mode
{
   switch (mode)
   {
      case KeyboardModeLetters:
         self.shiftKeyView.hidden = NO;
         self.numbersKeyView.hidden = YES;
         self.symbolsKeyView.hidden = YES;
         break;
         
      case KeyboardModeNumbers:
         self.shiftKeyView.hidden = YES;
         self.numbersKeyView.hidden = YES;
         self.symbolsKeyView.hidden = NO;
         break;
         
      case KeyboardModeSymbols:
         self.shiftKeyView.hidden = YES;
         self.numbersKeyView.hidden = NO;
         self.symbolsKeyView.hidden = YES;
         break;
         
      default:
         break;
   }
}

@end
