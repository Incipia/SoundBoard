//
//  LetterViewCollection.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyViewCollection.h"
#import "LetterSymbolKeyView.h"

@interface KeyViewCollection ()
@property (nonatomic) NSArray* characterArray;
@property (nonatomic) NSMutableArray* mutableLetterViewArray;
@end

@implementation KeyViewCollection

#pragma mark - Init
- (instancetype)initWithCharacterArray:(NSArray*)array
{
   if (self = [super init])
   {
      self.characterArray = array;
      self.mutableLetterViewArray = [NSMutableArray array];

      [self setupLetterViews];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)collectionWithCharacterArray:(NSArray*)array
{
   return [[KeyViewCollection alloc] initWithCharacterArray:array];
}

#pragma mark - Setup
- (void)setupLetterViews
{
   for (NSString* letter in self.characterArray)
   {
      LetterSymbolKeyView* letterView = [LetterSymbolKeyView viewWithText:letter fontSize:20.f frame:CGRectZero];

      [self.mutableLetterViewArray addObject:letterView];
      [self addSubview:letterView];
   }
}

#pragma mark - Update
- (void)updateLetterViewFrames
{
   CGFloat letterViewWidth = CGRectGetWidth(self.bounds) / self.characterArray.count;
   CGFloat letterViewHeight = CGRectGetHeight(self.bounds);
   CGRect currentLetterViewFrame = CGRectMake(0, 0, letterViewWidth, letterViewHeight);

   for (KeyView* letterView in self.mutableLetterViewArray)
   {
      [letterView updateFrame:currentLetterViewFrame];
      currentLetterViewFrame.origin.x += letterViewWidth;
   }
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   self.frame = frame;
   [self updateLetterViewFrames];
}

#pragma mark - Property Overrides
- (NSArray*)keyViews
{
   return [NSArray arrayWithArray:self.mutableLetterViewArray];
}

- (CGFloat)keyWidth
{
   CGFloat characterWidth = CGRectGetWidth(self.frame) / self.mutableLetterViewArray.count;
   return isnan(characterWidth) ? 0 : characterWidth;
}

@end