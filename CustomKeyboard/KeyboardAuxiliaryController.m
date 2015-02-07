//
//  KeyboardAuxilaryController.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardAuxiliaryController.h"
#import "KeyboardKeysController.h"

@interface KeyboardAuxiliaryController ()
@property (nonatomic) UILabel* temporaryLabel;
@end

@implementation KeyboardAuxiliaryController

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      [self setupTemporaryLabel];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)controller
{
   return [[KeyboardAuxiliaryController alloc] init];
}

#pragma mark - Setup
- (void)setupTemporaryLabel
{
   self.temporaryLabel = [[UILabel alloc] init];
   
   NSDictionary* labelAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                     NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:14.f]};
   
   NSAttributedString* attributedLetter = [[NSAttributedString alloc] initWithString:@"[Auxiliary View]" attributes:labelAttributes];
   self.temporaryLabel.attributedText = attributedLetter;
   self.temporaryLabel.textAlignment = NSTextAlignmentCenter;
   self.temporaryLabel.backgroundColor = [UIColor colorWithRed:43/255.f green:44/255.f blue:48/255.f alpha:1];
   
   [self.view addSubview:self.temporaryLabel];
}

#pragma mark - Lifecycle
- (void)viewDidLayoutSubviews
{
   self.temporaryLabel.frame = self.view.bounds;
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
