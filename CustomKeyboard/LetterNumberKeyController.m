//
//  LetterNumberController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "LetterNumberKeyController.h"
#import "KeyboardModeManager.h"
#import "KeyboardModeTransitioner.h"
#import "KeyView.h"

@interface LetterNumberKeyController ()
@property (nonatomic) KeyView* numbersKeyView;
@property (nonatomic) KeyView* lettersKeyView;
@end

@implementation LetterNumberKeyController

#pragma mark - Setup
- (void)setupKeyViews
{
   [self setupNumbersKeyView];
   [self setupLettersKeyView];
   
   self.keyViewArray = @[self.numbersKeyView, self.lettersKeyView];
   for (KeyView* letterView in self.keyViewArray)
   {
      letterView.backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
      [self.view addSubview:letterView];
   }
   
   self.numbersKeyView.hidden = NO;
}

- (void)setupNumbersKeyView
{
   self.numbersKeyView = [KeyView viewWithText:@"123" fontSize:14.f frame:CGRectZero];
   self.numbersKeyView.hidden = YES;
   self.numbersKeyView.shouldTriggerActionOnTouchDown = YES;
   
   [self.numbersKeyView setActionBlock:^
   {
      [KeyboardModeManager updateKeyboardMode:KeyboardModeNumbers];
   }];
}

- (void)setupLettersKeyView
{
   self.lettersKeyView = [KeyView viewWithText:@"ABC" fontSize:14.f frame:CGRectZero];
   self.lettersKeyView.hidden = YES;
   self.lettersKeyView.shouldTriggerActionOnTouchDown = YES;
   
   [self.lettersKeyView setActionBlock:^
   {
      [KeyboardModeManager updateKeyboardMode:KeyboardModeLetters];
      [KeyboardModeTransitioner resetPreviousRequest];
   }];
}

#pragma mark - Public
- (KeyView*)keyViewForMode:(KeyboardMode)mode
{
   KeyView* keyView = nil;
   switch (mode)
   {
      case KeyboardModeLetters:
         return self.numbersKeyView;
         break;
      
      case KeyboardModeNumbers:
         return self.lettersKeyView;
         break;
         
      case KeyboardModeSymbols:
         return self.lettersKeyView;
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
         self.numbersKeyView.hidden = NO;
         self.lettersKeyView.hidden = YES;
         break;
         
      case KeyboardModeNumbers:
         self.numbersKeyView.hidden = YES;
         self.lettersKeyView.hidden = NO;
         break;
         
      default:
         break;
   }
}

@end
