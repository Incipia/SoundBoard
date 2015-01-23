//
//  KeyboardKeysUtility.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeysUtility.h"

static NSArray* _letterArray(KeyboardRow row)
{
   NSArray* characterArray = nil;
   switch (row)
   {
      case KeyboardRowTop:
         characterArray = @[@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P"];
         break;

      case KeyboardRowMiddle:
         characterArray = @[@"A", @"S", @"D", @"F", @"G", @"H", @"J", @"K", @"L"];
         break;

      case KeyboardRowBottom:
         characterArray = @[@"Z", @"X", @"C", @"V", @"B", @"N", @"M"];
         break;

      default:
         break;
   }
   return characterArray;
}

static NSArray* _numberArray(KeyboardRow row)
{
   return nil;
}

static NSArray* _symbolArray(KeyboardRow row)
{
   return nil;
}

@implementation KeyboardKeysUtility

+ (NSArray*)characterArrayForMode:(KeyboardMode)mode row:(KeyboardRow)row
{
   NSArray* characterArray = nil;
   switch (mode)
   {
      case KeyboardModeLetters:
         characterArray = _letterArray(row);
         break;

      case KeyboardModeNumbers:
         characterArray = _numberArray(row);
         break;

      case KeyboardModeSymbols:
         characterArray = _symbolArray(row);

      default:
         break;
   }
   return characterArray;
}

@end
