
//
//  KeyboardLayoutDimensonsProvider.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/25/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardLayoutDimensonsProvider.h"

#define NUM_ROWS 4
#define NUM_LETTERS_IN_TOP_ROW 10
#define NUM_LETTERS_IN_MIDDLE_ROW 9
#define NUM_LETTERS_IN_BOTTOM_ROW 7

static CGRect _lettersFrame(KeyboardRow row, CGFloat letterKeyWidth, CGFloat keyHeight)
{
   CGFloat xPosition = 0;
   CGFloat yPosition = 0;
   CGFloat width = 0;
   switch (row)
   {
      case KeyboardRowTop:
         width = letterKeyWidth*NUM_LETTERS_IN_TOP_ROW;
         break;
         
      case KeyboardRowMiddle:
         width = letterKeyWidth*NUM_LETTERS_IN_MIDDLE_ROW;
         xPosition = letterKeyWidth*.5f;
         yPosition = keyHeight;
         break;
      
      case KeyboardRowBottom:
         width = letterKeyWidth*NUM_LETTERS_IN_BOTTOM_ROW;
         xPosition = letterKeyWidth*1.5f;
         yPosition = keyHeight*2;
         break;
         
      default:
         break;
   }
   return CGRectMake(xPosition, yPosition, width, keyHeight);
}

static CGRect _numbersFrame(KeyboardRow row, CGFloat letterKeyWidth, CGFloat keyHeight)
{
   return CGRectZero;
}

static CGRect _symbolsFrame(KeyboardRow row, CGFloat letterKeyWidth, CGFloat keyHeight)
{
   return CGRectZero;
}

@interface KeyboardLayoutDimensonsProvider ()
@property (nonatomic) CGRect inputViewFrame;
@property (nonatomic, readonly) CGFloat letterKeyWidth;
@property (nonatomic, readonly) CGFloat keyHeight;
@end

@implementation KeyboardLayoutDimensonsProvider

#pragma mark - Class Init
+ (instancetype)dimensionsProviderWithInputViewFrame:(CGRect)frame
{
   KeyboardLayoutDimensonsProvider* provider = [KeyboardLayoutDimensonsProvider new];
   provider.inputViewFrame = frame;
   
   return provider;
}

#pragma mark - Public
- (void)updateInputViewFrame:(CGRect)frame
{
   self.inputViewFrame = frame;
}

- (CGRect)frameForKeyboardMode:(KeyboardMode)mode row:(KeyboardRow)row
{
   CGRect frame = CGRectZero;
   switch (mode)
   {
      case KeyboardModeLetters:
         frame = _lettersFrame(row, self.letterKeyWidth, self.keyHeight);
         break;
         
      case KeyboardModeNumbers:
         break;
         
      case KeyboardModeSymbols:
         break;
   }
   return frame;
}

#pragma mark - Property Overrides
- (CGFloat)letterKeyWidth
{
   return CGRectGetWidth(self.inputViewFrame) / NUM_LETTERS_IN_TOP_ROW;
}

- (CGFloat)keyHeight
{
   return CGRectGetHeight(self.inputViewFrame) / NUM_ROWS;
}

@end
