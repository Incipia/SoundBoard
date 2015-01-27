//
//  KeyboardViewController.m
//  CustomKeyboard
//
//  Created by Gregory Klein on 1/17/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "KeyboardViewController.h"
#import "KeyboardAuxiliaryController.h"
#import "KeyboardKeysController.h"
#import "KeyboardTouchEventHandler.h"

static const CGFloat s_auxViewHeightPercentage = .2f;

@interface KeyboardViewController ()
@property (nonatomic) KeyboardAuxiliaryController* auxController;
@property (nonatomic) KeyboardKeysController* keysController;
@property (nonatomic) KeyboardTouchEventHandler* touchEventHandler;
@end

@implementation KeyboardViewController

#pragma mark - Lifecycle
- (void)viewDidLoad
{
   [super viewDidLoad];
   
   [self setupControllers];
   [self setupTouchEventHandler];

   // temporary!
   self.auxController.keysController = self.keysController;
}

- (void)viewDidLayoutSubviews
{
   [self updateControllerViewFrames];
}

#pragma mark - Setup
- (void)setupControllers
{
   self.auxController = [KeyboardAuxiliaryController controller];
   [self.view addSubview:self.auxController.view];

   self.keysController = [KeyboardKeysController controllerWithMode:KeyboardModeLetters];
   [self.view addSubview:self.keysController.view];
}

- (void)setupTouchEventHandler
{
   self.touchEventHandler = [KeyboardTouchEventHandler handlerWithTextDocumentProxy:self.textDocumentProxy];
   
   __weak typeof(self) weakSelf = self;
   self.touchEventHandler.advanceToNextKeyboardBlock = ^
   {
      [weakSelf advanceToNextInputMode];
   };
   
   [self.view addSubview:self.touchEventHandler.view];
   
   self.keysController.keyboardMapUpdater = self.touchEventHandler;
}

#pragma mark - Update
- (void)updateControllerViewFrames
{
   [self updateAuxViewFrame];
   [self updateKeysViewFrame];
   self.touchEventHandler.view.frame = self.keysController.view.frame;
}

- (void)updateAuxViewFrame
{
   NSUInteger containerViewHeight = (int)CGRectGetHeight(self.view.bounds)*s_auxViewHeightPercentage;
   self.auxController.view.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), containerViewHeight);
}

- (void)updateKeysViewFrame
{
   CGFloat keysViewHeight = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.auxController.view.bounds);
   CGFloat keysViewYPosition = CGRectGetMaxY(self.auxController.view.bounds);
   self.keysController.view.frame = CGRectMake(0, keysViewYPosition, CGRectGetWidth(self.view.bounds), keysViewHeight);
}

#pragma mark - UITextInput Delegate
- (void)textWillChange:(id<UITextInput>)textInput
{
   // The app is about to change the document's contents. Perform any preparation here.
}

- (void)textDidChange:(id<UITextInput>)textInput
{
}

@end
