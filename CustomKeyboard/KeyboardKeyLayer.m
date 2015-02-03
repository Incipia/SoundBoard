//
//  KeyboardLetterLayer.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeyLayer.h"
#import "CALayer+DisableAnimations.h"
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
   self.alignmentMode = kCAAlignmentCenter;
   self.contentsScale = [UIScreen mainScreen].scale;
   [self disableAnimations];
}

- (void)setText:(NSString*)text fontSize:(CGFloat)fontSize
{
   NSDictionary* textAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
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

- (void)updateTextColor:(UIColor*)color
{
   NSDictionary* textAttributes = @{NSForegroundColorAttributeName : color,
                                    NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize]};

   NSAttributedString* attributedString = (NSAttributedString*)self.string;
   NSString* string = attributedString.string;

   NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:textAttributes];

   self.string = attributedText;
}

#pragma mark - Public
- (void)updateText:(NSString*)text
{
   [self setText:text fontSize:self.fontSize];
}

@end
