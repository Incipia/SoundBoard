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
   self.fontSize = fontSize;
   NSDictionary* textAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                      NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:fontSize]};
   
   NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:text attributes:textAttributes];
   self.string = attributedText;
}

#pragma mark - Update
- (void)updateFrame
{
   CGSize textSize = [((NSAttributedString*)self.string) size];
   self.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
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

- (void)updateStringAttribute:(NSString*)attribute withValue:(id)value
{
   NSMutableAttributedString* mutableString = [((NSAttributedString*)self.string) mutableCopy];
   
   NSRange range = NSMakeRange(0, mutableString.length);
   NSMutableDictionary* mutableAttributes = [[mutableString attributesAtIndex:0 effectiveRange:&range] mutableCopy];
   mutableAttributes[attribute] = value;
   [mutableString setAttributes:mutableAttributes range:range];
   
   self.string = mutableString;
}

#pragma mark - Public
- (void)updateText:(NSString*)text fontSize:(CGFloat)fontSize
{
   dispatch_async(dispatch_get_main_queue(), ^{
      [self setText:text fontSize:fontSize];
      [self updateFrame];
   });
}

- (void)makeTextBold
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:self.fontSize]};
      
      NSString* string = ((NSAttributedString*)self.string).string;
      NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:textAttributes];
      self.string = attributedText;
      [self updateFrame];
   });
}

- (void)makeTextRegular
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize]};
      
      NSString* string = ((NSAttributedString*)self.string).string;
      NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:textAttributes];
      self.string = attributedText;
      [self updateFrame];
   });
}

- (void)makeTextUnderlined
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:self.fontSize],
                                       NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                                       NSUnderlineColorAttributeName : [UIColor whiteColor]};
      
      NSString* string = ((NSAttributedString*)self.string).string;
      NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:textAttributes];
      self.string = attributedText;
      [self updateFrame];
   });
}

- (void)removeTextUnderline
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize],
                                       NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone),
                                       NSUnderlineColorAttributeName : [UIColor whiteColor]};
      
      NSString* string = ((NSAttributedString*)self.string).string;
      NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:textAttributes];
      self.string = attributedText;
      [self updateFrame];
   });
}

@end
