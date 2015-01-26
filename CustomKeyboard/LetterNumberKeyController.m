//
//  LetterNumberController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "LetterNumberKeyController.h"
#import "KeyView.h"

@interface LetterNumberKeyController ()
@property (nonatomic) KeyView* numbersKeyView;
@property (nonatomic) KeyView* lettersKeyView;
@end

@implementation LetterNumberKeyController

#pragma mark - Setup
- (void)setupLetterViews
{
   self.numbersKeyView = [KeyView viewWithLetter:@"123" fontSize:14.f frame:CGRectZero];
   self.lettersKeyView = [KeyView viewWithLetter:@"ABC" fontSize:14.f frame:CGRectZero];
   
   self.keyViewArray = @[self.numbersKeyView, self.lettersKeyView];
   for (KeyView* letterView in self.keyViewArray)
   {
      letterView.hidden = YES;
      [self.view addSubview:letterView];
   }
   
   self.numbersKeyView.hidden = NO;
}

@end
