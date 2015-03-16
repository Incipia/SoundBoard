//
//  TextDocumentProxyManager.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/29/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "TextDocumentProxyManager.h"
#import "AutocorrectKeyManager.h"
#import "KeyboardModeManager.h"

@interface TextDocumentProxyManager ()
@property (weak, nonatomic) id<UITextDocumentProxy> proxy;
@property (nonatomic, readonly) NSString* lastWord;
@end

@implementation TextDocumentProxyManager

#pragma mark - Helper
+ (TextDocumentProxyManager*)sharedManager
{
   static TextDocumentProxyManager* manager = nil;
   static dispatch_once_t onceToken;
   dispatch_once(&onceToken, ^{
      manager = [TextDocumentProxyManager new];
   });
   return manager;
}

#pragma mark - Class Init
+ (void)setTextDocumentProxy:(id<UITextDocumentProxy>)proxy
{
   [[self class] sharedManager].proxy = proxy;
}

#pragma mark - Class Methods
+ (void)insertText:(NSString*)text;
{
   [[[self class] sharedManager].proxy insertText:text];
   if ([KeyboardModeManager currentShiftMode] == ShiftModeApplied)
      if (![text isEqualToString:@" "])
         [KeyboardModeManager updateKeyboardShiftMode:ShiftModeNotApplied];

   NSString* lastWord = [self sharedManager].lastWord;
   [[AutocorrectKeyManager sharedManager] updateControllersWithTextInput:lastWord];
}

+ (void)replaceCurrentWordWithText:(NSString*)text
{
   NSUInteger lastWordCount = [self sharedManager].lastWord.length;
   for (int i = 0; i < lastWordCount; ++i)
   {
      [[self sharedManager].proxy deleteBackward];

   }
   [self insertText:text];
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
            [[[self class] sharedManager].proxy insertText:@". "];
            
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
      deletedUppercase = YES;
   }
   
//   NSLog(@"repeatCount = %ld", (long)repeatCount);
//   NSLog(@"charactersToDelete = %ld", (long)charactersToDelete);
   
   while(--charactersToDelete >= 0)
   {
      [[[self class] sharedManager].proxy deleteBackward];
   }

   [[AutocorrectKeyManager sharedManager] updateControllersWithTextInput:[self sharedManager].lastWord];
   return deletedUppercase;
}

+ (void)adjustTextPositionByCharacterOffset:(NSInteger)offset
{
   [[[self class] sharedManager].proxy adjustTextPositionByCharacterOffset:offset];
}

#pragma mark - Property Overrides
- (NSString*)lastWord
{
   __block NSString *lastWord = nil;

   NSString* textBeforeInput = self.proxy.documentContextBeforeInput;
   if (textBeforeInput.length)
   {
      unichar character = [textBeforeInput characterAtIndex:textBeforeInput.length - 1];
      if (![TextDocumentProxyManager isWhitespace:character])
      {
         [textBeforeInput enumerateSubstringsInRange:NSMakeRange(0, textBeforeInput.length)
                                             options:NSStringEnumerationByWords | NSStringEnumerationReverse
                                          usingBlock:^(NSString *substring, NSRange subrange, NSRange enclosingRange, BOOL *stop) {
                                             lastWord = substring;
                                             *stop = YES;
                                          }];
      };
   }

   return lastWord;
}

#pragma mark - Property Overrides
+ (NSString*)documentContextBeforeInput
{
   return [[self class] sharedManager].proxy.documentContextBeforeInput;
}

+ (NSString*)documentContextAfterInput
{
   return [[self class] sharedManager].proxy.documentContextAfterInput;
}

@end
