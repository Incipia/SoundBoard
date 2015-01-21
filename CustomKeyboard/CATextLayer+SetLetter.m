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

- (void)setLetterForKeyboard:(NSString *)letter
{
   NSDictionary* letterAttributes = @{NSForegroundColorAttributeName : [UIColor blackColor],
                                      NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Light" size:22.f]};
   
   NSAttributedString* attributedLetter = [[NSAttributedString alloc] initWithString:letter attributes:letterAttributes];
   
   self.string = attributedLetter;
   self.alignmentMode = kCAAlignmentCenter;
   self.contentsScale = [UIScreen mainScreen].scale;
}

@end
