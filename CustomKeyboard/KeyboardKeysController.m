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

@property (nonatomic) KeyViewCollection* topLettersContainer;
@property (nonatomic) KeyViewCollection* middleLettersContainer;
@property (nonatomic) KeyViewCollection* bottomLettersContainer;

@property (nonatomic) DeleteKeyController* deleteController;
@property (nonatomic) ShiftSymbolsKeyController* shiftSymbolsController;
@property (nonatomic) LetterNumberKeyController* letterNumberController;
@property (nonatomic) NextKeyboardKeyController* nextKeyboardController;
@property (nonatomic) SpacebarKeyController* spacebarKeyController;
@property (nonatomic) ReturnKeyController* returnKeyController;

@property (nonatomic, readonly) NSArray* containerViews;

@end

@implementation KeyboardKeysController

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      [self setupLetterRowViews];
      [self setupFunctionalKeyControllers];
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
   self.topLettersContainer = [KeyViewCollection collectionWithCharacterArray:topLetters];

   NSArray* middleLetters = [KeyboardKeysUtility characterArrayForMode:KeyboardModeLetters row:KeyboardRowMiddle];
   self.middleLettersContainer = [KeyViewCollection collectionWithCharacterArray:middleLetters];

   NSArray* bottomLetters = [KeyboardKeysUtility characterArrayForMode:KeyboardModeLetters row:KeyboardRowBottom];
   self.bottomLettersContainer = [KeyViewCollection collectionWithCharacterArray:bottomLetters];

   for (KeyViewCollection* letterRowView in self.containerViews)
   {
      [self.view addSubview:letterRowView];
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
- (void)updateContainerViewFrames
{
   CGFloat topLetterRowWidth = CGRectGetWidth(self.view.bounds);
   int letterRowHeight = CGRectGetHeight(self.view.bounds) / s_totalKeyRows;

   CGFloat characterWidth = self.topLettersContainer.generatedKeyWidth;
   CGFloat middleLetterRowWidth = self.middleLettersContainer.characterCount*characterWidth;
   CGFloat bottomLetterRowWidth = self.bottomLettersContainer.characterCount*characterWidth;

   CGFloat letterRowWidths[] = {topLetterRowWidth, middleLetterRowWidth, bottomLetterRowWidth};
   NSUInteger letterRowWidthIndex = 0;
   NSUInteger currentYPosition = 0;

   for (KeyViewCollection* letterCollection in self.containerViews)
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
   [self updateDeleteKeyFrame];
   [self updateShiftSymbolKeyFrame];
   [self updateLetterNumberKeyFrame];
   [self updateNextKeyboardKeyFrame];
   [self updateSpacebarKeyFrame];
   [self updateReturnKeyFrame];
}

- (void)updateDeleteKeyFrame
{
   CGFloat xPosition = CGRectGetMaxX(self.bottomLettersContainer.frame);
   CGFloat yPosition = CGRectGetMinY(self.bottomLettersContainer.frame);
   CGFloat width = CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(self.bottomLettersContainer.frame);
   CGFloat height = CGRectGetHeight(self.bottomLettersContainer.bounds);
   
   [self.deleteController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateShiftSymbolKeyFrame
{
   CGFloat xPosition = 0;
   CGFloat yPosition = CGRectGetMinY(self.bottomLettersContainer.frame);
   CGFloat width = CGRectGetMinX(self.bottomLettersContainer.frame);
   CGFloat height = CGRectGetHeight(self.bottomLettersContainer.frame);
   
   [self.shiftSymbolsController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateLetterNumberKeyFrame
{
   CGFloat xPosition = 0;
   CGFloat yPosition = CGRectGetMaxY(self.bottomLettersContainer.frame);
   CGFloat width = (CGRectGetMinX(self.bottomLettersContainer.frame) + self.bottomLettersContainer.generatedKeyWidth) * .5;
   CGFloat height = CGRectGetHeight(self.view.frame) - yPosition;
   
   [self.letterNumberController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateNextKeyboardKeyFrame
{
   CGFloat xPosition = CGRectGetMaxX(self.letterNumberController.view.frame);
   CGFloat yPosition = CGRectGetMaxY(self.bottomLettersContainer.frame);
   CGFloat width = CGRectGetWidth(self.letterNumberController.view.frame);
   CGFloat height = CGRectGetHeight(self.view.frame) - yPosition;
   
   [self.nextKeyboardController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateSpacebarKeyFrame
{
   CGFloat xPosition = CGRectGetMaxX(self.nextKeyboardController.view.frame);
   CGFloat yPosition = CGRectGetMaxY(self.bottomLettersContainer.frame);
   CGFloat width = self.bottomLettersContainer.generatedKeyWidth * 5;
   CGFloat height = CGRectGetHeight(self.view.frame) - yPosition;
   
   [self.spacebarKeyController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

- (void)updateReturnKeyFrame
{
   CGFloat xPosition = CGRectGetMaxX(self.spacebarKeyController.view.frame);
   CGFloat yPosition = CGRectGetMaxY(self.bottomLettersContainer.frame);
   CGFloat width = CGRectGetWidth(self.view.frame) - CGRectGetMaxX(self.spacebarKeyController.view.frame);
   CGFloat height = CGRectGetHeight(self.view.frame) - yPosition;
   
   [self.returnKeyController updateFrame:CGRectMake(xPosition, yPosition, width, height)];
}

#pragma mark - Property Overrides
- (NSArray*)containerViews
{
   return @[self.topLettersContainer, self.middleLettersContainer, self.bottomLettersContainer];
}

@end
