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
#import "KeyViewCollection.h"

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

CGPathRef _centerAlternateKeysBackgroundPath(CGRect bottomFrame, CGRect alternateKeysFrame)
{
   CGFloat minX = CGRectGetMinX(bottomFrame);
   CGFloat minY = CGRectGetMinY(bottomFrame);
   CGFloat maxX = CGRectGetMaxX(bottomFrame);
   CGFloat maxY = CGRectGetMaxY(bottomFrame);
   
   CGMutablePathRef keyPath = CGPathCreateMutable();
   
   CGPathMoveToPoint(keyPath, nil, minX, minY);
   CGPathAddLineToPoint(keyPath, nil, minX - 8, minY - 8);
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMinX(alternateKeysFrame), minY - 8);
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMinX(alternateKeysFrame), CGRectGetMinY(alternateKeysFrame));
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMaxX(alternateKeysFrame), CGRectGetMinY(alternateKeysFrame));
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMaxX(alternateKeysFrame), minY - 8);
   
   CGPathAddLineToPoint(keyPath, nil, maxX + 8, minY - 8);
   CGPathAddLineToPoint(keyPath, nil, maxX, minY);
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
@property (nonatomic) CAShapeLayer* alternateKeysViewBackgroundLayer;
@property (nonatomic) CALayer* shadowContainerLayer;

@property (nonatomic) CALayer* alternateCharactersLayer;
@property (nonatomic) NSArray* characterArray;
@property (nonatomic) KeyViewCollection* alternateKeysCollection;
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
      [self.shadowContainerLayer addSublayer:self.alternateKeysViewBackgroundLayer];
      
      // FOR DEBUGGING:
      self.characterArray = @[@"1", @"2", @"3", @"4", @"5"];
      self.alternateKeysCollection = [KeyViewCollection collectionWithCharacterArray:self.characterArray];
      [self addSubview:self.alternateKeysCollection];
      
      self.alternateCharactersLayer = [CALayer layer];
      self.alternateCharactersLayer.backgroundColor = [UIColor redColor].CGColor;
      [self.alternateKeysViewBackgroundLayer addSublayer:self.alternateCharactersLayer];
      
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
   self.alternateKeysViewBackgroundLayer = [CAShapeLayer layer];
   
   self.alternateKeysViewBackgroundLayer.lineWidth = 2.f;
   self.alternateKeysViewBackgroundLayer.strokeColor =  [UIColor colorWithWhite:.2 alpha:1].CGColor;
   self.alternateKeysViewBackgroundLayer.fillColor = [UIColor colorWithWhite:1 alpha:.9].CGColor;
   
   self.alternateKeysViewBackgroundLayer.shadowOpacity = .1f;
   self.alternateKeysViewBackgroundLayer.shadowRadius = 1.5f;
   self.alternateKeysViewBackgroundLayer.shadowOffset = CGSizeMake(0, .5f);
   
   [self.alternateKeysViewBackgroundLayer disableAnimations];
   self.alternateKeysViewBackgroundLayer.backgroundColor = [UIColor redColor].CGColor;
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
   
   CGFloat width = CGRectGetWidth(frame) * self.characterArray.count;
   CGFloat height = CGRectGetHeight(frame);
   CGFloat x = width * -.5 + CGRectGetWidth(frame)*.5;
   
   CGRect keyViewFrame = CGRectInset(self.bounds, 4, 8);
   CGRect alternateKeysBackgroundFrame = CGRectMake(x, -54, width, height);
   
   [self.alternateKeysCollection updateFrame:alternateKeysBackgroundFrame];
   self.alternateKeysViewBackgroundLayer.path = _centerAlternateKeysBackgroundPath(keyViewFrame, alternateKeysBackgroundFrame);
}

@end
