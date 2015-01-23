//
//  LetterRowViewCreator.h
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface LetterRowViewCreator : NSObject

+ (instancetype)creatorWithCharacterArray:(NSArray*)array;
- (UIView*)generateLetterRowView;

@property (nonatomic) CGFloat characterViewWidth;
@property (nonatomic) CGFloat characterViewHeight;

@end
