//
//  KeyboardTouchEventHandler.m
//  SoundBoard
//
//  Created by Klein, Greg on 1/26/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardTouchEventHandler.h"
#import "KeyboardModeManager.h"
#import "KeyboardKeyFrameTextMap.h"
#import "KeyView.h"
#import "TextDocumentProxyManager.h"
#import <AudioToolbox/AudioToolbox.h>

@interface KeyboardTouchEventHandler () <UIGestureRecognizerDelegate>
{
   KeyView *         _gestureView;
}

@property (nonatomic) KeyView* currentFocusedKeyView;
@property (nonatomic) KeyboardKeyFrameTextMap* keyFrameTextMap;
@property (nonatomic) UITouch* currentActiveTouch;
@property (nonatomic) KeyView* shiftKeyView;
@property (nonatomic) KeyView* spaceKeyView;
@property (nonatomic) UITapGestureRecognizer* tapRecognizer;

@end

@implementation KeyboardTouchEventHandler

#pragma mark - Init
- (instancetype)init
{
   if (self = [super init])
   {
      self.view.multipleTouchEnabled = YES;
      
      self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapRecognized:)];
      self.tapRecognizer.delegate = self;
      self.tapRecognizer.numberOfTapsRequired = 2;
      self.tapRecognizer.delaysTouchesEnded = NO;
      [self.view addGestureRecognizer:self.tapRecognizer];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)handler
{
   return [[[self class] alloc] init];
}

#pragma mark - Touch Events
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
   if (self.currentActiveTouch == nil)
   {
      [self handleTouch:touches.anyObject onTouchDown:YES];
   }
   else
   {
      if (self.currentFocusedKeyView.wantsToHandleTouchEvents)
      {
         [self.currentFocusedKeyView removeFocus];
         [self.currentFocusedKeyView executeActionBlock:1];
         self.currentFocusedKeyView = nil;
         self.currentActiveTouch = nil;
      }
      else
      {
         [self handleTouch:self.currentActiveTouch onTouchDown:NO];
      }
      [self handleTouch:touches.anyObject onTouchDown:YES];
   }
   self.currentActiveTouch = touches.anyObject;
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
   if (self.currentFocusedKeyView.wantsToHandleTouchEvents)
   {
      return;
   }
   CGPoint touchLocation = [self.currentActiveTouch locationInView:nil];
   KeyView* targetKeyView = [self.keyFrameTextMap keyViewAtPoint:touchLocation];
   [self drawEnlargedKeyView:targetKeyView];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
   if (self.currentFocusedKeyView.wantsToHandleTouchEvents)
   {
      [self.currentFocusedKeyView removeFocus];
      [self.currentFocusedKeyView executeActionBlock:1];
      self.currentFocusedKeyView = nil;
      self.currentActiveTouch = nil;
   }
   else if (self.currentActiveTouch == touches.anyObject)
   {
      [self.currentFocusedKeyView removeFocus];
      self.currentFocusedKeyView = nil;
      [self handleTouch:self.currentActiveTouch onTouchDown:NO];
      self.currentActiveTouch = nil;
   }
}

#pragma mark - quick and dirty sound playback
- (SystemSoundID)loadSoundForKeyView:(KeyView *)keyView
{
   // TODO:LEA: keep a map of keyViews to sounds
   //           load the proper sound for the keyView
   //           Eventually extend this to also load the proper sound depending
   //           on how many sounds are playing (to build chords)
   //           Also, depending on keyclick frequency, increase or decrease the
   //           volume of the sounds?
   SystemSoundID buttonSound = 0;
   NSURL *audioPath = [[NSBundle mainBundle] URLForResource:@"tapClick" withExtension:@"aiff"];
   AudioServicesCreateSystemSoundID((__bridge CFURLRef)audioPath, &buttonSound);
   return buttonSound;
}

- (void)playSoundForKeyView:(KeyView *)keyView
{
   SystemSoundID buttonSound = [self loadSoundForKeyView:keyView];
   if (buttonSound)
      AudioServicesPlaySystemSound(buttonSound);
}

#pragma mark - Helper
- (void)handleTouch:(UITouch*)touch onTouchDown:(BOOL)touchDown
{
   if (touch != nil)
   {
      CGPoint touchLocation = [touch locationInView:nil];
      KeyView* targetKeyView = [self.keyFrameTextMap keyViewAtPoint:touchLocation];

      BOOL shouldTrigger = touchDown? targetKeyView.shouldTriggerActionOnTouchDown :
                                      !targetKeyView.shouldTriggerActionOnTouchDown;
      
      if (targetKeyView != nil && shouldTrigger)
      {
         dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [targetKeyView executeActionBlock:1];
         });
      }
      
      if (touchDown == YES)
      {
         [self drawEnlargedKeyView:targetKeyView];
      }
      else
      {
         [self playSoundForKeyView:targetKeyView];
      }
   }
}

- (void)drawEnlargedKeyView:(KeyView*)keyView
{
   if (keyView != nil)
   {
      if (self.currentFocusedKeyView != keyView)
      {
         [keyView giveFocus];
         [self.currentFocusedKeyView removeFocus];
         self.currentFocusedKeyView = keyView;
      }
   }
   else
   {
      [self.currentFocusedKeyView removeFocus];
      self.currentFocusedKeyView = nil;
   }
}

#pragma mark - Keyboard Map Updater Protocol
- (void)updateKeyboardKeyFrameTextMap:(KeyboardKeyFrameTextMap*)keyFrameTexMap
{
   self.keyFrameTextMap = keyFrameTexMap;
   for (KeyView* keyView in self.keyFrameTextMap.keyViews)
   {
      if ([keyView.displayText isEqualToString:@"shift"])
      {
         self.shiftKeyView = keyView;
      }
      else if ([keyView.displayText isEqualToString:@""])
      {
         self.spaceKeyView = keyView;
      }
   }
}

#pragma mark - UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
   _gestureView = [self.keyFrameTextMap keyViewAtPoint:[touch locationInView:nil]];
   return (_gestureView == self.shiftKeyView || _gestureView == self.spaceKeyView);
}

- (void)doubleTapRecognized:(UIGestureRecognizer*)recognizer
{
   if (_gestureView == self.shiftKeyView)
   {
      [self.shiftKeyView removeFocus];
      [KeyboardModeManager updateKeyboardShiftMode:ShiftModeCapsLock];
      self.currentActiveTouch = nil;
   }
   else if (_gestureView == self.spaceKeyView)
   {
      [self.spaceKeyView removeFocus];
      dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         [self.spaceKeyView executeActionBlock:-1];
      });
   }
}

@end
