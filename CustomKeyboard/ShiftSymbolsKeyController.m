//
//  ShiftSymbolsKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "ShiftSymbolsKeyController.h"
#import "KeyView.h"

@interface ShiftSymbolsKeyController ()
@property (nonatomic) KeyView* shiftLetterView;
@property (nonatomic) KeyView* symbolsLetterView;
@property (nonatomic) KeyView* numbersLetterView;
@end

@implementation ShiftSymbolsKeyController

#pragma mark - Setup
- (void)setupKeyViews
{
   self.shiftLetterView = [KeyView viewWithText:@"shift" fontSize:14.f frame:CGRectZero];
   self.symbolsLetterView = [KeyView viewWithText:@"#+=" fontSize:14.f frame:CGRectZero];
   self.numbersLetterView = [KeyView viewWithText:@"123" fontSize:14.f frame:CGRectZero];
   
   self.keyViewArray = @[self.shiftLetterView, self.symbolsLetterView, self.numbersLetterView];
   for (KeyView* letterView in self.keyViewArray)
   {
      letterView.hidden = YES;
      [self.view addSubview:letterView];
   }
   
   self.shiftLetterView.hidden = NO;
}

#pragma mark - Public
- (KeyView*)keyViewForMode:(KeyboardMode)mode
{
   KeyView* keyView;
   switch (mode)
   {
      case KeyboardModeLetters:
         keyView = self.shiftLetterView;
         break;
         
      case KeyboardModeNumbers:
         keyView = self.symbolsLetterView;
         break;
         
      case KeyboardModeSymbols:
         keyView = self.numbersLetterView;
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
         self.shiftLetterView.hidden = NO;
         self.numbersLetterView.hidden = YES;
         self.symbolsLetterView.hidden = YES;
         break;
         
      case KeyboardModeNumbers:
         self.shiftLetterView.hidden = YES;
         self.numbersLetterView.hidden = YES;
         self.symbolsLetterView.hidden = NO;
         break;
         
      case KeyboardModeSymbols:
         self.shiftLetterView.hidden = YES;
         self.numbersLetterView.hidden = NO;
         self.symbolsLetterView.hidden = YES;
         break;
         
      default:
         break;
   }
}

@end
