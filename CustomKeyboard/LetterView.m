//
//  LetterView.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/21/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "LetterView.h"

@interface LetterView ()

@property (nonatomic) CATextLayer* letterLayer;

@end

@implementation LetterView

#pragma mark - Init
- (instancetype)initWithLetter:(NSString*)letter Frame:(CGRect)frame
{
   if (self = [super initWithFrame:frame])
   {
      [self setupLetterLayerWithLetter:letter];

      // temporary?
      self.backgroundColor = [UIColor whiteColor];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)viewWithLetter:(NSString *)letter frame:(CGRect)frame
{
   return [[LetterView alloc] initWithLetter:letter Frame:frame];
}

#pragma mark - Setup
- (void)setupLetterLayerWithLetter:(NSString*)letter
{
   self.letterLayer = [CATextLayer layer];

   self.letterLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
   self.letterLayer.fontSize = 20.f;
   self.letterLayer.string = letter;
   self.letterLayer.alignmentMode = kCAAlignmentCenter;

   self.letterLayer.foregroundColor = [UIColor blackColor].CGColor;
   self.letterLayer.backgroundColor = [UIColor whiteColor].CGColor;

   [self.layer addSublayer:self.letterLayer];
}

@end
