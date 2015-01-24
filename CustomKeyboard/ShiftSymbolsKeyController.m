//
//  ShiftSymbolsKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "ShiftSymbolsKeyController.h"
#import "LetterView.h"

@interface ShiftSymbolsKeyController ()
@property (nonatomic) LetterView* shiftLetterView;
@property (nonatomic) LetterView* symbolsLetterView;
@property (nonatomic) LetterView* numbersLetterView;
@end

@implementation ShiftSymbolsKeyController

#pragma mark - Setup
- (void)setupLetterViews
{
   self.shiftLetterView = [LetterView viewWithLetter:@"shift" fontSize:14.f frame:CGRectZero];
   self.symbolsLetterView = [LetterView viewWithLetter:@"#+=" fontSize:14.f frame:CGRectZero];
   self.numbersLetterView = [LetterView viewWithLetter:@"123" fontSize:14.f frame:CGRectZero];
   
   self.letterViewArray = @[self.shiftLetterView, self.symbolsLetterView, self.numbersLetterView];
   for (LetterView* letterView in self.letterViewArray)
   {
      letterView.hidden = YES;
      [self.view addSubview:letterView];
   }
   
   self.shiftLetterView.hidden = NO;
}

#pragma mark - Public
- (void)updateWithMode:(KeyboardMode)mode
{
   switch (mode)
   {
      case KeyboardModeLetters:
         break;
         
      case KeyboardModeSymbols:
         break;
         
      case KeyboardModeNumbers:
         break;
         
      default:
         break;
   }
}

@end
