//
//  KeyboardLetterLayer.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeyLayer.h"
#import "CALayer+DisableAnimations.h"
#import "ThemeAttributesProvider.h"
@import UIKit;

@interface KeyboardKeyLayer ()
@property (nonatomic) UIColor* textColor;
@end

@implementation KeyboardKeyLayer

#pragma mark - Class Init
+ (instancetype)layerWithText:(NSString*)text fontSize:(CGFloat)fontSize color:(UIColor*)color
{
   KeyboardKeyLayer* layer = [KeyboardKeyLayer layer];
   layer.textColor = color;

   [layer setupProperties];
   [layer setText:text fontSize:fontSize];
   [layer updateFrame];

   return layer;
}

+ (instancetype)layerWithText:(NSString *)text keyType:(KeyboardKeyType)type
{
   CGFloat fontSize = [ThemeAttributesProvider fontSizeForKeyType:type];
   UIColor* color = [ThemeAttributesProvider fontColorForKeyType:type];
   return [[self class] layerWithText:text fontSize:fontSize color:color];
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
   NSDictionary* textAttributes = @{NSForegroundColorAttributeName : self.textColor,
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

- (void)updateStringWithAttributesDictionary:(NSDictionary*)attributes capitalized:(BOOL)capitalized
{
   NSString* string = ((NSAttributedString*)self.string).string;
   string = capitalized ? string.capitalizedString : string.lowercaseString;
   
   NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:attributes];
   self.string = attributedText;
   [self updateFrame];
}

#pragma mark - Public
- (void)makeTextBold
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : self.textColor,
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:self.fontSize]};
      
      [self updateStringWithAttributesDictionary:textAttributes capitalized:NO];
   });
}

- (void)makeTextRegular
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : self.textColor,
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize]};
      
      [self updateStringWithAttributesDictionary:textAttributes capitalized:NO];
   });
}

- (void)makeTextUnderlined
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : self.textColor,
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:self.fontSize],
                                       NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
                                       NSUnderlineColorAttributeName : [UIColor whiteColor]};
      
      [self updateStringWithAttributesDictionary:textAttributes capitalized:NO];
   });
}

- (void)removeTextUnderline
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : self.textColor,
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize],
                                       NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone),
                                       NSUnderlineColorAttributeName : self.textColor};
      
      [self updateStringWithAttributesDictionary:textAttributes capitalized:NO];
   });
}

- (void)makeTextUppercase
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : self.textColor,
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize],
                                       NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone),
                                       NSUnderlineColorAttributeName : self.textColor};
      
      [self updateStringWithAttributesDictionary:textAttributes capitalized:YES];
   });
}

- (void)makeTextLowercase
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : self.textColor,
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize],
                                       NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone),
                                       NSUnderlineColorAttributeName : self.textColor};
      
      [self updateStringWithAttributesDictionary:textAttributes capitalized:NO];
   });
}

@end
