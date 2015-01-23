//
//  LetterViewCollection.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "LetterViewCollection.h"
#import "LetterView.h"

@interface LetterViewCollection ()

@property (nonatomic) NSArray* characterArray;
@property (nonatomic) NSMutableArray* mutableLetterViewArray;

@end

@implementation LetterViewCollection

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
   return [[LetterViewCollection alloc] initWithCharacterArray:array];
}

#pragma mark - Setup
- (void)setupLetterViews
{
   for (NSString* letter in self.characterArray)
   {
      LetterView* letterView = [LetterView viewWithLetter:letter frame:CGRectZero];

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

   for (LetterView* letterView in self.mutableLetterViewArray)
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
- (NSArray*)letterViews
{
   return [NSArray arrayWithArray:self.mutableLetterViewArray];
}

- (CGFloat)generatedCharacterWidth
{
   CGFloat characterWidth = CGRectGetWidth(self.frame) / self.mutableLetterViewArray.count;
   return isnan(characterWidth) ? 0 : characterWidth;
}

- (NSUInteger)characterCount
{
   NSUInteger count = self.mutableLetterViewArray.count;
   return isnan(count) ? 0 : count;
}

@end