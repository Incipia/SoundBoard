//
//  TextDocumentProxyManager.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/29/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "TextDocumentProxyManager.h"
#import "KeyboardModeManager.h"

static TextDocumentProxyManager* s_textDocumentProxyManager = nil;

@interface TextDocumentProxyManager ()
@property (weak, nonatomic) id<UITextDocumentProxy> proxy;
@end

@implementation TextDocumentProxyManager

#pragma mark - Helper
+ (TextDocumentProxyManager*)lazyLoadedManager
{
   if (s_textDocumentProxyManager == nil)
   {
      s_textDocumentProxyManager = [TextDocumentProxyManager new];
   }
   return s_textDocumentProxyManager;
}

#pragma mark - Class Init
+ (void)setTextDocumentProxy:(id<UITextDocumentProxy>)proxy
{
   [[self class] lazyLoadedManager].proxy = proxy;
}

#pragma mark - Class Methods
+ (void)insertText:(NSString*)text;
{
   [[[self class] lazyLoadedManager].proxy insertText:text];
   if ([KeyboardModeManager currentShiftMode] == ShiftModeApplied)
      [KeyboardModeManager updateKeyboardShiftMode:ShiftModeNotApplied];
}

+ (BOOL)isWhitespace:(unichar)character
{
   return [[NSCharacterSet whitespaceCharacterSet] characterIsMember:character];
}

+ (BOOL)insertPeriodPriorToWhitespace
{
   NSString * text = [self documentContextBeforeInput];
   if (text && text.length > 1)
   {
      unichar character = [text characterAtIndex:text.length - 1];
      if ([TextDocumentProxyManager isWhitespace:character])
      {
         character = [text characterAtIndex:text.length - 2];
         if (![TextDocumentProxyManager isWhitespace:character])
         {
            [TextDocumentProxyManager deleteBackward:1];
            [[[self class] lazyLoadedManager].proxy insertText:@". "];
            
            if ([KeyboardModeManager currentShiftMode] == ShiftModeNotApplied)
               [KeyboardModeManager updateKeyboardShiftMode:ShiftModeApplied];
            
            return YES;
         }
      }
   }
   
   return NO;
}

+ (void)insertSpace
{
   [TextDocumentProxyManager insertText:@" "];
   
   NSString * text = [self documentContextBeforeInput];
   if (text && text.length > 1)
   {
      unichar character = [text characterAtIndex:text.length - 2];
      if (character == '.' || character == '?' || character == '!')
         if ([KeyboardModeManager currentShiftMode] == ShiftModeNotApplied)
            [KeyboardModeManager updateKeyboardShiftMode:ShiftModeApplied];
   }
}

+ (BOOL)deleteBackward:(NSInteger)repeatCount
{
   BOOL deletedUppercase = NO;
   
   NSInteger charactersToDelete = 0;
   
   NSString * text = [self documentContextBeforeInput];
   if (text && text.length)
   {
      bool foundWordStart = false;
      bool foundWordEnd = false;
      
      unichar character = [text characterAtIndex:text.length - 1];
      charactersToDelete = 1;
      if (![TextDocumentProxyManager isWhitespace:character]) foundWordEnd = true;
      
      NSInteger wordsToDelete = 0;
      if (repeatCount >= KeyboardRepeatStartDeletingWords) wordsToDelete = 2;
      
      while (wordsToDelete)
      {
         while (!foundWordEnd && ((text.length - charactersToDelete) > 0))
         {
            unichar next = [text characterAtIndex:text.length - (charactersToDelete + 1)];
            if ([TextDocumentProxyManager isWhitespace:next])
            {
               character = next;
               ++charactersToDelete;
            }
            else
            {
               foundWordEnd = true;
            }
         }
         
         while (!foundWordStart && ((text.length - charactersToDelete) > 0))
         {
            unichar next = [text characterAtIndex:text.length - (charactersToDelete + 1)];
            if ([TextDocumentProxyManager isWhitespace:next])
            {
               foundWordStart = true;
            }
            else
            {
               character = next;
               ++charactersToDelete;
            }
         }
         foundWordEnd = false;
         foundWordStart = false;
         --wordsToDelete;
      }
      
      if (charactersToDelete)
         deletedUppercase = [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:character];
   }
   else
   {
//      NSLog(@"There is no more text to delete to the left of the cursor!");
//      NSLog(@"      is this a lie? deleting 5 characters every time now!");
      charactersToDelete = 5;
   }
   
//   NSLog(@"repeatCount = %ld", (long)repeatCount);
//   NSLog(@"charactersToDelete = %ld", (long)charactersToDelete);
   
   while(--charactersToDelete >= 0)
   {
      [[[self class] lazyLoadedManager].proxy deleteBackward];
   }
   
   return deletedUppercase;
}

+ (void)adjustTextPositionByCharacterOffset:(NSInteger)offset
{
   [[[self class] lazyLoadedManager].proxy adjustTextPositionByCharacterOffset:offset];
}

#pragma mark - Property Overrides
+ (NSString*)documentContextBeforeInput
{
   return [[self class] lazyLoadedManager].proxy.documentContextBeforeInput;
}

+ (NSString*)documentContextAfterInput
{
   return [[self class] lazyLoadedManager].proxy.documentContextAfterInput;
}

@end
