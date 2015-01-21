//
//  KeyboardViewController.m
//  CustomKeyboard
//
//  Created by Gregory Klein on 1/17/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardViewController.h"
#import "LetterView.h"

@interface LetterRect : NSObject
+ (instancetype)letterRectWithLetter:(NSString*)letter rect:(CGRect)rect;
@property (nonatomic, copy) NSString* letter;
@property (nonatomic) CGRect rect;
@end

@implementation LetterRect
+ (instancetype)letterRectWithLetter:(NSString *)letter rect:(CGRect)rect
{
   LetterRect* letterRect = [LetterRect new];
   letterRect.letter = letter;
   letterRect.rect = rect;
   return letterRect;
}
@end

@interface KeyboardViewController ()

@property (nonatomic) UIButton* nextKeyboardButton;

@property (nonatomic) UIView* topRowLettersContainerView;
@property (nonatomic) UIView* middleRowLettersContainerView;
@property (nonatomic) UIView* bottomRowLettersContainerView;
@property (nonatomic) UIView* bottomRowKeysContainerView;

@property (nonatomic) NSMutableArray* letterRects;

@end

@implementation KeyboardViewController

- (void)updateViewConstraints
{
   [super updateViewConstraints];
   // Add custom view sizing constraints here
}

- (void)viewDidLoad
{
   [super viewDidLoad];
//   [self setupContainerViews];

   self.letterRects = [NSMutableArray array];
   [self setupTopRowKeys];
}

#pragma mark - Setup
- (void)setupContainerViews
{
   [self setupTopRowLettersContainerView];
}

- (void)setupTopRowLettersContainerView
{
   CGFloat xPadding = 2.f;
   CGFloat yPadding = 4.f;
   CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds) - xPadding*2;
   CGFloat height = 40.f;

   CGRect topRowKeysFrame = CGRectMake(xPadding, yPadding, width, height);
   self.topRowLettersContainerView = [[UIView alloc] initWithFrame:topRowKeysFrame];

   self.topRowLettersContainerView.backgroundColor = [UIColor blueColor];

   [self.view addSubview:self.topRowLettersContainerView];
}

- (void)setupTopRowKeys
{
   NSArray* topRowKeyArray = @[@"Q", @"W", @"E", @"R", @"T", @"Y", @"U", @"I", @"O", @"P"];

   CGFloat padding = 2.f;
   CGFloat buttonWidth = (CGRectGetWidth([UIScreen mainScreen].bounds) - ((topRowKeyArray.count + 1) * padding)) / topRowKeyArray.count;
   CGFloat buttonHeight = 40.f;

   CGFloat currentButtonXPosition = padding;
   CGFloat buttonYPosition = padding;
   CGRect currentLetterFrame = CGRectMake(currentButtonXPosition, buttonYPosition, buttonWidth, buttonHeight);

   for (NSString* keyLetter in topRowKeyArray)
   {
      LetterView* letterView = [LetterView viewWithLetter:keyLetter frame:currentLetterFrame];
      LetterRect* letterRect = [LetterRect letterRectWithLetter:keyLetter rect:currentLetterFrame];
      [self.letterRects addObject:letterRect];

      [self.view addSubview:letterView];
      
      currentLetterFrame.origin.x += buttonWidth + padding;
   }
}

- (void)setupNextKeyboardButton
{
   // Perform custom UI setup here
   self.nextKeyboardButton = [UIButton buttonWithType:UIButtonTypeSystem];

   [self.nextKeyboardButton setTitle:NSLocalizedString(@"Next Keyboard", @"Title for 'Next Keyboard' button") forState:UIControlStateNormal];
   [self.nextKeyboardButton sizeToFit];
   self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = NO;

   [self.nextKeyboardButton addTarget:self action:@selector(advanceToNextInputMode) forControlEvents:UIControlEventTouchUpInside];

   [self.view addSubview:self.nextKeyboardButton];

   NSLayoutConstraint* nextKeyboardButtonLeftSideConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0];
   NSLayoutConstraint* nextKeyboardButtonBottomConstraint = [NSLayoutConstraint constraintWithItem:self.nextKeyboardButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
   [self.view addConstraints:@[nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   CGPoint touchLoction = [touches.anyObject locationInView:self.view];

   for (LetterRect* letterRect in self.letterRects)
   {
      if (CGRectContainsPoint(letterRect.rect, touchLoction))
      {
         NSLog(@"letter touched: %@", letterRect.letter);
         [self.textDocumentProxy insertText:letterRect.letter];
         break;
      }
   }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)textWillChange:(id<UITextInput>)textInput
{
   // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput
{
   UIColor* textColor = self.textDocumentProxy.keyboardAppearance == UIKeyboardAppearanceDark ? [UIColor whiteColor] : [UIColor blackColor];
   [self.nextKeyboardButton setTitleColor:textColor forState:UIControlStateNormal];
}

@end
