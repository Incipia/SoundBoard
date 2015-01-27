//
//  LetterView.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/21/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyView.h"
#import "KeyboardKeyLayer.h"

@interface KeyView ()
@property (nonatomic) KeyboardKeyLayer* letterLayer;
@property (nonatomic) CALayer* backgroundLayer;
@end

@implementation KeyView

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame
{
   if (self = [super initWithFrame:frame])
   {
      self.backgroundLayer = [CALayer layer];
      self.backgroundLayer.backgroundColor = [UIColor whiteColor].CGColor;
      self.backgroundLayer.cornerRadius = 12.f;
      self.backgroundLayer.shadowOpacity = .1;
      self.backgroundLayer.shadowOffset = CGSizeMake(0, -.5f);
      
      [self.layer addSublayer:self.backgroundLayer];
   }
   return self;
}

- (instancetype)initWithLetter:(NSString*)letter fontSize:(CGFloat)fontSize frame:(CGRect)frame
{
   if (self = [self initWithFrame:frame])
   {
      self.letter = letter;
      [self setupLetterLayerWithLetter:letter fontSize:fontSize];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)viewWithLetter:(NSString *)letter frame:(CGRect)frame
{
   return [[KeyView alloc] initWithLetter:letter fontSize:18.f frame:frame];
}

+ (instancetype)viewWithLetter:(NSString *)letter fontSize:(CGFloat)fontSize frame:(CGRect)frame
{
   return [[KeyView alloc] initWithLetter:letter fontSize:fontSize frame:frame];
}

#pragma mark - Setup
- (void)setupLetterLayerWithLetter:(NSString*)letter fontSize:(CGFloat)fontSize
{
   self.letterLayer = [KeyboardKeyLayer layerWithLetter:letter fontSize:fontSize];
   self.letterLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

   [self.layer addSublayer:self.letterLayer];
}

#pragma mark - Public
- (void)giveFocus
{
}

- (void)removeFocus
{
}

- (void)updateFrame:(CGRect)frame
{
   self.frame = frame;
   self.backgroundLayer.frame = CGRectInset(self.bounds, 1, 1);
   self.letterLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
}

@end
