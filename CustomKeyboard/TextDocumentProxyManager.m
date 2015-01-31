//
//  TextDocumentProxyManager.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/29/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "TextDocumentProxyManager.h"

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
}

+ (void)deleteBackward
{
   [[[self class] lazyLoadedManager].proxy deleteBackward];
}

+ (void)adjustTextPositionByCharacterOffset:(NSInteger)offset
{
   [[[self class] lazyLoadedManager].proxy adjustTextPositionByCharacterOffset:offset];
}

@end
