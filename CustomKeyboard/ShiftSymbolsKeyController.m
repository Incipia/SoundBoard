//
//  ShiftSymbolsKeyController.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "ShiftSymbolsKeyController.h"
#import "KeyboardModeManager.h"
#import "KeyView.h"

@interface ShiftSymbolsKeyController ()
@property (nonatomic) KeyView* shiftKeyView;
@property (nonatomic) KeyView* symbolsKeyView;
@property (nonatomic) KeyView* numbersKeyView;
@property (nonatomic) CAShapeLayer* shiftSymbolLayer;
@end

@implementation ShiftSymbolsKeyController

#pragma mark - Setup
- (void)setupKeyViews
{
   [self setupShiftLetterView];
   [self setupSymbolsLetterView];
   [self setupNumbersLetterView];
   
   self.keyViewArray = @[self.shiftKeyView, self.symbolsKeyView, self.numbersKeyView];
   for (KeyView* letterView in self.keyViewArray)
   {
      letterView.backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;
      [self.view addSubview:letterView];
   }

   self.shiftSymbolLayer = [CAShapeLayer layer];
   self.shiftSymbolLayer.lineWidth = 1.5f;
   self.shiftSymbolLayer.strokeColor = [UIColor colorWithRed:1 green:1 blue:162/255.f alpha:1].CGColor;
   self.shiftSymbolLayer.fillColor = [UIColor clearColor].CGColor;
   [self.shiftKeyView.layer addSublayer:self.shiftSymbolLayer];

   self.shiftKeyView.hidden = NO;
}

- (void)setupShiftLetterView
{
   self.shiftKeyView = [KeyView viewWithText:@"" fontSize:14.f frame:CGRectZero];
   self.shiftKeyView.hidden = YES;
   self.shiftKeyView.shouldTriggerActionOnTouchDown = YES;
   
   [self.shiftKeyView setActionBlock:^
   {
      NSLog(@"shift button pressed");
   }];
}

- (void)setupSymbolsLetterView
{
   self.symbolsKeyView = [KeyView viewWithText:@"#+=" fontSize:14.f frame:CGRectZero];
   self.symbolsKeyView.hidden = YES;
   self.symbolsKeyView.shouldTriggerActionOnTouchDown = YES;
   
   [self.symbolsKeyView setActionBlock:^
   {
      [KeyboardModeManager updateKeyboardMode:KeyboardModeSymbols];
   }];
}

- (void)setupNumbersLetterView
{
   self.numbersKeyView = [KeyView viewWithText:@"123" fontSize:14.f frame:CGRectZero];
   self.numbersKeyView.hidden = YES;
   self.numbersKeyView.shouldTriggerActionOnTouchDown = YES;
   
   [self.numbersKeyView setActionBlock:^
   {
      [KeyboardModeManager updateKeyboardMode:KeyboardModeNumbers];
   }];
}

#pragma mark - Update
- (void)updateShiftIconLayerWithFrame:(CGRect)frame
{
   CGPoint min = CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame));
   CGPoint max = CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame));

   CGFloat width = CGRectGetWidth(frame);
   CGFloat height = CGRectGetHeight(frame);

   CGPoint p1 = CGPointMake(min.x + width*.3f, max.y);
   CGPoint p2 = CGPointMake(p1.x + width*.4f, max.y);
   CGPoint p3 = CGPointMake(p2.x, p2.y - height*.4f);
   CGPoint p4 = CGPointMake(max.x, p3.y);
   CGPoint p5 = CGPointMake(max.x - width*.5f, min.y);
   CGPoint p6 = CGPointMake(min.x, p4.y);
   CGPoint p7 = CGPointMake(p1.x, p6.y);

   UIBezierPath* path = [UIBezierPath bezierPath];
   [path moveToPoint:p1];
   CGPoint points[] = {p2, p3, p4, p5, p6, p7};
   for (int i = 0; i < sizeof(points) / sizeof(CGPoint); ++i)
   {
      [path addLineToPoint:points[i]];
   }
   [path closePath];

   self.shiftSymbolLayer.path = path.CGPath;
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   [super updateFrame:frame];

   CGRect shiftPathFrame = CGRectInset(self.shiftKeyView.bounds, 18, 18);
   [self updateShiftIconLayerWithFrame:shiftPathFrame];
}

- (KeyView*)keyViewForMode:(KeyboardMode)mode
{
   KeyView* keyView;
   switch (mode)
   {
      case KeyboardModeLetters:
         keyView = self.shiftKeyView;
         break;
         
      case KeyboardModeNumbers:
         keyView = self.symbolsKeyView;
         break;
         
      case KeyboardModeSymbols:
         keyView = self.numbersKeyView;
         break;
         
      default:
         break;
   }
   return keyView;
}

- (void)updateMode:(KeyboardMode)mode
{
   switch (mode)
   {
      case KeyboardModeLetters:
         self.shiftKeyView.hidden = NO;
         self.numbersKeyView.hidden = YES;
         self.symbolsKeyView.hidden = YES;
         break;
         
      case KeyboardModeNumbers:
         self.shiftKeyView.hidden = YES;
         self.numbersKeyView.hidden = YES;
         self.symbolsKeyView.hidden = NO;
         break;
         
      case KeyboardModeSymbols:
         self.shiftKeyView.hidden = YES;
         self.numbersKeyView.hidden = NO;
         self.symbolsKeyView.hidden = YES;
         break;
         
      default:
         break;
   }
}

@end
