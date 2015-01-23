//
//  KeyboardLetterLayer.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardLetterLayer.h"
@import UIKit;

@implementation KeyboardLetterLayer

#pragma mark - Class Init
+ (instancetype)layerWithLetter:(NSString*)letter
{
   KeyboardLetterLayer* layer = [KeyboardLetterLayer layer];
   
   layer.actions = @{@"position" : [NSNull null]};
   [layer setLetter:letter];
   [layer updateFrame];
   
   return layer;
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
