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
#import "KeyboardModeManager.h"
#import "KeyboardTypedefs.h"
@import UIKit;

@interface KeyboardKeyLayer ()
@property (nonatomic) UIColor* highlightedTextColor;
@property (nonatomic) UIColor* textColor;
@property (nonatomic) KeyboardKeyType keyType;
@end

@implementation KeyboardKeyLayer

#pragma mark - Class Init
- (instancetype)initWithText:(NSString*)text keyType:(KeyboardKeyType)type
{
   if (self = [super init])
   {
      [self setupPropertiesWithType:type];
      [self setText:text fontSize:self.fontSize];
      [self updateFrame];
   }
   return self;
}

+ (instancetype)layerWithText:(NSString *)text keyType:(KeyboardKeyType)type
{
   return [[self alloc] initWithText:text keyType:type];
}

#pragma mark - Setup
- (void)setupPropertiesWithType:(KeyboardKeyType)type
{
   self.keyType = type;
   self.fontSize = [ThemeAttributesProvider fontSizeForKeyType:type];
   self.textColor = [ThemeAttributesProvider fontColorForKeyType:type];
   self.highlightedTextColor = [ThemeAttributesProvider highlightedFontColorForKeyType:type];
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

- (void)applyHighlight
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : self.highlightedTextColor,
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize],
                                       NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone),
                                       NSUnderlineColorAttributeName : self.highlightedTextColor};

      BOOL capitalized = [KeyboardModeManager currentShiftMode] != ShiftModeNotApplied;
      [self updateStringWithAttributesDictionary:textAttributes capitalized:capitalized];
   });
}

- (void)removeHighlight
{
   dispatch_async(dispatch_get_main_queue(), ^{
      NSDictionary* textAttributes = @{NSForegroundColorAttributeName : self.textColor,
                                       NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue" size:self.fontSize],
                                       NSUnderlineStyleAttributeName : @(NSUnderlineStyleNone),
                                       NSUnderlineColorAttributeName : self.textColor};

      BOOL capitalized = [KeyboardModeManager currentShiftMode] != ShiftModeNotApplied;
      [self updateStringWithAttributesDictionary:textAttributes capitalized:capitalized];
   });
}

@end
