//
//  LetterRowViewCreator.m
//  SoundBoard
//
//  Created by Gregory Klein on 1/22/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "LetterRowViewCreator.h"
#import "LetterView.h"

@interface LetterRowViewCreator ()
@property (nonatomic) NSArray *characterArray;
@end

@implementation LetterRowViewCreator

#pragma mark - Class Init
+ (instancetype)creatorWithCharacterArray:(NSArray*)array
{
   LetterRowViewCreator* creator = [LetterRowViewCreator new];
   creator.characterArray = array;

   return creator;
}

#pragma mark - Public
- (UIView*)generateLetterRowView
{
   return nil;
}

@end
