//
//  NSString+Additions.m
//  SoundBoard
//
//  Created by Gregory Klein on 3/17/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString*)titleCase
{
   NSString* titleCaseString = nil;
   if (self.length > 0)
   {
      titleCaseString = [self stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                      withString:[[self substringToIndex:1] capitalizedString]];
   }
   return titleCaseString;
}

@end
