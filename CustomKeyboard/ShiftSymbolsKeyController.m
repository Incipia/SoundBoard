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
- (void)setupLetterViews
{
   self.shiftLetterView = [KeyView viewWithLetter:@"shift" fontSize:14.f frame:CGRectZero];
   self.symbolsLetterView = [KeyView viewWithLetter:@"#+=" fontSize:14.f frame:CGRectZero];
   self.numbersLetterView = [KeyView viewWithLetter:@"123" fontSize:14.f frame:CGRectZero];
   
   self.letterViewArray = @[self.shiftLetterView, self.symbolsLetterView, self.numbersLetterView];
   for (KeyView* letterView in self.letterViewArray)
   {
      letterView.hidden = YES;
      [self.view addSubview:letterView];
   }
   
   self.shiftLetterView.hidden = NO;
}

@end
