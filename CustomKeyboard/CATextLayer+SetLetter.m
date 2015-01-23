//
//  CATextLayer+SetLetter.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/21/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "CATextLayer+SetLetter.h"
@import UIKit;

@implementation CATextLayer (SetLetter)

#pragma mark - Public
+ (instancetype)layerWithLetter:(NSString *)letter
{
   CATextLayer* textLayer = [CATextLayer layer];
   
   [textLayer setLetter:letter];
   [textLayer updateFrame];
   
   return textLayer;
}

#pragma mark - Private
- (void)setLetter:(NSString *)letter
{
   NSDictionary* letterAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                      NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:22.f]};

   NSAttributedString* attributedLetter = [[NSAttributedString alloc] initWithString:letter attributes:letterAttributes];

   self.string = attributedLetter;
   self.alignmentMode = kCAAlignmentCenter;
   self.contentsScale = [UIScreen mainScreen].scale;
}

- (void)updateFrame
{
   CGSize letterSize = [((NSAttributedString*)self.string) size];
   self.frame = CGRectMake(0, 0, letterSize.width, letterSize.height);
}

@end
