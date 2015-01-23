//
//  KeyboardAuxilaryController.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardAuxilaryController.h"

@interface KeyboardAuxilaryController ()
@end

@implementation KeyboardAuxilaryController

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
   return [[KeyboardAuxilaryController alloc] init];
}

- (void)viewDidLoad
{
   [super viewDidLoad];
   self.view.backgroundColor = [UIColor redColor];
}

@end
