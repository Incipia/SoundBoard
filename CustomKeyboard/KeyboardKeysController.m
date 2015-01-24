//
//  KeyboardKeysController.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeysController.h"
#import "KeyViewCollection.h"
#import "KeyboardKeysUtility.h"
#import "DeleteKeyController.h"
#import "ShiftSymbolsKeyController.h"
#import "LetterNumberKeyController.h"
#import "NextKeyboardKeyController.h"
#import "SpacebarKeyController.h"
#import "ReturnKeyController.h"

static const int s_totalKeyRows = 4;

@interface KeyboardKeysController ()

@property (nonatomic) KeyViewCollection* topLetterKeysCollection;
@property (nonatomic) KeyViewCollection* middleLetterKeysCollection;
@property (nonatomic) KeyViewCollection* bottomLetterKeysCollection;

@property (nonatomic) KeyViewCollection* topNumberKeysCollection;
@property (nonatomic) KeyViewCollection* middleNumberKeysCollection;

@property (nonatomic) KeyViewCollection* topSymbolKeysCollection;
@property (nonatomic) KeyViewCollection* middleSymbolKeysCollection;

@property (nonatomic) KeyViewCollection* punctuationKeysCollection;

@property (nonatomic) DeleteKeyController* deleteController;
@property (nonatomic) ShiftSymbolsKeyController* shiftSymbolsController;
@property (nonatomic) LetterNumberKeyController* letterNumberController;
@property (nonatomic) NextKeyboardKeyController* nextKeyboardController;
@property (nonatomic) SpacebarKeyController* spacebarKeyController;
@property (nonatomic) ReturnKeyController* returnKeyController;

@property (nonatomic, readonly) NSArray* letterKeysCollectionArray;
@property (nonatomic, readonly) NSArray* numberKeysCollectionArray;
@property (nonatomic, readonly) NSArray* symbolKeysCollectionArray;
@property (nonatomic, readonly) NSArray* allKeyCollectionsArray;

@end

@implementation KeyboardKeysController

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      [self setupLetterKeyCollections];
      [self setupFunctionalKeyControllers];
      [self setupNumberKeysCollections];
      [self setupSymbolKeysCollections];
      [self setupPunctuationKeysCollection];
      [self addKeyCollectionsAsSubviews];
      
      for (KeyViewCollection* collection in self.numberKeysCollectionArray)
      {
         collection.hidden = YES;
      }
      for (KeyViewCollection* collection in self.symbolKeysCollectionArray)
      {
         collection.hidden = YES;
      }
      self.punctuationKeysCollection.hidden = YES;
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controller
{
   return [[KeyboardKeysController alloc] init];
}

#pragma mark - Lifecycle
- (void)viewDidLayoutSubviews
{
   [self updateLetterKeyCollectionFrames];
   [self updateNumberKeyCollectionFrames];
   [self updateSymbolKeyCollectionFrames];
   [self updateFunctionalKeysFrames];
   [self updatePunctuationKeysCollectionFrame];
}

#pragma mark - Setup
- (void)setupLetterKeyCollections
{
   NSArray* topLetters = [KeyboardKeysUtility characterArrayForMode:KeyboardModeLetters row:KeyboardRowTop];
   self.topLetterKeysCollection = [KeyViewCollection collectionWithCharacterArray:topLetters];

   NSArray* middleLetters = [KeyboardKeysUtility characterArrayForMode:KeyboardModeLetters row:KeyboardRowMiddle];
   self.middleLetterKeysCollection = [KeyViewCollection collectionWithCharacterArray:middleLetters];

   NSArray* bottomLetters = [KeyboardKeysUtility characterArrayForMode:KeyboardModeLetters row:KeyboardRowBottom];
   self.bottomLetterKeysCollection = [KeyViewCollection collectionWithCharacterArray:bottomLetters];
}

- (void)setupNumberKeysCollections
{
   NSArray* topNumberKeys = [KeyboardKeysUtility characterArrayForMode:KeyboardModeNumbers row:KeyboardRowTop];
   self.topNumberKeysCollection = [KeyViewCollection collectionWithCharacterArray:topNumberKeys];
   
   NSArray* middleNumberKeys = [KeyboardKeysUtility characterArrayForMode:KeyboardModeNumbers row:KeyboardRowMiddle];
   self.middleNumberKeysCollection = [KeyViewCollection collectionWithCharacterArray:middleNumberKeys];
}

