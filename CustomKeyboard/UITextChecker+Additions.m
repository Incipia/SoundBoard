//
//  UITextChecker+Additions.m
//  SoundBoard
//
//  Created by Gregory Klein on 3/14/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "UITextChecker+Additions.h"

static NSString* _deviceLanguage()
{
   return [[NSLocale preferredLanguages] objectAtIndex:0];
}

@implementation UITextChecker (Additions)

- (NSArray*)guessesForWord:(NSString *)word
{
   return [self guessesForWordRange:NSMakeRange(0, word.length) inString:word language:_deviceLanguage()];
}

- (NSArray*)completionsForWord:(NSString*)word
{
   return [self completionsForPartialWordRange:NSMakeRange(0, word.length) inString:word language:_deviceLanguage()];
}

@end
