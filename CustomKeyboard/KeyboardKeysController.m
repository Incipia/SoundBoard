//
//  KeyboardKeysController.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeysController.h"
#import "LetterViewCollection.h"
#import "KeyboardKeysUtility.h"

static const int s_topRowLetterCount = 10;
static const int s_middleRowLetterCount = 9;
static const int s_bottomRowLetterCount = 7;
static const int s_totalKeyRows = 4;

@interface KeyboardKeysController ()
@property (nonatomic) LetterViewCollection* topLettersContainer;
@property (nonatomic) LetterViewCollection* middleLettersContainer;
@property (nonatomic) LetterViewCollection* bottomLettersContainer;
@property (nonatomic) UIView* bottomKeysContainer;
@property (nonatomic, readonly) NSArray* containerViews;
@end

@implementation KeyboardKeysController

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controller
{
   return [[KeyboardKeysController alloc] init];
}

#pragma mark - Setup
- (void)setupLetterRowViews
{
   NSArray* topLetters = [KeyboardKeysUtility characterArrayForMode:KeyboardModeLetters row:KeyboardRowTop];
   self.topLettersContainer = [LetterViewCollection collectionWithCharacterArray:topLetters];

   NSArray* middleLetters = [KeyboardKeysUtility characterArrayForMode:KeyboardModeLetters row:KeyboardRowMiddle];
   self.middleLettersContainer = [LetterViewCollection collectionWithCharacterArray:middleLetters];

   NSArray* bottomLetters = [KeyboardKeysUtility characterArrayForMode:KeyboardModeLetters row:KeyboardRowBottom];
   self.bottomLettersContainer = [LetterViewCollection collectionWithCharacterArray:bottomLetters];

   for (LetterViewCollection* letterRowView in self.containerViews)
   {
      [self.view addSubview:letterRowView];
   }
}

#pragma mark - Lifecycle
- (void)viewDidLoad
{
   [super viewDidLoad];
   [self setupLetterRowViews];
}

- (void)viewDidLayoutSubviews
{
   [self updateContainerViewFrames];
}

#pragma mark - Update
- (void)updateContainerViewFrames
{
   CGFloat topLetterRowWidth = CGRectGetWidth(self.view.bounds);
   int letterRowHeight = CGRectGetHeight(self.view.bounds) / s_totalKeyRows;

   CGFloat characterWidth = topLetterRowWidth / s_topRowLetterCount;
   CGFloat middleLetterRowWidth = s_middleRowLetterCount * characterWidth;
   CGFloat bottomLetterRowWidth = s_bottomRowLetterCount * characterWidth;

   CGFloat letterRowWidths[] = {topLetterRowWidth, middleLetterRowWidth, bottomLetterRowWidth};
   NSUInteger letterRowWidthIndex = 0;
   NSUInteger currentYPosition = 0;

   for (LetterViewCollection* letterCollection in self.containerViews)
   {
      CGFloat currentLetterRowWidth = letterRowWidths[letterRowWidthIndex++];
      CGFloat xPosition = CGRectGetMidX(self.view.bounds) - (currentLetterRowWidth * .5);
      CGRect letterCollectionFrame = CGRectMake(xPosition, currentYPosition, currentLetterRowWidth, letterRowHeight);

      [letterCollection updateFrame:letterCollectionFrame];
      currentYPosition += letterRowHeight;
   }
}

#pragma mark - Property Overrides
- (NSArray*)containerViews
{
   return @[self.topLettersContainer, self.middleLettersContainer, self.bottomLettersContainer];
}

@end
