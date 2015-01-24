//
//  KeyboardKeysController.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeysController.h"
#import "KeyViewCollection.h"
#import "DeleteKeyController.h"
#import "ShiftSymbolsKeyController.h"
#import "LetterNumberKeyController.h"
#import "NextKeyboardKeyController.h"
#import "SpacebarKeyController.h"
#import "ReturnKeyController.h"
#import "KeyViewCollectionCreator.h"

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
@property (nonatomic, readonly) NSArray* functionalKeyControllers;

@property (nonatomic) KeyboardMode mode;

@end

@implementation KeyboardKeysController

#pragma mark - Init
- (instancetype)initWithMode:(KeyboardMode)mode
{
   if (self = [super init])
   {
      [self setupLetterKeysCollections];
      [self setupNumberKeysCollections];
      [self setupSymbolKeysCollections];
      [self setupPunctuationKeysCollection];
      [self addKeyCollectionSubviews];
      
      [self setupFunctionalKeyControllers];
      
      [self updateMode:mode];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controllerWithMode:(KeyboardMode)mode
{
   return [[KeyboardKeysController alloc] initWithMode:mode];
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
- (void)setupLetterKeysCollections
{
   self.topLetterKeysCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeLetters row:KeyboardRowTop];
   self.middleLetterKeysCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeLetters row:KeyboardRowMiddle];
   self.bottomLetterKeysCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeLetters row:KeyboardRowBottom];
}

- (void)setupNumberKeysCollections
{
   self.topNumberKeysCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeNumbers row:KeyboardRowTop];
   self.middleNumberKeysCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeNumbers row:KeyboardRowMiddle];
}

- (void)setupSymbolKeysCollections
{
   self.topSymbolKeysCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeSymbols row:KeyboardRowTop];
   self.middleSymbolKeysCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeSymbols row:KeyboardRowMiddle];
}

- (void)setupPunctuationKeysCollection
{
   self.punctuationKeysCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeSymbols row:KeyboardRowBottom];
}

- (void)addKeyCollectionSubviews
{
   for (KeyViewCollection* keyCollection in self.allKeyCollectionsArray)
   {
      [self.view addSubview:keyCollection];
   }
}

- (void)setupFunctionalKeyControllers
{
   self.deleteController = [DeleteKeyController controller];
   self.shiftSymbolsController = [ShiftSymbolsKeyController controller];
   self.letterNumberController = [LetterNumberKeyController controller];
   self.nextKeyboardController = [NextKeyboardKeyController controller];
   self.spacebarKeyController = [SpacebarKeyController controller];
   self.returnKeyController = [ReturnKeyController controller];
   
   for (FunctionalKeyController* controller in self.functionalKeyControllers)
   {
      [self.view addSubview:controller.view];
   }
}

#pragma mark - Update
- (void)updateLetterKeyCollectionFrames
{
   CGFloat topLetterRowWidth = CGRectGetWidth(self.view.bounds);
   int letterRowHeight = CGRectGetHeight(self.view.bounds) / s_totalKeyRows;

   CGFloat characterWidth = self.topLetterKeysCollection.keyWidth;
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
   
   for (KeyViewCollection* numberCollection in self.numberKeysCollectionArray)
   {
      CGRect numberCollectionFrame = CGRectMake(0, currentYPosition, CGRectGetWidth(self.view.bounds), numberRowHeight);
      
      [numberCollection updateFrame:numberCollectionFrame];
      currentYPosition += numberRowHeight;
   }
}

- (void)updateSymbolKeyCollectionFrames
{
   int symbolRowHeight = CGRectGetHeight(self.view.bounds) / s_totalKeyRows;
   NSUInteger currentYPosition = 0;
   
   for (KeyViewCollection* symbolCollection in self.symbolKeysCollectionArray)
   {
      CGRect symbolCollectionFrame = CGRectMake(0, currentYPosition, CGRectGetWidth(self.view.bounds), symbolRowHeight);
      
      [symbolCollection updateFrame:symbolCollectionFrame];
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
   CGFloat width = (CGRectGetMinX(self.bottomLetterKeysCollection.frame) + self.bottomLetterKeysCollection.keyWidth)*.5;
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
   CGFloat width = self.bottomLetterKeysCollection.keyWidth * 5;
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

- (NSArray*)functionalKeyControllers
{
   return @[self.deleteController,
            self.shiftSymbolsController,
            self.letterNumberController,
            self.nextKeyboardController,
            self.spacebarKeyController,
            self.returnKeyController];
}

#pragma mark - Public
- (void)updateMode:(KeyboardMode)mode
{
   NSArray* keyCollectionsToHide = [NSArray array];
   NSArray* keyCollectionsToShow = [NSArray array];
   if (mode != self.mode)
   {
      self.mode = mode;
      switch (mode)
      {
         case KeyboardModeLetters:
            keyCollectionsToHide = [NSArray arrayWithArray:self.numberKeysCollectionArray];
            keyCollectionsToHide = [keyCollectionsToHide arrayByAddingObjectsFromArray:self.symbolKeysCollectionArray];
            keyCollectionsToHide = [keyCollectionsToHide arrayByAddingObject:self.punctuationKeysCollection];
            keyCollectionsToShow = self.letterKeysCollectionArray;
            break;
            
         case KeyboardModeNumbers:
            keyCollectionsToHide = [NSArray arrayWithArray:self.letterKeysCollectionArray];
            keyCollectionsToHide = [keyCollectionsToHide arrayByAddingObjectsFromArray:self.symbolKeysCollectionArray];
            keyCollectionsToShow = [NSArray arrayWithArray:self.numberKeysCollectionArray];
            keyCollectionsToShow = [keyCollectionsToShow arrayByAddingObject:self.punctuationKeysCollection];
            break;
            
         case KeyboardModeSymbols:
            keyCollectionsToHide = [NSArray arrayWithArray:self.letterKeysCollectionArray];
            keyCollectionsToHide = [keyCollectionsToHide arrayByAddingObjectsFromArray:self.numberKeysCollectionArray];
            keyCollectionsToShow = [NSArray arrayWithArray:self.symbolKeysCollectionArray];
            keyCollectionsToShow = [keyCollectionsToShow arrayByAddingObject:self.punctuationKeysCollection];
            break;
            
         default:
            break;
      }
      for (KeyViewCollection* collection in keyCollectionsToHide)
      {
         collection.hidden = YES;
      }
      for (KeyViewCollection* collection in keyCollectionsToShow)
      {
         collection.hidden = NO;
      }
   }
}

@end