- (void)setupSymbolKeysCollections
{
   NSArray* topSymbolKeys = [KeyboardKeysUtility characterArrayForMode:KeyboardModeSymbols row:KeyboardRowTop];
   self.topSymbolKeysCollection = [KeyViewCollection collectionWithCharacterArray:topSymbolKeys];
   
   NSArray* middleSymbolKeys = [KeyboardKeysUtility characterArrayForMode:KeyboardModeSymbols row:KeyboardRowMiddle];
   self.middleSymbolKeysCollection = [KeyViewCollection collectionWithCharacterArray:middleSymbolKeys];
}

- (void)setupPunctuationKeysCollection
{
   NSArray* punctuationKeys = [KeyboardKeysUtility characterArrayForMode:KeyboardModeSymbols row:KeyboardRowBottom];
   self.punctuationKeysCollection = [KeyViewCollection collectionWithCharacterArray:punctuationKeys];
}

- (void)addKeyCollectionsAsSubviews
{
   for (KeyViewCollection* keyCollection in self.allKeyCollectionsArray)
   {
      [self.view addSubview:keyCollection];
   }
}

- (void)setupFunctionalKeyControllers
{
   self.deleteController = [DeleteKeyController controller];
   [self.view addSubview:self.deleteController.view];
   
   self.shiftSymbolsController = [ShiftSymbolsKeyController controller];
   [self.view addSubview:self.shiftSymbolsController.view];
   
   self.letterNumberController = [LetterNumberKeyController controller];
   [self.view addSubview:self.letterNumberController.view];
   
   self.nextKeyboardController = [NextKeyboardKeyController controller];
   [self.view addSubview:self.nextKeyboardController.view];
   
   self.spacebarKeyController = [SpacebarKeyController controller];
   [self.view addSubview:self.spacebarKeyController.view];
   
   self.returnKeyController = [ReturnKeyController controller];
   [self.view addSubview:self.returnKeyController.view];
}

#pragma mark - Update
- (void)updateLetterKeyCollectionFrames
{
   CGFloat topLetterRowWidth = CGRectGetWidth(self.view.bounds);
   int letterRowHeight = CGRectGetHeight(self.view.bounds) / s_totalKeyRows;

   CGFloat characterWidth = self.topLetterKeysCollection.generatedKeyWidth;
   CGFloat middleLetterRowWidth = self.middleLetterKeysCollection.characterCount*characterWidth;
   CGFloat bottomLetterRowWidth = self.bottomLetterKeysCollection.characterCount*characterWidth;

   CGFloat letterRowWidths[] = {topLetterRowWidth, middleLetterRowWidth, bottomLetterRowWidth};
   NSUInteger letterRowWidthIndex = 0;
   NSUInteger currentYPosition = 0;

   for (KeyViewCollection* letterCollection in self.letterKeysCollectionArray)
   {
      CGFloat currentLetterRowWidth = letterRowWidths[letterRowWidthIndex++];
      CGFloat xPosition = CGRectGetMidX(self.view.bounds) - (currentLetterRowWidth*.5);
      CGRect letterCollectionFrame = CGRectMake(xPosition, currentYPosition, currentLetterRowWidth, letterRowHeight);

      [letterCollection updateFrame:letterCollectionFrame];
      currentYPosition += letterRowHeight;
   }
}

- (void)updateNumberKeyCollectionFrames
{
   int numberRowHeight = CGRectGetHeight(self.view.bounds) / s_totalKeyRows;
   NSUInteger currentYPosition = 0;
   
   for (KeyViewCollection* letterCollection in self.numberKeysCollectionArray)
   {
      CGRect numberCollectionFrame = CGRectMake(0, currentYPosition, CGRectGetWidth(self.view.bounds), numberRowHeight);
      
      [letterCollection updateFrame:numberCollectionFrame];
      currentYPosition += numberRowHeight;
   }
}

- (void)updateSymbolKeyCollectionFrames
{
   int symbolRowHeight = CGRectGetHeight(self.view.bounds) / s_totalKeyRows;
   NSUInteger currentYPosition = 0;
   
   for (KeyViewCollection* letterCollection in self.symbolKeysCollectionArray)
   {
      CGRect symbolCollectionFrame = CGRectMake(0, currentYPosition, CGRectGetWidth(self.view.bounds), symbolRowHeight);
      
      [letterCollection updateFrame:symbolCollectionFrame];
      currentYPosition += symbolRowHeight;
   }
}

