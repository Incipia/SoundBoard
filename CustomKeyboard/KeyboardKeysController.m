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
#import "DeleteKeyController.h"

static const int s_totalKeyRows = 4;

@interface KeyboardKeysController ()

@property (nonatomic) LetterViewCollection* topLettersContainer;
@property (nonatomic) LetterViewCollection* middleLettersContainer;
@property (nonatomic) LetterViewCollection* bottomLettersContainer;
@property (nonatomic) DeleteKeyController* deleteController;

@property (nonatomic) UIView* bottomKeysContainer;
@property (nonatomic, readonly) NSArray* containerViews;
@end

@implementation KeyboardKeysController

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      [self setupLetterRowViews];
      [self setupFunctionalKeyViews];
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
   [self updateContainerViewFrames];
   [self updateFunctionalKeyFrames];
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

- (void)setupFunctionalKeyViews
{
   self.deleteController = [DeleteKeyController controller];
   [self.view addSubview:self.deleteController.view];
}

#pragma mark - Update
- (void)updateContainerViewFrames
{
   CGFloat topLetterRowWidth = CGRectGetWidth(self.view.bounds);
   int letterRowHeight = CGRectGetHeight(self.view.bounds) / s_totalKeyRows;

   CGFloat characterWidth = self.topLettersContainer.generatedCharacterWidth;
   CGFloat middleLetterRowWidth = self.middleLettersContainer.characterCount*characterWidth;
   CGFloat bottomLetterRowWidth = self.bottomLettersContainer.characterCount*characterWidth;

   CGFloat letterRowWidths[] = {topLetterRowWidth, middleLetterRowWidth, bottomLetterRowWidth};
   NSUInteger letterRowWidthIndex = 0;
   NSUInteger currentYPosition = 0;

   for (LetterViewCollection* letterCollection in self.containerViews)
   {
      CGFloat currentLetterRowWidth = letterRowWidths[letterRowWidthIndex++];
      CGFloat xPosition = CGRectGetMidX(self.view.bounds) - (currentLetterRowWidth*.5);
      CGRect letterCollectionFrame = CGRectMake(xPosition, currentYPosition, currentLetterRowWidth, letterRowHeight);

      [letterCollection updateFrame:letterCollectionFrame];
      currentYPosition += letterRowHeight;
   }
}

- (void)updateFunctionalKeyFrames
{
   CGFloat xPosition = CGRectGetMaxX(self.bottomLettersContainer.frame);
   CGFloat yPosition = CGRectGetMinY(self.bottomLettersContainer.frame);
   CGFloat width = CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(self.bottomLettersContainer.frame);
   CGFloat height = CGRectGetHeight(self.bottomLettersContainer.bounds);
   
   [self.deleteController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

#pragma mark - Property Overrides
- (NSArray*)containerViews
{
   return @[self.topLettersContainer, self.middleLettersContainer, self.bottomLettersContainer];
}

@end
