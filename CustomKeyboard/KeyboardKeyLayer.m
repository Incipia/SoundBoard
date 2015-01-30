//
//  KeyboardLetterLayer.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeyLayer.h"
@import UIKit;

@implementation KeyboardKeyLayer

#pragma mark - Class Init
+ (instancetype)layerWithText:(NSString*)string
{
   return [KeyboardKeyLayer layerWithText:string fontSize:22.f];
}

+ (instancetype)layerWithText:(NSString*)text fontSize:(CGFloat)fontSize
{
   KeyboardKeyLayer* layer = [KeyboardKeyLayer layer];
   
   [layer setupProperties];
   [layer setText:text fontSize:fontSize];
   [layer updateFrame];
   
   return layer;
}

#pragma mark - Setup
- (void)setupProperties
{
   self.actions = @{@"frame" : [NSNull null], @"bounds" : [NSNull null], @"position" : [NSNull null]};
   self.alignmentMode = kCAAlignmentCenter;
   self.contentsScale = [UIScreen mainScreen].scale;
}

- (void)setText:(NSString*)text fontSize:(CGFloat)fontSize
{
   NSDictionary* textAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                      NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:fontSize]};
   
   NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:text attributes:textAttributes];
   self.string = attributedText;
}

#pragma mark - Update
- (void)updateFrame
{
   CGSize textSize = [((NSAttributedString*)self.string) size];
   self.frame = CGRectMake(0, 0, textSize.width, textSize.height);
}

- (void)updateTextAttribute:(NSString*)attribute withValue:(id)value
{
   NSMutableAttributedString* mutableString = [((NSAttributedString*)self.string) mutableCopy];
   [mutableString removeAttribute:attribute range:NSRangeFromString(mutableString.string)];
   [mutableString addAttribute:attribute value:value range:NSRangeFromString(mutableString.string)];
}

@end
