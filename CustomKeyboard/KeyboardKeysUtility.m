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

+ (NSArray*)altCharacterArrayForCharacter:(NSString*)character
{
   NSArray* characterArray = nil;
   NSString* uppercaseCharacter = character.uppercaseString;
   
   if ([uppercaseCharacter isEqualToString:@"E"])
   {
      characterArray = @[@"È", @"É", @"Ê", @"Ë", @"Ē", @"Ė", @"Ę"];
   }
   else if ([uppercaseCharacter isEqualToString:@"Y"])
   {
      characterArray = @[@"Ÿ"];
   }
   else if ([uppercaseCharacter isEqualToString:@"U"])
   {
      characterArray = @[@"Ū", @"Ú", @"Ù", @"Ü", @"Û"];
   }
   else if ([uppercaseCharacter isEqualToString:@"I"])
   {
      characterArray = @[@"Ì", @"Į", @"Ī", @"Í", @"Ï", @"Î"];
   }
   else if ([uppercaseCharacter isEqualToString:@"O"])
   {
      characterArray = @[@"Õ", @"Ō", @"Ø", @"Œ", @"Ó", @"Ò", @"Ö", @"Ô"];
   }
   else if ([uppercaseCharacter isEqualToString:@"A"])
   {
      characterArray = @[@"À", @"Á", @"Â", @"Ä", @"Æ", @"Ã", @"Å", @"Ā"];
   }
   else if ([uppercaseCharacter isEqualToString:@"S"])
   {
      characterArray = @[@"Ś", @"Š"];
   }
   else if ([uppercaseCharacter isEqualToString:@"L"])
   {
      characterArray = @[@"Ł"];
   }
   else if ([uppercaseCharacter isEqualToString:@"Z"])
   {
      characterArray = @[@"Ž", @"Ź", @"Ż"];
   }
   else if ([uppercaseCharacter isEqualToString:@"C"])
   {
      characterArray = @[@"Ç", @"Ć", @"Č"];
   }
   else if ([uppercaseCharacter isEqualToString:@"N"])
   {
      characterArray = @[@"Ń", @"Ñ"];
   }
   else if ([uppercaseCharacter isEqualToString:@"%"])
   {
      characterArray = @[@"‰"];
   }
   else if ([uppercaseCharacter isEqualToString:@"."])
   {
      characterArray = @[@"…"];
   }
   else if ([uppercaseCharacter isEqualToString:@"?"])
   {
      characterArray = @[@"¿"];
   }
   else if ([uppercaseCharacter isEqualToString:@"!"])
   {
      characterArray = @[@"¡"];
   }
   else if ([uppercaseCharacter isEqualToString:@"'"])
   {
      characterArray = @[@"`", @"‘", @"’"];
   }
   else if ([uppercaseCharacter isEqualToString:@"0"])
   {
      characterArray = @[@"°"];
   }
   else if ([uppercaseCharacter isEqualToString:@"-"])
   {
      characterArray = @[@"–", @"—", @"•"];
   }
   else if ([uppercaseCharacter isEqualToString:@"/"])
   {
      characterArray = @[@"\\"];
   }
   else if ([uppercaseCharacter isEqualToString:@"$"])
   {
      characterArray = @[@"₽", @"¥", @"€", @"¢", @"£", @"₩"];
   }
   else if ([uppercaseCharacter isEqualToString:@"&"])
   {
      characterArray = @[@"§"];
   }
   else if ([uppercaseCharacter isEqualToString:@"\""])
   {
      characterArray = @[@"«", @"»", @"„", @"“", @"”"];
   }
   return characterArray;
}

+ (NSUInteger)numKeysForMode:(KeyboardMode)mode row:(KeyboardRow)row
{
   NSUInteger numKeys = [KeyboardKeysUtility characterArrayForMode:mode row:row].count;
   return isnan(numKeys) ? 0 : numKeys;
}

@end
