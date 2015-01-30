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
#import "TextDocumentProxyManager.h"

@interface KeyboardTouchEventHandler ()
@property (nonatomic) KeyboardKeyFrameTextMap* keyFrameTextMap;
@property (nonatomic) KeyView* currentFocusedKeyView;
@end

@implementation KeyboardTouchEventHandler

#pragma mark - Class Init
+ (instancetype)handler
{
   return [[self class] new];
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   NSLog(@"touchBegan!");
   UITouch* touchEvent = touches.anyObject;
   CGPoint touchLocation = [touchEvent locationInView:nil];
   
   KeyView* targetKeyView = [self.keyFrameTextMap keyViewAtPoint:touchLocation];
   if (targetKeyView != nil)
   {
      [TextDocumentProxyManager insertText:targetKeyView.displayText];
   }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

#pragma mark - Keyboard Map Updater Protocol
- (void)updateKeyboardKeyFrameTextMap:(KeyboardKeyFrameTextMap*)keyFrameTexMap
{
   self.keyFrameTextMap = keyFrameTexMap;
}

@end
