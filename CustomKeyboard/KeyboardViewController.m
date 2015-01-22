//
//  KeyboardViewController.m
//  CustomKeyboard
//
//  Created by Gregory Klein on 1/17/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardViewController.h"
#import "LetterView.h"

static const CGFloat s_topContainerWidth = 30.f;
static const CGFloat s_containerViewHeight = 40.f;
static const CGFloat s_verticalMargin = 4.f;
static const CGFloat s_horizontalMargin = 4.f;
static const CGFloat s_horizontalKeyPadding = 2.f;

static CGFloat _nextYPositionForContainer(CGFloat fromYPosition)
{
   return fromYPosition - s_containerViewHeight - s_verticalMargin;
}

@interface KeyboardViewController ()

@property (nonatomic) UIView* topContainer;
@property (nonatomic) UIView* topRowLettersContainer;
@property (nonatomic) UIView* middleRowLettersContainer;
@property (nonatomic) UIView* bottomRowLettersContainer;
@property (nonatomic) UIView* bottomRowKeysContainer;
@property (nonatomic, readonly) NSArray* containerViewArray;

@property (nonatomic) NSMutableArray* letterViews;

@end

@implementation KeyboardViewController

#pragma mark - Lifecycle
- (void)viewDidLoad
{
   [super viewDidLoad];

   [self setupLetterContainerViews];

   self.letterViews = [NSMutableArray array];
}

- (void)viewDidLayoutSubviews
{
   [self updateContainerViewFrames];
}

#pragma mark - Setup
- (void)setupLetterContainerViews
{
   self.topContainer = [UIView new];
   self.topRowLettersContainer = [UIView new];
   self.middleRowLettersContainer = [UIView new];
   self.bottomRowLettersContainer = [UIView new];
   self.bottomRowKeysContainer = [UIView new];

   for (UIView* containerView in self.containerViewArray)
   {
      containerView.backgroundColor = [UIColor colorWithRed:.4 green:.4 blue:1 alpha:.8];
      [self.inputView addSubview:containerView];
   }
}

- (void)setupTopRowKeys
{
   NSArray* topRowKeyArray = @[@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P"];

   CGFloat buttonWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - ((topRowKeyArray.count + 1) * s_horizontalKeyPadding)) / topRowKeyArray.count;

   CGFloat currentButtonXPosition = s_horizontalKeyPadding;
   CGFloat buttonYPosition = s_horizontalKeyPadding + 40.f;
   CGRect currentLetterFrame = CGRectMake(currentButtonXPosition, buttonYPosition, buttonWidth, 40.f);

   for (NSString* keyLetter in topRowKeyArray)
   {
      LetterView* letterView = [LetterView viewWithLetter:keyLetter frame:currentLetterFrame];
      
      [self.letterViews addObject:letterView];
      [self.view addSubview:letterView];
      
      currentLetterFrame.origin.x += buttonWidth + s_horizontalKeyPadding;
   }
}

- (void)updateContainerViewFrames
{
   CGRect topContainerRect = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), s_topContainerWidth);
   self.topContainer.frame = topContainerRect;
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   CGPoint touchLoction = [touches.anyObject locationInView:self.view];
   [self hitTestLetterViewsWithPoint:touchLoction block:^(LetterView *letterView)
    {
       [letterView giveFocus];
    }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   CGPoint touchLoction = [touches.anyObject locationInView:self.view];
   [self hitTestLetterViewsWithPoint:touchLoction block:^(LetterView *letterView)
   {
      [self.textDocumentProxy insertText:letterView.letter];
   }];
}

#pragma mark - Property Overrides
- (NSArray*)containerViewArray
{
   return @[self.topContainer, self.bottomRowKeysContainer, self.bottomRowLettersContainer, self.middleRowLettersContainer, self.topRowLettersContainer];
}

#pragma mark - Helper
- (void)hitTestLetterViewsWithPoint:(CGPoint)point block:(void (^)(LetterView* letterView))block
{
   for (LetterView* letterView in self.letterViews)
   {
      if (CGRectContainsPoint(letterView.frame, point) && block != nil)
      {
         block(letterView);
         return;
      }
   }
}

#pragma mark - UITextInput Delegate
- (void)textWillChange:(id<UITextInput>)textInput
{
   // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput
{
}

@end