- (void)updatePunctuationKeysCollectionFrame
{
   CGFloat xPosition = CGRectGetMaxX(self.shiftSymbolsController.view.frame);
   CGFloat yPosition = CGRectGetMaxY(self.middleSymbolKeysCollection.frame);
   CGFloat width = CGRectGetMinX(self.deleteController.view.frame) - CGRectGetMaxX(self.shiftSymbolsController.view.frame);
   int height = CGRectGetHeight(self.view.bounds) / s_totalKeyRows;
   
   [self.punctuationKeysCollection updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateFunctionalKeysFrames
{
   [self updateDeleteKeyFrame];
   [self updateShiftSymbolKeyFrame];
   [self updateLetterNumberKeyFrame];
   [self updateNextKeyboardKeyFrame];
   [self updateSpacebarKeyFrame];
   [self updateReturnKeyFrame];
}

- (void)updateDeleteKeyFrame
{
   CGFloat xPosition = CGRectGetMaxX(self.bottomLetterKeysCollection.frame);
   CGFloat yPosition = CGRectGetMinY(self.bottomLetterKeysCollection.frame);
   CGFloat width = CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(self.bottomLetterKeysCollection.frame);
   CGFloat height = CGRectGetHeight(self.bottomLetterKeysCollection.bounds);
   
   [self.deleteController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateShiftSymbolKeyFrame
{
   CGFloat xPosition = 0;
   CGFloat yPosition = CGRectGetMinY(self.bottomLetterKeysCollection.frame);
   CGFloat width = CGRectGetMinX(self.bottomLetterKeysCollection.frame);
   CGFloat height = CGRectGetHeight(self.bottomLetterKeysCollection.frame);
   
   [self.shiftSymbolsController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateLetterNumberKeyFrame
{
   CGFloat xPosition = 0;
   CGFloat yPosition = CGRectGetMaxY(self.bottomLetterKeysCollection.frame);
   CGFloat width = (CGRectGetMinX(self.bottomLetterKeysCollection.frame) + self.bottomLetterKeysCollection.generatedKeyWidth) * .5;
   CGFloat height = CGRectGetHeight(self.view.frame) - yPosition;
   
   [self.letterNumberController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateNextKeyboardKeyFrame
{
   CGFloat xPosition = CGRectGetMaxX(self.letterNumberController.view.frame);
   CGFloat yPosition = CGRectGetMaxY(self.bottomLetterKeysCollection.frame);
   CGFloat width = CGRectGetWidth(self.letterNumberController.view.frame);
   CGFloat height = CGRectGetHeight(self.view.frame) - yPosition;
   
   [self.nextKeyboardController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateSpacebarKeyFrame
{
   CGFloat xPosition = CGRectGetMaxX(self.nextKeyboardController.view.frame);
   CGFloat yPosition = CGRectGetMaxY(self.bottomLetterKeysCollection.frame);
   CGFloat width = self.bottomLetterKeysCollection.generatedKeyWidth * 5;
   CGFloat height = CGRectGetHeight(self.view.frame) - yPosition;
   
   [self.spacebarKeyController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateReturnKeyFrame
{
   CGFloat xPosition = CGRectGetMaxX(self.spacebarKeyController.view.frame);
   CGFloat yPosition = CGRectGetMaxY(self.bottomLetterKeysCollection.frame);
   CGFloat width = CGRectGetWidth(self.view.frame) - CGRectGetMaxX(self.spacebarKeyController.view.frame);
   CGFloat height = CGRectGetHeight(self.view.frame) - yPosition;
   
   [self.returnKeyController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

#pragma mark - Property Overrides
- (NSArray*)letterKeysCollectionArray
{
   return @[self.topLetterKeysCollection, self.middleLetterKeysCollection, self.bottomLetterKeysCollection];
}

- (NSArray*)numberKeysCollectionArray
{
   return @[self.topNumberKeysCollection, self.middleNumberKeysCollection];
}

- (NSArray*)symbolKeysCollectionArray
{
   return @[self.topSymbolKeysCollection, self.middleSymbolKeysCollection];
}

- (NSArray*)allKeyCollectionsArray
{
   NSArray* allKeyCollections = [NSArray arrayWithArray:self.letterKeysCollectionArray];
   allKeyCollections = [allKeyCollections arrayByAddingObjectsFromArray:self.numberKeysCollectionArray];
   allKeyCollections = [allKeyCollections arrayByAddingObjectsFromArray:self.symbolKeysCollectionArray];
   allKeyCollections = [allKeyCollections arrayByAddingObject:self.punctuationKeysCollection];
   return allKeyCollections;
}

@end
