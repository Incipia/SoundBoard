//
//  KeyboardLetterLayer.h
//  SoundBoard
//
//  Created by Klein, Greg on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
@import UIKit;

@interface KeyboardKeyLayer : CATextLayer

+ (instancetype)layerWithText:(NSString*)text;
+ (instancetype)layerWithText:(NSString*)text fontSize:(CGFloat)fontSize;

- (void)makeTextBold;
- (void)makeTextRegular;
- (void)makeTextUnderlined;
- (void)removeTextUnderline;
- (void)makeTextUppercase;
- (void)makeTextLowercase;

@end
