//
//  KeysController.m
//  SoundBoard
//
//  Created by Klein, Greg on 2/6/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeysController.h"
#import "KeyViewCollection.h"

@interface KeysController ()
@property (nonatomic) KeyboardLayoutDimensonsProvider* dimensionsProvider;
@end

@implementation KeysController

#pragma mark - Init
- (instancetype)initWithDimensionsProvider:(KeyboardLayoutDimensonsProvider*)provider
{
   if (self = [super init])
   {
      self.dimensionsProvider = provider;
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controllerWithDimensionsProvider:(KeyboardLayoutDimensonsProvider*)provider
{
   return [[[self class] alloc] initWithDimensionsProvider:provider];
}

#pragma mark - Public
- (void)updateKeyViewFrames
{
}


@end
