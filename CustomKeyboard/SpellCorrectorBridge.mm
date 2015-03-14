//
//  SpellCorrectorBridge.m
//  SoundBoard
//
//  Created by Gregory Klein on 3/14/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "SpellCorrectorBridge.h"

#include "SpellCorrector.h"
#include <string>

// Private Class to wrap each pair in the map that is returned by the C++ spell corrector
@interface SpellCorrectionResult : NSObject
@property (nonatomic, copy) NSString* word;
@property (nonatomic) NSUInteger likelyhood;
+ (instancetype)resultWithWord:(NSString*)word likelyhood:(NSUInteger)likelyhood;
@end;

@implementation SpellCorrectionResult
+ (instancetype)resultWithWord:(NSString *)word likelyhood:(NSUInteger)likelyhood
{
   SpellCorrectionResult* result = [SpellCorrectionResult new];
   result.word = word;
   result.likelyhood = likelyhood;
   return result;
}
@end

@interface SpellCorrectorBridge ()
{
   SpellCorrector _corrector;
}

@property (nonatomic) BOOL isLoaded;
@end

@implementation SpellCorrectorBridge

#pragma mark - Private Class Methods
+ (SpellCorrectorBridge*)spellCorrector
{
   static SpellCorrectorBridge* spellCorrector = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      spellCorrector = [SpellCorrectorBridge new];
   });
   return spellCorrector;
}

#pragma mark - Public Class Methods
+ (void)loadForSpellCorrection
{
   SpellCorrectorBridge* spellCorrector = [self spellCorrector];
   if (spellCorrector.isLoaded == NO)
   {
      NSString* filePath = [[NSBundle mainBundle] pathForResource:@"big" ofType:@"txt"];
      spellCorrector->_corrector.load(filePath.fileSystemRepresentation);
      spellCorrector.isLoaded = YES;
   }
}

+ (NSArray*)correctionsForText:(NSString *)text
{
   SpellCorrectorBridge* spellCorrector = [self spellCorrector];
   NSArray* results = nil;
   if (spellCorrector.isLoaded)
   {
      results = [spellCorrector corrections:text];
   }
   return results;
}

#pragma mark - Private
- (NSArray*)corrections:(NSString*)text
{
   Dictionary candidates = _corrector.corrections(text.UTF8String);

   NSMutableArray* results = [NSMutableArray array];
   for (Dictionary::iterator it = candidates.begin(); it != candidates.end(); ++it)
   {
      NSString* word = [NSString stringWithUTF8String:it->first.c_str()];
      SpellCorrectionResult* result = [SpellCorrectionResult resultWithWord:word likelyhood:it->second];

      [results addObject:result];
   }

   return [results sortedArrayUsingComparator:^NSComparisonResult(SpellCorrectionResult* obj1, SpellCorrectionResult* obj2) {

      if (obj1.likelyhood == obj2.likelyhood)
      {
         return NSOrderedSame;
      }
      return (obj1.likelyhood > obj2.likelyhood) ? NSOrderedAscending : NSOrderedDescending;
   }];
}

@end
