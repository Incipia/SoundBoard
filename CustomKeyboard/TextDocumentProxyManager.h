//
//  TextDocumentProxyManager.h
//  SoundBoard
//
//  Created by Klein, Greg on 1/29/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface TextDocumentProxyManager : NSObject

@property (nonatomic, readonly) NSString* documentContextBeforeInput;
@property (nonatomic, readonly) NSString* documentContextAfterInput;

+ (void)setTextDocumentProxy:(id<UITextDocumentProxy>)proxy;
+ (void)insertText:(NSString*)text;
+ (void)deleteBackward;
+ (void)adjustTextPositionByCharacterOffset:(NSInteger)offset;

@end
