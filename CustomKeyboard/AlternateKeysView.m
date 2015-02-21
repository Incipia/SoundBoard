//
//  AlternateKeysView.m
//  SoundBoard
//
//  Created by Klein, Greg on 2/21/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "AlternateKeysView.h"
#import "KeyboardKeyLayer.h"
#import "CALayer+DisableAnimations.h"
#import "KeyView.h"

@interface AlternateKeysView ()
// FOR DEBUGGING:
@property (nonatomic) NSArray* characterArray;
@end

@implementation AlternateKeysView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame])
   {
      self.backgroundColor = [UIColor redColor];
      
      // FOR DEBUGGING:
      self.characterArray = @[@"1", @"2", @"3", @"4", @"5"];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)viewWithKeyView:(KeyView*)keyView direction:(AltKeysViewDirection)direction
{
   return [[self alloc] initWithFrame:keyView.bounds];
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   self.frame = CGRectInset(frame, 4, 8);;
}

@end
