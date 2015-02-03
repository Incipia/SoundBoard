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
#import "KeyboardKeyLayer.h"

@interface DeleteKeyController ()
@property (nonatomic) KeyView* deleteView;
@property (nonatomic) CAShapeLayer* deleteSymbolLayer;
@end

@implementation DeleteKeyController

#pragma mark - Setup
- (void)setupKeyViews
{
   [self setupDeleteKeyView];


   self.deleteSymbolLayer = [CAShapeLayer layer];
   self.deleteSymbolLayer.lineWidth = 1.5f;
   self.deleteSymbolLayer.strokeColor = [UIColor colorWithRed:1 green:119/255.f blue:146/255.f alpha:1].CGColor;
   self.deleteSymbolLayer.fillColor = [UIColor clearColor].CGColor;
   self.deleteSymbolLayer.lineCap = kCALineCapRound;
   [self.deleteView.layer addSublayer:self.deleteSymbolLayer];

   self.keyViewArray = @[self.deleteView];
   
   [self.view addSubview:self.deleteView];
}

- (void)setupDeleteKeyView
{
   self.deleteView = [KeyView viewWithText:@"" fontSize:14.f frame:self.view.bounds];
   self.deleteView.shouldTriggerActionOnTouchDown = YES;
   self.deleteView.backgroundLayer.backgroundColor = [UIColor clearColor].CGColor;

   [self.deleteView setActionBlock:^
   {
      [TextDocumentProxyManager deleteBackward];
   }];
}


- (void)updateShiftIconLayerWithFrame:(CGRect)frame
{
   CGPoint min = CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame));
   CGPoint max = CGPointMake(CGRectGetMaxX(frame), CGRectGetMaxY(frame));

   CGFloat width = CGRectGetWidth(frame);
   CGFloat height = CGRectGetHeight(frame);

   CGPoint p1 = CGPointMake(min.x + width*.35f, max.y);
   CGPoint p2 = CGPointMake(max.x, max.y);
   CGPoint p3 = CGPointMake(max.x, min.y);
   CGPoint p4 = CGPointMake(p1.x, min.y);
   CGPoint p5 = CGPointMake(min.x, min.y + height*.5f);

   UIBezierPath* path = [UIBezierPath bezierPath];
   [path moveToPoint:p1];
   CGPoint points[] = {p2, p3, p4, p5};
   for (int i = 0; i < sizeof(points) / sizeof(CGPoint); ++i)
   {
      [path addLineToPoint:points[i]];
   }
   [path closePath];

   CGFloat padding = 4;
   CGPoint topLeftX = CGPointMake(p4.x + padding, p4.y + padding);
   CGPoint bottomRightX = CGPointMake(p2.x - padding, p2.y - padding);

   CGPoint topRightX = CGPointMake(p3.x - padding, p3.y + padding);
   CGPoint bottomLeftX = CGPointMake(p1.x + padding, p1.y - padding);

   [path moveToPoint:topLeftX];
   [path addLineToPoint:bottomRightX];
   [path moveToPoint:topRightX];
   [path addLineToPoint:bottomLeftX];

   self.deleteSymbolLayer.path = path.CGPath;
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   [super updateFrame:frame];

   CGRect shiftPathFrame = CGRectInset(self.deleteView.bounds, 18, 20);
   [self updateShiftIconLayerWithFrame:shiftPathFrame];
}

- (KeyView*)keyViewForMode:(KeyboardMode)mode
{
   return self.deleteView;
}

@end
