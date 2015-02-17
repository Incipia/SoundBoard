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
#import "KeyboardModeManager.h"
#import "EnlargedKeyView.h"
#import "KeyboardTimer.h"

static NSString* const s_leftEdgeLetterKeys = @"Q1-[_";
static NSString* const s_rightEdgeLetterKeys = @"P0\"=•";

@interface LetterSymbolKeyView ()
@property (nonatomic) EnlargedKeyView* enlargedKeyView;
@property (nonatomic) BOOL hasFocus;
@property (nonatomic) KeyboardTimer* alternateKeysTimer;
@property (nonatomic) BOOL isShowingAlternateKeys;
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

- (void)dealloc
{
   [self.alternateKeysTimer stopTimer];
}

#pragma mark - Class Init
+ (instancetype)viewWithText:(NSString *)text fontSize:(CGFloat)fontSize frame:(CGRect)frame
{
   LetterSymbolKeyView* letterSymbolView = [super viewWithText:text fontSize:fontSize frame:frame];

   [letterSymbolView setupEnlargedKeyView];
   
   __weak LetterSymbolKeyView* weakLetterView = letterSymbolView;
   [letterSymbolView setActionBlock:^(NSInteger repeatCount)
    {
       NSString* text = [weakLetterView stringForShiftMode:[KeyboardModeManager currentShiftMode]];
       [TextDocumentProxyManager insertText:text];
       [KeyboardModeTransitioner giveTextInput:text];
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

- (void)fireAlterKeyTimerIfNeeded
{
   self.alternateKeysTimer = [KeyboardTimer startOneShotTimerWithBlock:^{
      dispatch_async(dispatch_get_main_queue(), ^{
         NSLog(@"switch to alternate key mode!");
         self.isShowingAlternateKeys = YES;
      });
   } andDelay:.9f];
}

- (void)killAlternateKeyTimer
{
   if (self.alternateKeysTimer)
   {
      self.isShowingAlternateKeys = NO;
      [self.alternateKeysTimer stopTimer];
      self.alternateKeysTimer = nil;

      NSLog(@"killed alternate key timer");
   }
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   [super updateFrame:frame];
   [self.enlargedKeyView updateFrame:self.bounds];
}

- (void)giveFocus
{
   if (!self.hasFocus)
   {
      self.hasFocus = YES;
      self.enlargedKeyView.hidden = NO;

      [self fireAlterKeyTimerIfNeeded];
   }
}

- (void)removeFocus
{
   if (self.hasFocus)
   {
      self.hasFocus = NO;
      self.enlargedKeyView.hidden = YES;

      [self killAlternateKeyTimer];
   }
}

- (void)updateForShiftMode:(KeyboardShiftMode)shiftMode
{
   // Disabling this for now -- removing this retrun will make the letters that display on the keyboard
   // lowercase when shift is not being applied
   return;
   
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

- (NSString*)stringForShiftMode:(KeyboardShiftMode)mode
{
   BOOL capitalized = NO;
   switch (mode)
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
   return capitalized ? self.displayText.capitalizedString : self.displayText.lowercaseString;
}

#pragma mark - Property Overrides
- (BOOL)wantsToHandleTouchEvents
{
   return self.isShowingAlternateKeys;
}

@end
