//
//  KeyboardViewController.m
//  CustomKeyboard
//
//  Created by Gregory Klein on 1/17/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardViewController.h"
#import "LetterView.h"

@interface KeyboardViewController ()
@property (nonatomic) NSMutableArray* letterViews;
@end

@implementation KeyboardViewController

#pragma mark - Lifecycle
- (void)viewDidLoad
{
   [super viewDidLoad];

   self.letterViews = [NSMutableArray array];
   
   [self setupTopRowKeys];
}

#pragma mark - Setup
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
      
      [self.letterViews addObject:letterView];
      [self.view addSubview:letterView];
      
      currentLetterFrame.origin.x += buttonWidth + padding;
   }
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   CGPoint touchLoction = [touches.anyObject locationInView:self.view];
   LetterView* targetLetterView = [self hitTestLetterViewsWithPoint:touchLoction];
   if (targetLetterView != nil)
   {
      [self.textDocumentProxy insertText:targetLetterView.letter];
   }
}

#pragma mark - Helper
- (LetterView*)hitTestLetterViewsWithPoint:(CGPoint)point
{
   LetterView* targetLetterView = nil;
   for (LetterView* letterView in self.letterViews)
   {
      if (CGRectContainsPoint(letterView.frame, point))
      {
         targetLetterView = letterView;
         break;
      }
   }
   return targetLetterView;
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
