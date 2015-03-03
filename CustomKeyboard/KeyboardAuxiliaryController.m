//
//  KeyboardAuxilaryController.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardAuxiliaryController.h"
#import "KeyboardKeysController.h"
#import "KeyView.h"

@interface KeyboardAuxiliaryController ()
@property (nonatomic) UILabel* temporaryLabel;
@property (nonatomic) KeyView* leftLabelView;
@property (nonatomic) KeyView* centerLabelView;
@property (nonatomic) KeyView* rightLabelView;
@end

@implementation KeyboardAuxiliaryController

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      [self setupLabelViews];
      self.view.backgroundColor = [UIColor colorWithRed:43/255.f green:44/255.f blue:48/255.f alpha:1];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controller
{
   return [[KeyboardAuxiliaryController alloc] init];
}

#pragma mark - Setup
- (void)setupLabelViews
{
   self.leftLabelView = [KeyView viewWithText:@"first" keyType:KeyTypeFunctional];
   [self.view addSubview:self.leftLabelView];
   
   self.centerLabelView = [KeyView viewWithText:@"\"second\"" keyType:KeyTypeFunctional];
   [self.view addSubview:self.centerLabelView];
   
   self.rightLabelView = [KeyView viewWithText:@"third" keyType:KeyTypeFunctional];
   [self.view addSubview:self.rightLabelView];
}

- (void)setupTemporaryLabel
{
   self.temporaryLabel = [[UILabel alloc] init];
   
   NSDictionary* labelAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:14.f]};
   
   NSAttributedString* attributedLetter = [[NSAttributedString alloc] initWithString:@"[Auxiliary View]" attributes:labelAttributes];
   self.temporaryLabel.attributedText = attributedLetter;
   self.temporaryLabel.textAlignment = NSTextAlignmentCenter;
   self.temporaryLabel.backgroundColor = [UIColor colorWithRed:43/255.f green:44/255.f blue:48/255.f alpha:1];
}

#pragma mark - Lifecycle
- (void)viewDidLayoutSubviews
{
   CGRect centerLabelViewFrame = CGRectMake(CGRectGetWidth(self.view.bounds)*.3333f - 4,
                                            0,
                                            CGRectGetWidth(self.view.bounds)*.3333f + 8,
                                            CGRectGetHeight(self.view.bounds));
   
   CGRect leftLabelViewFrame = CGRectMake(0, 0, CGRectGetMinX(centerLabelViewFrame), CGRectGetHeight(self.view.bounds));
   
   CGRect rightLabelViewFrame = CGRectMake(CGRectGetMaxX(centerLabelViewFrame),
                                           0,
                                           CGRectGetWidth(self.view.bounds) - CGRectGetMaxX(centerLabelViewFrame),
                                           CGRectGetHeight(self.view.bounds));
   
   [self.leftLabelView updateFrame:leftLabelViewFrame];
   [self.centerLabelView updateFrame:centerLabelViewFrame];
   [self.rightLabelView updateFrame:rightLabelViewFrame];
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   [self.leftLabelView updateDisplayText:@"updated"];
}

@end
