//
//  LetterSymbolKeyView.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/31/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "LetterSymbolKeyView.h"
#import "TextDocumentProxyManager.h"

@implementation LetterSymbolKeyView

+ (instancetype)viewWithText:(NSString *)text fontSize:(CGFloat)fontSize frame:(CGRect)frame
{
   LetterSymbolKeyView* letterSymbolView = [[super class] viewWithText:text fontSize:fontSize frame:frame];
   
   [letterSymbolView setActionBlock:^
   {
      [TextDocumentProxyManager insertText:text];
   }];
   
   return letterSymbolView;
}

@end
