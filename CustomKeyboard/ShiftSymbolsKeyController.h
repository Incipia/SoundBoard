//
//  ShiftSymbolsKeyController.h
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeysUtility.h"
#import "FunctionalKeyController.h"

@interface ShiftSymbolsKeyController : FunctionalKeyController

//- (void)updateFrame:(CGRect)frame;
- (void)updateWithMode:(KeyboardMode)mode;

@end
