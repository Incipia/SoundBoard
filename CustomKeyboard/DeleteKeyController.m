//
//  DeleteKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "DeleteKeyController.h"
#import "TextDocumentProxyManager.h"
#import "KeyView.h"

@interface DeleteKeyController ()
@property (nonatomic) KeyView* deleteView;
@end

@implementation DeleteKeyController

#pragma mark - Setup
- (void)setupKeyViews
{
   [self setupDeleteKeyView];
   self.keyViewArray = @[self.deleteView];
   
   [self.view addSubview:self.deleteView];
}

- (void)setupDeleteKeyView
{
   self.deleteView = [KeyView viewWithText:@"del" fontSize:14.f frame:self.view.bounds];
   self.deleteView.shouldTriggerActionOnTouchDown = YES;
   [self.deleteView setActionBlock:^
   {
      [TextDocumentProxyManager deleteBackward];
   }];
}

#pragma mark - Public
- (KeyView*)keyViewForMode:(KeyboardMode)mode
{
   return self.deleteView;
}

@end
