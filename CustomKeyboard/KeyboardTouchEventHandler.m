//
//  KeyboardTouchEventHandler.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/26/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardTouchEventHandler.h"

@interface KeyboardTouchEventHandler ()
@property (nonatomic) NSDictionary* keyboardKeyFrameTextMap;
@property (nonatomic) id<UITextDocumentProxy> textProxy;
@end

@implementation KeyboardTouchEventHandler

+ (instancetype)handlerWithTextDocumentProxy:(id<UITextDocumentProxy>)proxy
{
   KeyboardTouchEventHandler* handler = [[[self class] alloc] init];
   handler.textProxy = proxy;
   
   return handler;
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   UITouch* touchEvent = touches.anyObject;
   CGPoint touchLocation = [touchEvent locationInView:self.view];
   
   for (NSValue* frameValue in self.keyboardKeyFrameTextMap.allKeys)
   {
      CGRect frame = [frameValue CGRectValue];
      if (CGRectContainsPoint(frame, touchLocation))
      {
         NSString* text = self.keyboardKeyFrameTextMap[frameValue];
         if (text != nil)
         {
            [self.textProxy insertText:text];
            return;
         }
      }
   }
}

#pragma mark - KeyboardMapUpdateListener
- (void)updateKeyboardMapDictionary:(NSDictionary*)dictionary
{
   self.keyboardKeyFrameTextMap = dictionary;
   NSLog(@"keyFrameTextMap: %@", self.keyboardKeyFrameTextMap);
}

@end
