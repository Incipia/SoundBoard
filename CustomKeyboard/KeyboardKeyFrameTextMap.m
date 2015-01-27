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
   CGRect frame = keyView.frame;
   if (self.keyboardView != nil)
   {
      // Why do we have to use the superview here?!
      frame = [keyView.superview convertRect:keyView.frame toView:self.keyboardView];
   }
   return frame;
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
   self.keyFrameTextDictionary[frameValue] = keyView.letter;
}

- (void)addFramesForKeyViewCollection:(KeyViewCollection*)collection
{
   for (KeyView* keyView in collection.keyViews)
   {
      [self addFrameForKeyView:keyView];
   }
}

- (void)enumerateFramesUsingBlock:(void (^)(CGRect targetFrame, NSString* text, BOOL *stop))block
{
   BOOL stop = NO;
   for (NSValue* frameValue in self.keyFrameTextDictionary.allKeys)
   {
      if (block != nil && stop != YES)
      {
         CGRect targetFrame = [frameValue CGRectValue];
         block(targetFrame, self.keyFrameTextDictionary[frameValue], &stop);
      }
      else
      {
         break;
      }
   }
}

@end
