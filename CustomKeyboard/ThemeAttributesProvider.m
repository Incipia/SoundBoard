//
//  ThemeAttributesProvider.m
//  SoundBoard
//
//  Created by Klein, Greg on 2/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "ThemeAttributesProvider.h"

NSString* const kThemeAttributesFontName = @"kThemeAttributesFontName";
NSString* const kThemeAttributesFontSize = @"kThemeAttributesFontSize";
NSString* const kThemeAttributesFontColor = @"kThemeAttributesFontColor";
NSString* const kThemeAttributesBackgroundColor = @"kThemeAttributesBackgroundColor";
NSString* const kThemeAttributesCornerRadius = @"kThemeAttributesCornerRadius";
NSString* const kThemeAttributesShadowColor = @"kThemeAttributesShadowColor";
NSString* const kThemeAttributesShadowOffset = @"kThemeAttributesShadowOffset";
NSString* const kThemeAttributesShadowOpacity = @"kThemeAttributesShadowOpacity";
NSString* const kThemeAttributesShadowRadius = @"kThemeAttributesShadowRadius";
NSString* const kThemeAttributesbackgroundEdgeInsets = @"kThemeAttributesbackgroundEdgeInsets";

@implementation ThemeAttributesProvider

+ (NSDictionary*)themeAttributesForKeyType:(KeyboardKeyType)type
{
   return nil;
}

@end
