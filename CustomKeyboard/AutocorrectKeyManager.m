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
         NSArray* guesses = [self.textChecker guessesForWord:text];
         NSArray* completions = [self.textChecker completionsForWord:text];

         NSLog(@"results for word: %@", text);
         for (SpellCorrectionResult* result in corrections)
         {
            NSLog(@"result: %@, %lu", result.word, (unsigned long)result.likelyhood);
         }
         if (corrections.count > 0)
         {
            SpellCorrectionResult* result = corrections.firstObject;
            [self.primaryController updateText:result.word];
         }
         if (corrections.count > 1)
         {
            SpellCorrectionResult* result = corrections[1];
            [self.secondaryController updateText:result.word];
         }
         if (corrections.count > 2)
         {
            SpellCorrectionResult* result = corrections[2];
            [self.tertiaryController updateText:result.word];
         }

         if (corrections.count == 0)
         {
            [self.primaryController updateText:[NSString stringWithFormat:@"\"%@\"", text]];
         }
         //
         //      if (guesses.count > 0)
         //      {
         //         SpellCorrectionResult* result = guesses[0];
         //         [self.secondaryController updateText:result.word];
         //      }
         //      if (completions.count > 0)
         //      {
         //         SpellCorrectionResult* result = completions[0];
         //         [self.tertiaryController updateText:result.word];
         //      }
      });
   }
   else
   {
      [self.primaryController updateText:text];
      [self.secondaryController updateText:@""];
      [self.tertiaryController updateText:@""];
   }
}

@end
