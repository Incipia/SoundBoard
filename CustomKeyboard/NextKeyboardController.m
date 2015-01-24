//
//  NextKeyboardController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "NextKeyboardController.h"
#import "LetterView.h"

@interface NextKeyboardController ()
@property (nonatomic) LetterView* nextKeyboardKeyView;
@end

@implementation NextKeyboardController

#pragma mark - Setup
- (void)setupLetterViews
{
   self.nextKeyboardKeyView = [LetterView viewWithLetter:@"next" fontSize:14.f frame:CGRectZero];
   self.letterViewArray = @[self.nextKeyboardKeyView];
   for (LetterView* letterView in self.letterViewArray)
   {
      [self.view addSubview:letterView];
   }
}

@end
