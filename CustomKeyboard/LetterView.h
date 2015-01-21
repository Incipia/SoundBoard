//
//  LetterView.h
//  SoundBoard
//
//  Created by Gregory Klein on 1/21/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LetterView : UIView

+ (instancetype)viewWithLetter:(NSString*)letter frame:(CGRect)frame;

@property (nonatomic, copy) NSString* letter;

@end
