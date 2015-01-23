//
//  KeyboardKeysController.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeysController.h"

@interface KeyboardKeysController ()
@property (nonatomic) UIView* topLettersContainer;
@property (nonatomic) UIView* middleLettersContainer;
@property (nonatomic) UIView* bottomLettersContainer;
@property (nonatomic) UIView* bottomKeysContainer;
@property (nonatomic, readonly) NSArray* containerViews;
@end

@implementation KeyboardKeysController

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controller
{
   return [[KeyboardKeysController alloc] init];
}

#pragma mark - Setup
- (void)setupContainerViews
{
   self.topLettersContainer = [UIView new];
   self.middleLettersContainer = [UIView new];
   self.bottomLettersContainer = [UIView new];
   self.bottomKeysContainer = [UIView new];

   for (UIView* containerView in self.containerViews)
   {
      [self.view addSubview:containerView];
   }
}

#pragma mark - Lifecycle
- (void)viewDidLoad
{
   [super viewDidLoad];
   [self setupContainerViews];
}

- (void)viewDidLayoutSubviews
{
   [self updateContainerViewFrames];
}

#pragma mark - Update
- (void)updateContainerViewFrames
{
   CGFloat containerViewWidth = CGRectGetWidth(self.view.bounds);
   CGFloat containerViewHeight = CGRectGetHeight(self.view.bounds) / self.containerViews.count;
   CGRect currentContainerViewFrame = CGRectMake(0, 0, containerViewWidth, containerViewHeight);

   for (UIView* containerView in self.containerViews)
   {
      containerView.frame = currentContainerViewFrame;
      currentContainerViewFrame.origin.y += containerViewHeight;
   }
}

#pragma mark - Property Overrides
- (NSArray*)containerViews
{
   return @[self.topLettersContainer, self.middleLettersContainer, self.bottomLettersContainer, self.bottomKeysContainer];
}

@end
