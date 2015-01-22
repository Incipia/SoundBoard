//
//  AutoLayoutView.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/21/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "AutoLayoutView.h"

@implementation AutoLayoutView

+ (instancetype)autoLayoutView
{
   AutoLayoutView* view = [AutoLayoutView new];
   view.translatesAutoresizingMaskIntoConstraints = NO;
   return view;
}

@end
