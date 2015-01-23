//
//  LetterViewCollection.h
//  SoundBoard
//
//  Created by Gregory Klein on 1/23/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LetterViewCollection : UIView

+ (instancetype)collectionWithCharacterArray:(NSArray*)array;
- (void)updateFrame:(CGRect)frame;

@property (nonatomic, readonly) NSArray* letterViews;

@end
