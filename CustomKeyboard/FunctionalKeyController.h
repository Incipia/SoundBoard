//
//  FunctionalKeyController.h
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionalKeyController : UIViewController

+ (instancetype)controller;

// Override!
- (void)setupLetterViews;

- (void)updateFrame:(CGRect)frame;

@property (nonatomic) NSArray* letterViewArray;

@end
