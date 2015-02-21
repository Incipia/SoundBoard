//
//  AlternateKeysView.m
//  SoundBoard
//
//  Created by Klein, Greg on 2/21/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "AlternateKeysView.h"
#import "KeyboardKeyLayer.h"
#import "CALayer+DisableAnimations.h"
#import "KeyboardKeyLayer.h"
#import "KeyView.h"

CGPathRef _defaultEnlargedKeyPath(CGRect frame)
{
   CGFloat minX = CGRectGetMinX(frame);
   CGFloat minY = CGRectGetMinY(frame);
   CGFloat maxX = CGRectGetMaxX(frame);
   CGFloat maxY = CGRectGetMaxY(frame);
   
   CGMutablePathRef keyPath = CGPathCreateMutable();
   
   CGPathMoveToPoint(keyPath, nil, minX, minY - 4);
   CGPathAddLineToPoint(keyPath, nil, minX - 12, minY - 14);
   CGPathAddLineToPoint(keyPath, nil, minX - 12, minY - 52);
   CGPathAddLineToPoint(keyPath, nil, maxX + 12, minY - 52);
   CGPathAddLineToPoint(keyPath, nil, maxX + 12, minY - 14);
   CGPathAddLineToPoint(keyPath, nil, maxX, minY - 4);
   CGPathAddLineToPoint(keyPath, nil, maxX, maxY);
   CGPathAddLineToPoint(keyPath, nil, minX, maxY);
   CGPathCloseSubpath(keyPath);
   
   return keyPath;
}

CGPathRef _leftEnlargedKeyPathWithFrame(CGRect frame)
{
   CGFloat minX = CGRectGetMinX(frame);
   CGFloat minY = CGRectGetMinY(frame);
   CGFloat maxX = CGRectGetMaxX(frame);
   CGFloat maxY = CGRectGetMaxY(frame);
   
   CGMutablePathRef keyPath = CGPathCreateMutable();
   CGPathMoveToPoint(keyPath, nil, minX, minY - 52);
   CGPathAddLineToPoint(keyPath, nil, maxX + 12, minY - 52);
   CGPathAddLineToPoint(keyPath, nil, maxX + 12, minY - 14);
   CGPathAddLineToPoint(keyPath, nil, maxX, minY - 4);
   CGPathAddLineToPoint(keyPath, nil, maxX, maxY);
   CGPathAddLineToPoint(keyPath, nil, minX, maxY);
   CGPathCloseSubpath(keyPath);
   
   return keyPath;
}

CGPathRef _rightEnlargedKeyPathWithFrame(CGRect frame)
{
   CGFloat minX = CGRectGetMinX(frame);
   CGFloat minY = CGRectGetMinY(frame);
   CGFloat maxX = CGRectGetMaxX(frame);
   CGFloat maxY = CGRectGetMaxY(frame);
   
   CGMutablePathRef keyPath = CGPathCreateMutable();
   
   CGPathMoveToPoint(keyPath, nil, minX, minY - 4);
   CGPathAddLineToPoint(keyPath, nil, minX - 12, minY - 14);
   CGPathAddLineToPoint(keyPath, nil, minX - 12, minY - 52);
   CGPathAddLineToPoint(keyPath, nil, maxX, minY - 52);
   CGPathAddLineToPoint(keyPath, nil, maxX, maxY);
   CGPathAddLineToPoint(keyPath, nil, minX, maxY);
   CGPathCloseSubpath(keyPath);
   
   return keyPath;
}

@interface AlternateKeysView ()
// FOR DEBUGGING:
@property (nonatomic) CAShapeLayer* enlargedKeyViewLayer;
@property (nonatomic) CALayer* shadowContainerLayer;

@property (nonatomic) NSArray* characterArray;
@end

@implementation AlternateKeysView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame])
   {
      [self setupEnlargedKeyViewLayer];
      [self setupShadowLayer];
      
      [self.layer addSublayer:self.shadowContainerLayer];
      [self.shadowContainerLayer addSublayer:self.enlargedKeyViewLayer];
      
      // FOR DEBUGGING:
      self.characterArray = @[@"1", @"2", @"3", @"4", @"5"];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)viewWithKeyView:(KeyView*)keyView direction:(AltKeysViewDirection)direction
{
   return [[self alloc] initWithFrame:keyView.bounds];
}

#pragma mark - Setup
- (void)setupEnlargedKeyViewLayer
{
   self.enlargedKeyViewLayer = [CAShapeLayer layer];
   
   self.enlargedKeyViewLayer.lineWidth = 2.f;
   self.enlargedKeyViewLayer.strokeColor = [UIColor greenColor].CGColor;
   self.enlargedKeyViewLayer.fillColor = [UIColor colorWithWhite:1 alpha:.9].CGColor;
   
   self.enlargedKeyViewLayer.shadowOpacity = .1f;
   self.enlargedKeyViewLayer.shadowRadius = 1.5f;
   self.enlargedKeyViewLayer.shadowOffset = CGSizeMake(0, .5f);
   
   [self.enlargedKeyViewLayer disableAnimations];
}

- (void)setupShadowLayer
{
   self.shadowContainerLayer = [CALayer layer];
   self.shadowContainerLayer.shadowOpacity = .25f;
   self.shadowContainerLayer.shadowRadius = 1.5f;
   self.shadowContainerLayer.shadowOffset = CGSizeMake(0, .5f);
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   self.frame = frame;
   self.enlargedKeyViewLayer.path = _defaultEnlargedKeyPath(CGRectInset(self.bounds, 4, 8));
}

@end
