//
//  ReturnKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "ReturnKeyController.h"
#import "KeyView.h"

@interface ReturnKeyController ()
@property (nonatomic) KeyView* returnKeyView;
@end

@implementation ReturnKeyController

#pragma mark - Setup
- (void)setupLetterViews
{
   self.returnKeyView = [KeyView viewWithLetter:@"return" fontSize:14.f frame:CGRectZero];
   self.keyViewArray = @[self.returnKeyView];
   [self.view addSubview:self.returnKeyView];
}

@end
