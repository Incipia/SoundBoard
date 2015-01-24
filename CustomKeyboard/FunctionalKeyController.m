//
//  FunctionalKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "FunctionalKeyController.h"
#import "KeyView.h"

@interface FunctionalKeyController ()
@end

@implementation FunctionalKeyController

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      [self setupLetterViews];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controller
{
   FunctionalKeyController* controller = [[[self class] alloc] init];
   return controller;
}

#pragma mark - Setup
- (void)setupLetterViews
{
   // should be overridden!
}

#pragma mark - Update
- (void)updateLetterViewFrames:(CGRect)frame
{
   CGRect letterViewFrame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
   for (KeyView* letterView in self.letterViewArray)
   {
      [letterView updateFrame:letterViewFrame];
   }
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   self.view.frame = frame;
   [self updateLetterViewFrames:frame];
}

@end
