//
//  ShiftSymbolsKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "ShiftSymbolsKeyController.h"
#import "LetterView.h"

@interface ShiftSymbolsKeyController ()
@property (nonatomic) LetterView* shiftLetterView;
@property (nonatomic) LetterView* symbolsLetterView;
@property (nonatomic) LetterView* numbersLetterView;

@property (nonatomic, readonly) NSArray* letterViewArray;
@end

@implementation ShiftSymbolsKeyController

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      [self setupLetterViews];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controller
{
   return [[ShiftSymbolsKeyController alloc] init];
}

#pragma mark - Setup
- (void)setupLetterViews
{
   self.shiftLetterView = [LetterView viewWithLetter:@"shift" fontSize:14.f frame:CGRectZero];
   self.symbolsLetterView = [LetterView viewWithLetter:@"#+=" fontSize:14.f frame:CGRectZero];
   self.numbersLetterView = [LetterView viewWithLetter:@"123" fontSize:14.f frame:CGRectZero];
   
   for (LetterView* letterView in self.letterViewArray)
   {
      letterView.hidden = YES;
      [self.view addSubview:letterView];
   }
   
   self.shiftLetterView.hidden = NO;
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   self.view.frame = frame;
   CGRect letterViewFrame = CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame));
   for (LetterView* letterView in self.letterViewArray)
   {
      [letterView updateFrame:letterViewFrame];
   }
}

- (void)updateWithMode:(KeyboardMode)mode
{
   switch (mode)
   {
      case KeyboardModeLetters:
         break;
         
      case KeyboardModeSymbols:
         break;
         
      case KeyboardModeNumbers:
         break;
         
      default:
         break;
   }
}

#pragma mark - Property Overrides
- (NSArray*)letterViewArray
{
   return @[self.shiftLetterView, self.symbolsLetterView, self.numbersLetterView];
}

@end
