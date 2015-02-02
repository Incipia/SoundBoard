//
//  EnlargedKeyDrawingView.h
//  SoundBoard
//
//  Created by Klein, Greg on 1/31/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KeyView;
@interface EnlargedKeyDrawingView : UIView

+ (instancetype)drawingViewWithFrame:(CGRect)frame;

- (void)drawEnlargedKeyView:(KeyView*)keyView;
- (void)reset;

@end
