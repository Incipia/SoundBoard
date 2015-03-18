//
//  AutocorrectKeyManager.m
//  SoundBoard
//
//  Created by Gregory Klein on 3/14/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "AutocorrectKeyManager.h"
#import "AutocorrectKeyController.h"
#import "SpellCorrectorBridge.h"
#import "UITextChecker+Additions.h"
#import "SpellCorrectionResult.h"

static NSString* _quotedString(NSString* string)
{
   return [NSString stringWithFormat:@"\"%@\"", string];
}

@interface AutocorrectKeyManager ()
@property (nonatomic) AutocorrectKeyController* primaryController;
@property (nonatomic) AutocorrectKeyController* secondaryController;
@property (nonatomic) AutocorrectKeyController* tertiaryController;
@property (nonatomic) UITextChecker* textChecker;
@property (nonatomic) BOOL primaryControllerCanTrigger;
@end

@implementation AutocorrectKeyManager

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      // this will do nothing if someone else already called this method, we're calling it
      // here just in case the text file used for spell correction hasn't been loaded yet
      [SpellCorrectorBridge loadForSpellCorrection];
      self.textChecker = [UITextChecker new];
   }
   return self;
}

#pragma mark - Public Class Methods
+ (instancetype)sharedManager
{
   static AutocorrectKeyManager* manager = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      manager = [AutocorrectKeyManager new];
   });
   return manager;
}

#pragma mark - Public Instance Methods
- (void)setAutocorrectKeyController:(AutocorrectKeyController *)controller withPriority:(AutocorrectKeyControllerPriority)priority
{
   AutocorrectKeyManager* manager = [[self class] sharedManager];
   switch (priority)
   {
      case AutocorrectControllerPrimary:
         manager.primaryController = controller;
         break;

      case AutocorrectControllerSecondary:
         manager.secondaryController = controller;
         break;

      case AutocorrectControllerTertiary:
         manager.tertiaryController = controller;
         break;

      default:
         break;
   }
}

- (void)updateControllersWithTextInput:(NSString*)text
{
   self.primaryControllerCanTrigger = NO;
   if (text)
   {
      BOOL isUppercase = NO;
      if (text.length > 0)
      {
         unichar firstCharacter = [text characterAtIndex:0];
         isUppercase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:firstCharacter];
      }

      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

         NSArray* corrections = [SpellCorrectorBridge correctionsForText:text];

         // the word was found to be a real word
         if (corrections.count == 0)
         {
            NSString* word = text;
            if (isUppercase)
            {
               word = [word stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                    withString:[[word substringToIndex:1] capitalizedString]];
            }

            NSArray* guesses = [self.textChecker guessesForWord:word];
            if (guesses.count > 0)
            {
               // punctuation hopefully
               NSString* secondaryWord = guesses[0];
               BOOL shouldUseGuess = NO;
               for (int charIndex = 0; charIndex < secondaryWord.length; ++charIndex)
               {
                  if ([secondaryWord characterAtIndex:charIndex] == '\'')
                  {
                     shouldUseGuess = YES;
                     break;
                  }
               }

               if (shouldUseGuess == NO && ![text isEqualToString:word])
               {
                  secondaryWord = _quotedString(text);
               }
               [self.secondaryController updateText:secondaryWord];

               NSString* tertiaryWord = @"";
               if (guesses.count > 1)
               {
                  tertiaryWord = guesses[1];
                  if (isUppercase)
                  {
                     tertiaryWord = [tertiaryWord stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                          withString:[[tertiaryWord substringToIndex:1] capitalizedString]];
                  }
               }
               [self.tertiaryController updateText:tertiaryWord];
            }

            [self.primaryController updateText:_quotedString(word)];
            self.primaryControllerCanTrigger = YES;
         }

         // the word was not found in the dictionary
         if (corrections.count > 0)
         {
            [self.secondaryController updateText:_quotedString(text)];

            SpellCorrectionResult* firstResult = corrections[0];
            NSString* word = firstResult.word;
            if (isUppercase)
            {
               word = [word stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                    withString:[[word substringToIndex:1] capitalizedString]];
            }
            [self.primaryController updateText:word];
            self.primaryControllerCanTrigger = YES;

            if (corrections.count > 1)
            {
               for (int correctionIndex = 1; correctionIndex < corrections.count; ++correctionIndex)
               {
                  SpellCorrectionResult* result = corrections[correctionIndex];
                  NSString* resultWord = result.word;
                  if (![resultWord isEqualToString:word])
                  {
                     if (isUppercase)
                     {
                        resultWord = [resultWord stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                         withString:[[resultWord substringToIndex:1] capitalizedString]];
                     }
                     [self.tertiaryController updateText:resultWord];
                     break;
                  }
               }
            }
         }
      });
   }
   else
   {
      [self resetControllers];
   }
}

- (void)resetControllers
{
   self.primaryControllerCanTrigger = NO;
   [self.primaryController updateText:@""];
   [self.secondaryController updateText:@""];
   [self.tertiaryController updateText:@""];
}

- (BOOL)triggerPrimaryKeyIfPossible
{
   BOOL triggered = NO;
   if (self.primaryControllerCanTrigger)
   {
      [self.primaryController trigger];
      triggered = YES;
   }
   return triggered;
}

@end
