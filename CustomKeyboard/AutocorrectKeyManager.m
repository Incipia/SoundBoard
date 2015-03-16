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
   if (text)
   {
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

         NSArray* corrections = [SpellCorrectorBridge correctionsForText:text];

         // the word was found to be a real word
         if (corrections.count == 1)
         {
            SpellCorrectionResult* result = corrections[0];
            NSArray* guesses = [self.textChecker guessesForWord:result.word];

            if (guesses.count > 0)
            {
               // punctuation hopefully
               [self.secondaryController updateText:guesses[0]];
            }

            [self.primaryController updateText:_quotedString(result.word)];
         }

         // the word was not found in the dictionary
         if (corrections.count > 1)
         {
            [self.secondaryController updateText:_quotedString(text)];

            SpellCorrectionResult* firstResult = corrections[0];
            [self.primaryController updateText:firstResult.word];

            if (corrections.count > 2)
            {
               SpellCorrectionResult* secondResult = corrections[1];
               [self.tertiaryController updateText:secondResult.word];
            }
         }
      });
   }
   else
   {
      [self.primaryController updateText:@""];
      [self.secondaryController updateText:@""];
      [self.tertiaryController updateText:@""];
   }
}

@end
