//
//  LetterKeysController.h
//  SoundBoard
//
//  Created by Klein, Greg on 2/5/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "KeyboardLayoutDimensonsProvider.h"

@interface LetterKeysController : UIViewController

+ (instancetype)controllerWithDimensionsProvider:(KeyboardLayoutDimensonsProvider*)provider;
- (void)updateKeyViewFrames;

@property (readonly) NSArray* keyViews;
@property (readonly) NSArray* keyViewCollections;

@end
