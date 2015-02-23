//
//  ThemeAttributesProvider.h
//  SoundBoard
//
//  Created by Klein, Greg on 2/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyboardTypedefs.h"

@interface ThemeAttributesProvider : NSObject

+ (NSDictionary*)themeAttributesForKeyType:(KeyboardKeyType)type;

@end

extern NSString* const kThemeAttributesFontName;
extern NSString* const kThemeAttributesFontSize;
extern NSString* const kThemeAttributesFontColor;
extern NSString* const kThemeAttributesBackgroundColor;
extern NSString* const kThemeAttributesCornerRadius;
extern NSString* const kThemeAttributesShadowColor;
extern NSString* const kThemeAttributesShadowOffset;
extern NSString* const kThemeAttributesShadowOpacity;
extern NSString* const kThemeAttributesShadowRadius;
extern NSString* const kThemeAttributesbackgroundEdgeInsets;
