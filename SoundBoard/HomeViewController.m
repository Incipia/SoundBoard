//
//  HomeViewController.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/17/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

#pragma mark - Init
- (instancetype)init
{
   NSString* className = NSStringFromClass([self class]);
   if (self = [super initWithNibName:className bundle:nil])
   {
   }
   return self;
}

#pragma mark - Class Methods
+ (instancetype)controller
{
   return [[self alloc] init];
}

@end
