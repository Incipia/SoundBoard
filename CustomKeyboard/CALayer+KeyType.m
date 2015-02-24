//
//  CALayer+KeyType.m
//  SoundBoard
//
//  Created by Klein, Greg on 2/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "CALayer+KeyType.h"
#import "CALayer+DisableAnimations.h"
#import "ThemeAttributesProvider.h"

@implementation CALayer (KeyType)

+ (instancetype)layerWithKeyType:(KeyboardKeyType)type
{
   CALayer* layer = [self layer];
   
   layer.backgroundColor = [ThemeAttributesProvider backgroundColorForKeyType:type].CGColor;
   layer.cornerRadius = [ThemeAttributesProvider cornerRadiusForKeyType:type];
   layer.shadowOpacity = [ThemeAttributesProvider shadowOpacityForKeyType:type];
   layer.shadowRadius = [ThemeAttributesProvider shadowRadiusForKeyType:type];
   layer.shadowOffset = [ThemeAttributesProvider shadowOffsetForKeyType:type];
   
   [layer disableAnimations];
   
   return layer;
}

@end
