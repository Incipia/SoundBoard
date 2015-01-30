//
//  KeyboardKeyFrameTextMap.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/26/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardKeyFrameTextMap.h"
#import "KeyViewCollection.h"
#import "KeyView.h"

@interface KeyboardKeyFrameTextMap ()
@property (nonatomic) NSMutableDictionary* keyFrameTextDictionary;
@end

@implementation KeyboardKeyFrameTextMap

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      self.keyFrameTextDictionary = [NSMutableDictionary dictionary];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)map
{
   return [[KeyboardKeyFrameTextMap alloc] init];
}

#pragma mark - Helper
- (CGRect)convertedFrameFromKeyboardView:(KeyView*)keyView
{
   return [keyView convertRect:keyView.bounds toView:nil];
}

#pragma mark - Public
- (void)reset
{
   [self.keyFrameTextDictionary removeAllObjects];
}

- (void)addFrameForKeyView:(KeyView*)keyView
{
   CGRect frame = [self convertedFrameFromKeyboardView:keyView];
   NSValue* frameValue = [NSValue valueWithCGRect:frame];
   self.keyFrameTextDictionary[frameValue] = keyView;
}

- (void)addFramesForKeyViewCollection:(KeyViewCollection*)collection
{
   for (KeyView* keyView in collection.keyViews)
   {
      [self addFrameForKeyView:keyView];
   }
}

- (KeyView*)keyViewAtPoint:(CGPoint)point
{
   KeyView* targetKeyView = nil;
   for (NSValue* frameValue in self.keyFrameTextDictionary.allKeys)
   {
      CGRect frame = [frameValue CGRectValue];
      if (CGRectContainsPoint(frame, point))
      {
         targetKeyView = self.keyFrameTextDictionary[frameValue];
         break;
      }
   }
   return targetKeyView;
}

@end
