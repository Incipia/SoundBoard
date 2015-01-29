//
//  KeyboardTouchEventHandler.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/26/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardTouchEventHandler.h"
#import "KeyboardKeyFrameTextMap.h"
#import "KeyView.h"

@interface KeyboardTouchEventHandler ()

@property (nonatomic) NSDictionary* keyboardKeyFrameTextMap;
@property (nonatomic) KeyboardKeyFrameTextMap* keyFrameTextMap;
@property (nonatomic) id<UITextDocumentProxy> textProxy;

@property (nonatomic) KeyView* currentFocusedKeyView;

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
   CGPoint touchLocation = [touchEvent locationInView:nil];
   
   [self.keyFrameTextMap enumerateFramesUsingBlock:^(CGRect targetFrame, KeyView* keyView, BOOL *stop)
    {
       if (CGRectContainsPoint(targetFrame, touchLocation) && keyView != nil)
       {
          [keyView giveFocus];
          self.currentFocusedKeyView = keyView;
          *stop = YES;
          return;
       }
    }];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   UITouch* touchEvent = touches.anyObject;
   CGPoint touchLocation = [touchEvent locationInView:nil];
   
   [self.keyFrameTextMap enumerateFramesUsingBlock:^(CGRect targetFrame, KeyView* keyView, BOOL *stop)
    {
       if (CGRectContainsPoint(targetFrame, touchLocation) && keyView != nil)
       {
          [keyView giveFocus];
          self.currentFocusedKeyView = keyView;
       }
       else
       {
          [keyView removeFocus];
       }
    }];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   UITouch* touchEvent = touches.anyObject;
   CGPoint touchLocation = [touchEvent locationInView:nil];
   
   [self.keyFrameTextMap enumerateFramesUsingBlock:^(CGRect targetFrame, KeyView* keyView, BOOL *stop)
    {
       NSString* string = keyView.letter;
       if (CGRectContainsPoint(targetFrame, touchLocation) && string != nil)
       {
          // EDGE CASES!
          if ([string isEqualToString:@"next"] && self.advanceToNextKeyboardBlock != nil)
          {
             self.advanceToNextKeyboardBlock();
             *stop = YES;
             return;
          }
          else if ([string isEqualToString:@"space"])
          {
             [self.textProxy insertText:@" "];
             *stop = YES;
             return;
          }
          else if ([string isEqualToString:@"del"])
          {
             [self.textProxy deleteBackward];
             *stop = YES;
             return;
          }
          else if ([string isEqualToString:@"return"])
          {
             [self.textProxy insertText:@"\n"];
             *stop = YES;
             return;
          }
          else if ([string isEqualToString:@"123"])
          {
             if (self.modeSwitchingBlock)
             {
                self.modeSwitchingBlock(KeyboardModeNumbers);
                *stop = YES;
                return;
             }
          }
          else if ([string isEqualToString:@"ABC"])
          {
             if (self.modeSwitchingBlock)
             {
                self.modeSwitchingBlock(KeyboardModeLetters);
                *stop = YES;
                return;
             }
          }
          else if ([string isEqualToString:@"#+="])
          {
             if (self.modeSwitchingBlock)
             {
                self.modeSwitchingBlock(KeyboardModeSymbols);
                *stop = YES;
                return;
             }
          }
          else if ([string isEqualToString:@"shift"])
          {
             *stop = YES;
             return;
          }
          
          // for now...
          [self.textProxy insertText:string];
          *stop = YES;
       }
   }];
   
   [self.currentFocusedKeyView removeFocus];
}

#pragma mark - Keyboard Map Updater Protocol
- (void)updateKeyboardKeyFrameTextMap:(KeyboardKeyFrameTextMap*)keyFrameTexMap
{
   self.keyFrameTextMap = keyFrameTexMap;
}

@end
