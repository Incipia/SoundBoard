//
//  CALayer+KeyType.h
//  SoundBoard
//
//  Created by Klein, Greg on 2/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "KeyboardTypedefs.h"

@interface CALayer (KeyType)

+ (instancetype)layerWithKeyType:(KeyboardKeyType)type;

@end
