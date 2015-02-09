//
//  LetterSymbolKeyView.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/31/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "LetterSymbolKeyView.h"
#import "TextDocumentProxyManager.h"
#import "KeyboardModeTransitioner.h"
#import "EnlargedKeyView.h"

static NSString* const s_leftEdgeLetterKeys = @"Q1-[_";
static NSString* const s_rightEdgeLetterKeys = @"P0\"=•";

@interface LetterSymbolKeyView ()
@property (nonatomic) EnlargedKeyView* enlargedKeyView;
@end

@implementation LetterSymbolKeyView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame])
   {
      self.shouldShowEnlargedKeyOnTouchDown = YES;
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)viewWithText:(NSString *)text fontSize:(CGFloat)fontSize frame:(CGRect)frame
{
   LetterSymbolKeyView* letterSymbolView = [super viewWithText:text fontSize:fontSize frame:frame];

   [letterSymbolView setupEnlargedKeyView];
   
   __weak LetterSymbolKeyView* weakLetterView = letterSymbolView;
   [letterSymbolView setActionBlock:^
    {
       [TextDocumentProxyManager insertText:weakLetterView.displayText];
       [KeyboardModeTransitioner giveTextInput:weakLetterView.displayText];
       [KeyboardModeTransitioner requestTransitionToModeAfterNextSpacebarInput:KeyboardModeLetters];
    }];

   return letterSymbolView;
}

#pragma mark - Setup
- (void)setupEnlargedKeyView
{
   self.enlargedKeyView = [EnlargedKeyView viewWithKeyView:self];
   self.enlargedKeyView.hidden = YES;
   self.enlargedKeyView.keyType = [self enlargedKeyTypeForString:self.displayText];

   [self addSubview:self.enlargedKeyView];
}

#pragma mark - Helper
- (EnlargedKeyType)enlargedKeyTypeForString:(NSString*)string
{
   EnlargedKeyType type = EnlargedKeyTypeDefault;
   if ([s_leftEdgeLetterKeys containsString:string])
   {
      type = EnlargedKeyTypeLeft;
   }
   else if ([s_rightEdgeLetterKeys containsString:string])
   {
      type = EnlargedKeyTypeRight;
   }
   return type;
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   [super updateFrame:frame];
   [self.enlargedKeyView updateFrame:self.bounds];
}

- (void)giveFocus
{
   self.enlargedKeyView.hidden = NO;
}

- (void)removeFocus
{
   self.enlargedKeyView.hidden = YES;
}

- (void)updateForShiftMode:(KeyboardShiftMode)shiftMode
{
   BOOL capitalized = NO;
   switch (shiftMode)
   {
      case ShiftModeNotApplied:
         break;
         
      case ShiftModeApplied:
      case ShiftModeCapsLock:
         capitalized = YES;
         break;
         
      default:
         break;
   }
   
   if (capitalized)
   {
      [self.keyLayer makeTextUppercase];
      self.displayText = self.displayText.capitalizedString;
   }
   else
   {
      [self.keyLayer makeTextLowercase];
      self.displayText = self.displayText.lowercaseString;
   }
}

@end
