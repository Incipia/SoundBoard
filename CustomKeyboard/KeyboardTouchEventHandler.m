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
   dispatch_source_t _oneShotTimer;
   dispatch_source_t _repeatTimer;
   KeyView *         _repeatKey;
   NSInteger         _repeatCount;
}

@property (nonatomic) KeyView* currentFocusedKeyView;
@property (nonatomic) KeyboardKeyFrameTextMap* keyFrameTextMap;
@property (nonatomic) UITouch* currentActiveTouch;
@property (nonatomic) KeyView* shiftKeyView;
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

- (void)dealloc
{
   [self stopTimer];
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
      [self handleTouch:self.currentActiveTouch onTouchDown:NO];
   }
   self.currentActiveTouch = touches.anyObject;
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
   CGPoint touchLocation = [self.currentActiveTouch locationInView:nil];
   KeyView* targetKeyView = [self.keyFrameTextMap keyViewAtPoint:touchLocation];
   [self drawEnlargedKeyView:targetKeyView];
}

- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event
{
   if (self.currentActiveTouch == touches.anyObject)
   {
      [self.currentFocusedKeyView removeFocus];
      self.currentFocusedKeyView = nil;
      [self handleTouch:self.currentActiveTouch onTouchDown:NO];
      self.currentActiveTouch = nil;
   }
}

#pragma mark - key press timers - one shot timer fires in 1/2 second, then starts a repeat timer
- (dispatch_source_t)createTimer:(dispatch_block_t)block
{
   dispatch_source_t timer =
   dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,
                          dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
   if (timer)
   {
      dispatch_source_set_event_handler(timer, block);
   }
   
   return timer;
}

- (void)startTimer:(KeyView*)repeatKey
{
   _repeatKey = repeatKey;
   _repeatCount = 1;
   
   [self stopTimer];

   if (_repeatKey)
   {
      if (_oneShotTimer == NULL)
         _oneShotTimer = [self createTimer:^{[self fireOneShot];}];
      
      assert(_oneShotTimer != NULL);
      dispatch_source_set_timer(_oneShotTimer,
                                dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC),
                                DISPATCH_TIME_FOREVER, 0.010 * NSEC_PER_SEC);
      dispatch_resume(_oneShotTimer);
   }
}

- (BOOL)stopTimer
{
   BOOL result = false;
   if (_oneShotTimer && 0 == dispatch_source_testcancel(_oneShotTimer))
   {
      dispatch_source_cancel(_oneShotTimer);
      _oneShotTimer = NULL;
      result = true;
   }
   
   [self stopRepeatTimer];
   return result;
}

- (void)fireOneShot
{
   if ([self stopTimer]) [self startRepeatTimer:0.09];
}

- (void)startRepeatTimer:(double)repeatTimeInSeconds
{
   [self stopRepeatTimer];
   if (_repeatKey)
   {
      if (_repeatTimer == NULL)
         _repeatTimer = [self createTimer:^{[self fireKeyRepeat];}];
      
      assert(_repeatTimer != NULL);
      dispatch_source_set_timer(_repeatTimer,
                                dispatch_walltime(NULL, 0),
                                repeatTimeInSeconds * NSEC_PER_SEC,
                                0.010 * NSEC_PER_SEC);
      dispatch_resume(_repeatTimer);
   }
}

- (void)stopRepeatTimer
{
   if (_repeatTimer && 0 == dispatch_source_testcancel(_repeatTimer))
   {
      dispatch_source_cancel(_repeatTimer);
      _repeatTimer = NULL;
   }
}

- (void)fireKeyRepeat
{
   if (_repeatKey)
   {
      NSInteger currentCount = _repeatCount;
      ++_repeatCount;
      
      [_repeatKey executeActionBlock:_repeatCount];
      
      if (currentCount < KeyboardRepeatWord && _repeatCount >= KeyboardRepeatWord)
      {
         [self stopRepeatTimer];
         [self startRepeatTimer:0.50];
      }
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
      
      if (!shouldTrigger || targetKeyView == nil) [self stopTimer];
         
      if (touchDown == YES)
      {
         if (shouldTrigger) [self startTimer:targetKeyView];
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
         break;
      }
   }
}

#pragma mark - UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
   KeyView* keyView = [self.keyFrameTextMap keyViewAtPoint:[touch locationInView:nil]];
   return (keyView == self.shiftKeyView);
}

- (void)doubleTapRecognized:(UIGestureRecognizer*)recognizer
{
   [self.shiftKeyView removeFocus];
   [KeyboardModeManager updateKeyboardShiftMode:ShiftModeCapsLock];
   self.currentActiveTouch = nil;
}

@end
