//
//  KeyboardKeysController.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeysController.h"
#import "KeyViewCollection.h"
#import "KeyView.h"
#import "DeleteKeyController.h"
#import "ShiftSymbolsKeyController.h"
#import "LetterNumberKeyController.h"
#import "NextKeyboardKeyController.h"
#import "SpacebarKeyController.h"
#import "ReturnKeyController.h"
#import "KeyViewCollectionCreator.h"
#import "KeyboardLayoutDimensonsProvider.h"

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

@property (nonatomic) NSDictionary* keyFrameTextDictionary;
@property (nonatomic) KeyboardLayoutDimensonsProvider* dimensionsProvider;
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
      [self setupDimensionsProvider];
      
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
   [self.dimensionsProvider updateInputViewFrame:self.view.frame];
   
   [self updateLetterKeyCollectionFrames];
   [self updateNumberKeyCollectionFrames];
   [self updateSymbolKeyCollectionFrames];
   [self updateFunctionalKeysFrames];
   [self updatePunctuationKeysCollectionFrame];
   
   [self updateKeyFrameTextDictionaryListener];
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

- (void)setupDimensionsProvider
{
   self.dimensionsProvider = [KeyboardLayoutDimensonsProvider dimensionsProvider];
}

#pragma mark - Update
- (void)updateLetterKeyCollectionFrames
{
   KeyboardRow rows[] = {KeyboardRowTop, KeyboardRowMiddle, KeyboardRowBottom};
   NSUInteger rowIndex = 0;
   for (KeyViewCollection* letterCollection in self.letterKeysCollectionArray)
   {
      CGRect frame = [self.dimensionsProvider frameForKeyboardMode:KeyboardModeLetters row:rows[rowIndex++]];
      [letterCollection updateFrame:frame];
   }
}

- (void)updateNumberKeyCollectionFrames
{
   KeyboardRow rows[] = {KeyboardRowTop, KeyboardRowMiddle};
   NSUInteger rowIndex = 0;
   for (KeyViewCollection* numberCollection in self.numberKeysCollectionArray)
   {
      CGRect frame = [self.dimensionsProvider frameForKeyboardMode:KeyboardModeNumbers row:rows[rowIndex++]];
      [numberCollection updateFrame:frame];
   }
}

- (void)updateSymbolKeyCollectionFrames
{
   KeyboardRow rows[] = {KeyboardRowTop, KeyboardRowMiddle};
   NSUInteger rowIndex = 0;
   for (KeyViewCollection* symbolCollection in self.symbolKeysCollectionArray)
   {
      CGRect frame = [self.dimensionsProvider frameForKeyboardMode:KeyboardModeSymbols row:rows[rowIndex++]];
      [symbolCollection updateFrame:frame];
   }
}

- (void)updatePunctuationKeysCollectionFrame
{
   CGRect puncutationFrame = [self.dimensionsProvider frameForKeyboardMode:KeyboardModeNumbers row:KeyboardRowBottom];
   [self.punctuationKeysCollection updateFrame:puncutationFrame];
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
   CGRect backspaceKeyFrame = [self.dimensionsProvider frameForKeyboardKeyType:KeyboardDeleteKey];
   [self.deleteController updateFrame:backspaceKeyFrame];
}

- (void)updateShiftSymbolKeyFrame
{
   CGRect shiftKeyFrame = [self.dimensionsProvider frameForKeyboardKeyType:KeyboardShiftKey];
   [self.shiftSymbolsController updateFrame:shiftKeyFrame];
}

- (void)updateLetterNumberKeyFrame
{
   CGRect letterNumberKeyFrame = [self.dimensionsProvider frameForKeyboardKeyType:KeyboardNumbersKey];
   [self.letterNumberController updateFrame:letterNumberKeyFrame];
}

- (void)updateNextKeyboardKeyFrame
{
   CGRect nextKeyboardKeyFrame = [self.dimensionsProvider frameForKeyboardKeyType:KeyboardNextKeyboardKey];
   [self.nextKeyboardController updateFrame:nextKeyboardKeyFrame];
}

- (void)updateSpacebarKeyFrame
{
   CGRect spacebarFrame = [self.dimensionsProvider frameForKeyboardKeyType:KeyboardSpacebarKey];
   [self.spacebarKeyController updateFrame:spacebarFrame];
}

- (void)updateReturnKeyFrame
{
   CGRect returnKeyFrame = [self.dimensionsProvider frameForKeyboardKeyType:KeyboardReturnKey];
   [self.returnKeyController updateFrame:returnKeyFrame];
}

#pragma mark - Helper
- (void)updateKeyFrameTextDictionaryListener
{
   NSMutableDictionary* keyFrameTextDictionary = [NSMutableDictionary dictionary];
   for (KeyViewCollection* collection in self.letterKeysCollectionArray)
   {
      for (KeyView* keyView in collection.keyViews)
      {
         NSLog(@"key: %@, frame: %@", keyView.letter, NSStringFromCGRect(keyView.frame));
         NSValue* rectValue = [NSValue valueWithCGRect:[keyView convertRect:keyView.frame toView:self.view]];
         keyFrameTextDictionary[rectValue] = keyView.letter;
      }
   }
   
   if (self.keyboardMapListener != nil)
   {
      [self.keyboardMapListener updateKeyboardMapDictionary:keyFrameTextDictionary];
   }
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
      
      [self updateKeyFrameTextDictionaryListener];
   }
}

@end
