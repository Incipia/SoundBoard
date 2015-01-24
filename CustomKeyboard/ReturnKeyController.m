//
//  ReturnKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "ReturnKeyController.h"
#import "LetterView.h"

@interface ReturnKeyController ()
@property (nonatomic) LetterView* returnKeyView;
@end

@implementation ReturnKeyController

#pragma mark - Setup
- (void)setupLetterViews
{
   self.returnKeyView = [LetterView viewWithLetter:@"return" fontSize:14.f frame:CGRectZero];
   self.letterViewArray = @[self.returnKeyView];
   [self.view addSubview:self.returnKeyView];
}

@end
