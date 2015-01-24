//
//  DeleteKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "DeleteKeyController.h"
#import "LetterView.h"

@interface DeleteKeyController ()
@property (nonatomic) LetterView* deleteView;
@end

@implementation DeleteKeyController

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      [self setupDeleteView];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controller
{
   return [[DeleteKeyController alloc] init];
}

#pragma mark - Setup
- (void)setupDeleteView
{
   self.deleteView = [LetterView viewWithLetter:@"del" fontSize:14.f frame:self.view.bounds];
   [self.view addSubview:self.deleteView];
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   self.view.frame = frame;
   [self.deleteView updateFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
}

@end
