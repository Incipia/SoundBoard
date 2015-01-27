//
//  KeyboardTouchEventHandler.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/26/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardTouchEventHandler.h"
#import "KeyboardKeyFrameTextMap.h"

@interface KeyboardTouchEventHandler ()
@property (nonatomic) NSDictionary* keyboardKeyFrameTextMap;
@property (nonatomic) KeyboardKeyFrameTextMap* keyFrameTextMap;
@property (nonatomic) id<UITextDocumentProxy> textProxy;
@end

@implementation KeyboardTouchEventHandler

#pragma mark - Class Init
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
   
   [self.keyFrameTextMap enumerateFramesUsingBlock:^(CGRect targetFrame, NSString* string, BOOL *stop) {
      if (CGRectContainsPoint(targetFrame, touchLocation) && string != nil)
      {
         // for now...
         [self.textProxy insertText:string];
         *stop = YES;
      }
   }];
}

#pragma mark - KeyboardMapUpdateListener
- (void)updateKeyboardKeyFrameTextMap:(KeyboardKeyFrameTextMap*)keyFrameTexMap
{
   self.keyFrameTextMap = keyFrameTexMap;
}

@end
