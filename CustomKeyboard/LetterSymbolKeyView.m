//
//  LetterSymbolKeyView.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/31/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "LetterSymbolKeyView.h"
#import "TextDocumentProxyManager.h"
#import "EnlargedKeyView.h"

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
   [letterSymbolView setActionBlock:^
    {
       [TextDocumentProxyManager insertText:text];
    }];

   return letterSymbolView;
}

#pragma mark - Setup
- (void)setupEnlargedKeyView
{
   self.enlargedKeyView = [EnlargedKeyView viewWithKeyView:self];
   self.enlargedKeyView.hidden = YES;

   [self addSubview:self.enlargedKeyView];
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

@end
