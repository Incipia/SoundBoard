//
//  LetterNumberController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "LetterNumberKeyController.h"
#import "LetterView.h"

@interface LetterNumberKeyController ()
@property (nonatomic) LetterView* numbersKeyView;
@property (nonatomic) LetterView* lettersKeyView;
@end

@implementation LetterNumberKeyController

#pragma mark - Setup
- (void)setupLetterViews
{
   self.numbersKeyView = [LetterView viewWithLetter:@"123" fontSize:14.f frame:CGRectZero];
   self.lettersKeyView = [LetterView viewWithLetter:@"ABC" fontSize:14.f frame:CGRectZero];
   
   self.letterViewArray = @[self.numbersKeyView, self.lettersKeyView];
   for (LetterView* letterView in self.letterViewArray)
   {
      letterView.hidden = YES;
      [self.view addSubview:letterView];
   }
   
   self.numbersKeyView.hidden = NO;
}

@end
