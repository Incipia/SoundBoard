//
//  EnlargedKeyDrawingView.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/31/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "EnlargedKeyDrawingView.h"
#import "KeyboardKeyLayer.h"
#import "CALayer+DisableAnimations.h"
#import "KeyView.h"

@interface EnlargedKeyDrawingView ()

@property (nonatomic) CAShapeLayer* enlargedKeyViewLayer;
@property (nonatomic) CALayer* shadowLayerContainer;
@property (nonatomic) KeyboardKeyLayer* letterLayer;

@property (nonatomic) KeyView* currentKeyView;
@property (nonatomic) BOOL showing;

@end

@implementation EnlargedKeyDrawingView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame])
   {
      [self setupEnlargedKeyViewLayer];
      [self setupShadowLayer];
      
      [self.layer addSublayer:self.shadowLayerContainer];
      [self.shadowLayerContainer addSublayer:self.enlargedKeyViewLayer];
      
      self.letterLayer = [KeyboardKeyLayer layerWithText:@"" fontSize:24.f];
      [self.layer addSublayer:self.letterLayer];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)drawingViewWithFrame:(CGRect)frame
{
   return [[[self class] alloc] initWithFrame:frame];
}

#pragma mark - Setup
- (void)setupEnlargedKeyViewLayer
{
   self.enlargedKeyViewLayer = [CAShapeLayer layer];
   
   self.enlargedKeyViewLayer.lineWidth = 2.f;
   self.enlargedKeyViewLayer.fillColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:.96].CGColor;
   self.enlargedKeyViewLayer.strokeColor = [UIColor blackColor].CGColor;
   
   self.enlargedKeyViewLayer.shadowOpacity = .1f;
   self.enlargedKeyViewLayer.shadowRadius = 1.5f;
   self.enlargedKeyViewLayer.shadowOffset = CGSizeMake(0, .5f);
   
   [self.enlargedKeyViewLayer disableAnimations];
   self.enlargedKeyViewLayer.hidden = YES;
}

- (void)setupShadowLayer
{
   self.shadowLayerContainer = [CALayer layer];
   self.shadowLayerContainer.shadowOpacity = .25f;
   self.shadowLayerContainer.shadowRadius = 1.5f;
   self.shadowLayerContainer.shadowOffset = CGSizeMake(0, .5f);
}

#pragma mark - Update
- (void)updateEnlargedKeyPathWithFrame:(CGRect)frame
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
   
   self.enlargedKeyViewLayer.path = keyPath;
   CGPathRelease(keyPath);
}

#pragma mark - Helper
- (void)makeLayersVisible:(BOOL)visible
{
   self.showing = visible;
   self.enlargedKeyViewLayer.hidden = !visible;
   self.letterLayer.hidden = !visible;
}

- (void)updateLetterLayerWithText:(NSString*)text keyViewFrame:(CGRect)frame
{
   [self.letterLayer updateText:text];
   
   CGRect textFrame = frame;
   textFrame.origin.y -= 46.f;
   self.letterLayer.frame = textFrame;
}

#pragma mark - Public
- (void)drawEnlargedKeyView:(KeyView *)keyView
{
   if (self.showing == NO || self.currentKeyView != keyView)
   {
      self.currentKeyView = keyView;
      [self makeLayersVisible:YES];
      
      CGRect frame = [keyView convertRect:keyView.bounds toView:self];
      
      [self updateEnlargedKeyPathWithFrame:CGRectInset(frame, 2, 4)];
      [self updateLetterLayerWithText:keyView.displayText keyViewFrame:frame];
   }
}

- (void)reset
{
   [self makeLayersVisible:NO];
}

@end
