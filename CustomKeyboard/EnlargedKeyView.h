//
//  EnlargedKeyView.h
//  SoundBoard
//
//  Created by Gregory Klein on 2/2/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyView;
@interface EnlargedKeyView : UIView

+ (instancetype)viewWithKeyView:(KeyView*)keyView;
- (void)updateFrame:(CGRect)frame;

@end
