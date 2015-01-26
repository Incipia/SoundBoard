//
//  DeleteKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "DeleteKeyController.h"
#import "KeyView.h"

@interface DeleteKeyController ()
@property (nonatomic) KeyView* deleteView;
@end

@implementation DeleteKeyController

#pragma mark - Setup
- (void)setupKeyViews
{
   self.deleteView = [KeyView viewWithLetter:@"del" fontSize:14.f frame:self.view.bounds];
   self.keyViewArray = @[self.deleteView];
   
   [self.view addSubview:self.deleteView];
}

@end
