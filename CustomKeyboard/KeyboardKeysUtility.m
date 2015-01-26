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
   NSArray* characterArray = nil;
   switch (row)
   {
      case KeyboardRowTop:
         characterArray = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"0"];
         break;
         
      case KeyboardRowMiddle:
         characterArray = @[@"-", @"/", @":", @";", @"(", @")", @"$", @"&", @"@", @"\""];
         break;
         
      case KeyboardRowBottom:
         characterArray = @[@".", @",", @"?", @"!", @"'"];
         break;
         
      default:
         break;
   }
   return characterArray;
}

static NSArray* _symbolArray(KeyboardRow row)
{
   NSArray* characterArray = nil;
   switch (row)
   {
      case KeyboardRowTop:
         characterArray = @[@"[", @"]", @"{", @"}", @"#", @"%", @"^", @"*", @"+", @"="];
         break;
         
      case KeyboardRowMiddle:
         characterArray = @[@"_", @"\\", @"|", @"~", @"<", @">", @"€", @"£", @"¥", @"•"];
         break;
         
      case KeyboardRowBottom:
         characterArray = @[@".", @",", @"?", @"!", @"'"];
         break;
         
      default:
         break;
   }
   return characterArray;
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

+ (NSUInteger)numKeysForMode:(KeyboardMode)mode row:(KeyboardRow)row
{
   NSUInteger numKeys = [KeyboardKeysUtility characterArrayForMode:mode row:row].count;
   return isnan(numKeys) ? 0 : numKeys;
}

@end
