//
//  SpacebarKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "SpacebarKeyController.h"
#import "TextDocumentProxyManager.h"
#import "KeyView.h"

@interface SpacebarKeyController ()
@property (nonatomic) KeyView* spacebarKeyView;
@end

@implementation SpacebarKeyController

#pragma mark - Setup
- (void)setupKeyViews
{
   self.spacebarKeyView = [KeyView viewWithText:@"space" fontSize:14.f frame:CGRectZero];
   [self.spacebarKeyView setActionBlock:
    ^{
       [TextDocumentProxyManager insertText:@" "];
    }];
   
   self.keyViewArray = @[self.spacebarKeyView];
   [self.view addSubview:self.spacebarKeyView];
}

#pragma mark - Public
- (KeyView*)keyViewForMode:(KeyboardMode)mode
{
   return self.spacebarKeyView;
}

@end
