//
//  EnlargedKeyDrawingView.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/31/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "EnlargedKeyDrawingView.h"

@interface EnlargedKeyDrawingView ()
@property (nonatomic) CALayer* enlargedKeyViewLayer;
@end

@implementation EnlargedKeyDrawingView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame])
   {
      self.enlargedKeyViewLayer = [CALayer layer];
      self.enlargedKeyViewLayer.backgroundColor = [UIColor colorWithRed:0 green:.8 blue:1 alpha:.5].CGColor;
      self.enlargedKeyViewLayer.hidden = YES;
      
      [self.layer addSublayer:self.enlargedKeyViewLayer];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)drawingViewWithFrame:(CGRect)frame
{
   return [[[self class] alloc] initWithFrame:frame];
}

#pragma mark - Public
- (void)drawEnlargedKeyView:(KeyView *)keyView withFrame:(CGRect)frame
{
   self.enlargedKeyViewLayer.hidden = NO;
   self.enlargedKeyViewLayer.frame = CGRectMake(CGRectGetMinX(frame),
                                                CGRectGetMinY(frame) - 20,
                                                CGRectGetWidth(frame),
                                                CGRectGetHeight(frame) + 20);
}

- (void)reset
{
   self.enlargedKeyViewLayer.hidden = YES;
}

@end
