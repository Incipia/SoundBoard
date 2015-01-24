//
//  DeleteKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "DeleteKeyController.h"
#import "LetterView.h"

@interface DeleteKeyController ()
@property (nonatomic) LetterView* deleteView;
@end

@implementation DeleteKeyController

#pragma mark - Setup
- (void)setupLetterViews
{
   self.deleteView = [LetterView viewWithLetter:@"del" fontSize:14.f frame:self.view.bounds];
   self.letterViewArray = @[self.deleteView];
   
   [self.view addSubview:self.deleteView];
}

@end
