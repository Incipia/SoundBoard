//
//  LetterKeysController.m
//  SoundBoard
//
//  Created by Klein, Greg on 2/5/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "LetterKeysController.h"
#import "KeyViewCollection.h"
#import "KeyViewCollectionCreator.h"

@class KeyView;
@interface LetterKeysController ()
@property (nonatomic) KeyboardLayoutDimensonsProvider* dimensionsProvider;
@property (nonatomic) KeyViewCollection* topLettersCollection;
@property (nonatomic) KeyViewCollection* middleLettersCollection;
@property (nonatomic) KeyViewCollection* bottomLettersCollection;
@end

@implementation LetterKeysController

#pragma mark - Init
- (instancetype)initWithDimensionsProvider:(KeyboardLayoutDimensonsProvider*)provider
{
   if (self = [super init])
   {
      self.dimensionsProvider = provider;
      [self setupKeyViewCollections];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controllerWithDimensionsProvider:(KeyboardLayoutDimensonsProvider*)provider
{
   return [[[self class] alloc] initWithDimensionsProvider:provider];
}

#pragma mark - Setup
- (void)setupKeyViewCollections
{
   self.topLettersCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeLetters row:KeyboardRowTop];
   self.middleLettersCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeLetters row:KeyboardRowMiddle];
   self.bottomLettersCollection = [KeyViewCollectionCreator collectionForMode:KeyboardModeLetters row:KeyboardRowBottom];
   
   for (KeyViewCollection* collection in self.keyViewCollections)
   {
      [self.view addSubview:collection];
   }
}

#pragma mark - Helper
- (void)updateKeyCollectionForRow:(KeyboardRow)row withFrame:(CGRect)frame
{
   KeyViewCollection* collection = nil;
   switch (row)
   {
      case KeyboardRowTop:
         collection = self.topLettersCollection;
         break;
      case KeyboardRowMiddle:
         collection = self.middleLettersCollection;
         break;
      case KeyboardRowBottom:
         collection = self.bottomLettersCollection;
         break;
      default:
         break;
   }
   [collection updateFrame:frame];
}

#pragma mark - Public
- (void)updateKeyViewFrames
{
   KeyboardRow rows[] = {KeyboardRowTop, KeyboardRowMiddle, KeyboardRowBottom};
   for (int rowIndex = 0; rowIndex < 3; ++rowIndex)
   {
      KeyboardRow currentRow = rows[rowIndex];
      CGRect frame = [self.dimensionsProvider frameForKeyboardMode:KeyboardModeLetters row:currentRow];
      [self updateKeyCollectionForRow:currentRow withFrame:frame];
   }
}

#pragma mark - Property Overrides
- (NSArray*)keyViews
{
   NSMutableArray* keyViewArray = [NSMutableArray array];
   for (KeyViewCollection* collection in self.keyViewCollections)
   {
      for (KeyView* keyView in collection.keyViews)
      {
         [keyViewArray addObject:keyView];
      }
   }
   return keyViewArray;
}

- (NSArray*)keyViewCollections
{
   return @[self.topLettersCollection, self.middleLettersCollection, self.bottomLettersCollection];
}

@end
