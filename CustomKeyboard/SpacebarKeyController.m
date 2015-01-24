//
//  SpacebarKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "SpacebarKeyController.h"
#import "LetterView.h"

@interface SpacebarKeyController ()
@property (nonatomic) LetterView* spacebarKeyView;
@end

@implementation SpacebarKeyController

#pragma mark - Setup
- (void)setupLetterViews
{
   self.spacebarKeyView = [LetterView viewWithLetter:@"space" fontSize:14.f frame:CGRectZero];
   self.letterViewArray = @[self.spacebarKeyView];
   [self.view addSubview:self.spacebarKeyView];
}

@end
