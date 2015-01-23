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
   
   [layer setupProperties];
   [layer setLetter:letter];
   [layer updateFrame];
   
   return layer;
}

#pragma mark - Setup
- (void)setupProperties
{
   self.actions = @{@"position" : [NSNull null]};
   self.alignmentMode = kCAAlignmentCenter;
   self.contentsScale = [UIScreen mainScreen].scale;
}

- (void)setLetter:(NSString *)letter
{
   NSDictionary* letterAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                      NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:22.f]};
   
   NSAttributedString* attributedLetter = [[NSAttributedString alloc] initWithString:letter attributes:letterAttributes];
   self.string = attributedLetter;
}

#pragma mark - Update
- (void)updateFrame
{
   CGSize letterSize = [((NSAttributedString*)self.string) size];
   self.frame = CGRectMake(0, 0, letterSize.width, letterSize.height);
}

@end
