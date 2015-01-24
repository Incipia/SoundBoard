//
//  LetterView.h
//  SoundBoard
//
//  Created by Gregory Klein on 1/21/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyView : UIView

+ (instancetype)viewWithLetter:(NSString*)letter frame:(CGRect)frame;
+ (instancetype)viewWithLetter:(NSString *)letter fontSize:(CGFloat)fontSize frame:(CGRect)frame;

- (void)giveFocus;
- (void)removeFocus;
- (void)updateFrame:(CGRect)frame;

@property (nonatomic, copy) NSString* letter;

@end
