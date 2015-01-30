//
//  NextKeyboardController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "NextKeyboardKeyController.h"
#import "KeyView.h"

@interface NextKeyboardKeyController ()
@property (nonatomic) KeyView* nextKeyboardKeyView;
@end

@implementation NextKeyboardKeyController

#pragma mark - Setup
- (void)setupKeyViews
{
   self.nextKeyboardKeyView = [KeyView viewWithText:@"next" fontSize:14.f frame:CGRectZero];
   self.keyViewArray = @[self.nextKeyboardKeyView];
   [self.view addSubview:self.nextKeyboardKeyView];
}

#pragma mark - Public
- (KeyView*)keyViewForMode:(KeyboardMode)mode
{
   return self.nextKeyboardKeyView;
}

@end
