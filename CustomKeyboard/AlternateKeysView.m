//
//  AlternateKeysView.m
//  SoundBoard
//
//  Created by Klein, Greg on 2/21/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#import "AlternateKeysView.h"
#import "KeyboardKeyLayer.h"
#import "CALayer+DisableAnimations.h"
#import "KeyboardKeyLayer.h"
#import "LetterSymbolKeyView.h"
#import "KeyViewCollection.h"
#import "KeyboardKeysUtility.h"

static NSArray* _altCharactersArray(AltKeysViewDirection direction, NSString* primaryCharacter)
{
   NSMutableArray* mutableAltCharacters = [[KeyboardKeysUtility altCharacterArrayForCharacter:primaryCharacter] mutableCopy];
   NSUInteger indexToInsert = 0;
   switch (direction)
   {
      case AltKeysViewDirectionCenter:
         indexToInsert = mutableAltCharacters.count * .5f;
         break;
         
      case AltKeysViewDirectionLeft:
         indexToInsert = mutableAltCharacters.count;
         break;
         
      case AltKeysViewDirectionRight:
      default:
         break;
   }
   [mutableAltCharacters insertObject:primaryCharacter atIndex:indexToInsert];
   return mutableAltCharacters;
}

static AltKeysViewDirection _directionForCharacter(NSString* character)
{
   AltKeysViewDirection direction = AltKeysViewDirectionCenter;
   NSString* uppercaseCharacter = character.uppercaseString;
   
   if ([uppercaseCharacter isEqualToString:@"E"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"Y"])
   {
      direction = AltKeysViewDirectionLeft;
   }
   else if ([uppercaseCharacter isEqualToString:@"U"])
   {
      direction = AltKeysViewDirectionLeft;
   }
   else if ([uppercaseCharacter isEqualToString:@"I"])
   {
      direction = AltKeysViewDirectionLeft;
   }
   else if ([uppercaseCharacter isEqualToString:@"O"])
   {
      direction = AltKeysViewDirectionLeft;
   }
   else if ([uppercaseCharacter isEqualToString:@"A"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"S"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"L"])
   {
      direction = AltKeysViewDirectionLeft;
   }
   else if ([uppercaseCharacter isEqualToString:@"Z"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"C"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"N"])
   {
      direction = AltKeysViewDirectionLeft;
   }
   else if ([uppercaseCharacter isEqualToString:@"%"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"."])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"?"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"!"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"'"])
   {
      direction = AltKeysViewDirectionLeft;
   }
   else if ([uppercaseCharacter isEqualToString:@"0"])
   {
      direction = AltKeysViewDirectionLeft;
   }
   else if ([uppercaseCharacter isEqualToString:@"-"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"/"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"$"])
   {
      direction = AltKeysViewDirectionCenter;
   }
   else if ([uppercaseCharacter isEqualToString:@"&"])
   {
      direction = AltKeysViewDirectionRight;
   }
   else if ([uppercaseCharacter isEqualToString:@"\""])
   {
      direction = AltKeysViewDirectionLeft;
   }
   return direction;
}

CGPathRef _centerAlternateKeysBackgroundPath(CGRect bottomFrame, CGRect alternateKeysFrame)
{
   CGFloat minX = CGRectGetMinX(bottomFrame);
   CGFloat minY = CGRectGetMinY(bottomFrame);
   CGFloat maxX = CGRectGetMaxX(bottomFrame);
   CGFloat maxY = CGRectGetMaxY(bottomFrame);
   
   CGMutablePathRef keyPath = CGPathCreateMutable();
   
   CGPathMoveToPoint(keyPath, nil, minX, minY);
   CGPathAddLineToPoint(keyPath, nil, minX - 8, minY - 8);
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMinX(alternateKeysFrame), minY - 8);
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMinX(alternateKeysFrame), CGRectGetMinY(alternateKeysFrame));
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMaxX(alternateKeysFrame), CGRectGetMinY(alternateKeysFrame));
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMaxX(alternateKeysFrame), minY - 8);
   
   CGPathAddLineToPoint(keyPath, nil, maxX + 8, minY - 8);
   CGPathAddLineToPoint(keyPath, nil, maxX, minY);
   CGPathAddLineToPoint(keyPath, nil, maxX, maxY);
   CGPathAddLineToPoint(keyPath, nil, minX, maxY);
   CGPathCloseSubpath(keyPath);
   
   return keyPath;
}

CGPathRef _leftAlternateKeysBackgroundPath(CGRect bottomFrame, CGRect alternateKeysFrame)
{
   CGFloat minX = CGRectGetMinX(bottomFrame);
   CGFloat minY = CGRectGetMinY(bottomFrame);
   CGFloat maxX = CGRectGetMaxX(bottomFrame);
   CGFloat maxY = CGRectGetMaxY(bottomFrame);
   
   CGMutablePathRef keyPath = CGPathCreateMutable();
   
   CGPathMoveToPoint(keyPath, nil, minX, minY);
   CGPathAddLineToPoint(keyPath, nil, minX - 8, minY - 8);
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMinX(alternateKeysFrame) - 4, minY - 8);
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMinX(alternateKeysFrame) - 4, CGRectGetMinY(alternateKeysFrame));
   CGPathAddLineToPoint(keyPath, nil, maxX + 8, CGRectGetMinY(alternateKeysFrame));
   CGPathAddLineToPoint(keyPath, nil, maxX + 8, minY - 8);
   
   CGPathAddLineToPoint(keyPath, nil, maxX + 8, minY - 8);
   CGPathAddLineToPoint(keyPath, nil, maxX, minY);
   CGPathAddLineToPoint(keyPath, nil, maxX, maxY);
   CGPathAddLineToPoint(keyPath, nil, minX, maxY);
   CGPathCloseSubpath(keyPath);
   
   return keyPath;
}

CGPathRef _rightAlternateKeysBackgroundPath(CGRect bottomFrame, CGRect alternateKeysFrame)
{
   CGFloat minX = CGRectGetMinX(bottomFrame);
   CGFloat minY = CGRectGetMinY(bottomFrame);
   CGFloat maxX = CGRectGetMaxX(bottomFrame);
   CGFloat maxY = CGRectGetMaxY(bottomFrame);
   
   CGMutablePathRef keyPath = CGPathCreateMutable();
   
   CGPathMoveToPoint(keyPath, nil, minX, minY);
   CGPathAddLineToPoint(keyPath, nil, minX - 8, minY - 8);
   CGPathAddLineToPoint(keyPath, nil, minX - 8, minY - 8);
   CGPathAddLineToPoint(keyPath, nil, minX - 8, CGRectGetMinY(alternateKeysFrame));
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMaxX(alternateKeysFrame) + 4, CGRectGetMinY(alternateKeysFrame));
   CGPathAddLineToPoint(keyPath, nil, CGRectGetMaxX(alternateKeysFrame) + 4, minY - 8);
   
   CGPathAddLineToPoint(keyPath, nil, maxX + 8, minY - 8);
   CGPathAddLineToPoint(keyPath, nil, maxX, minY);
   CGPathAddLineToPoint(keyPath, nil, maxX, maxY);
   CGPathAddLineToPoint(keyPath, nil, minX, maxY);
   CGPathCloseSubpath(keyPath);
   
   return keyPath;
}

CGPathRef _alternateKeysBackgroundPath(CGRect bottomFrame, CGRect alternateKeysFrame, AltKeysViewDirection direction)
{
   CGPathRef backgroundPath = nil;
   switch (direction)
   {
      case AltKeysViewDirectionCenter:
         backgroundPath = _centerAlternateKeysBackgroundPath(bottomFrame, alternateKeysFrame);
         break;
         
      case AltKeysViewDirectionLeft:
         backgroundPath = _leftAlternateKeysBackgroundPath(bottomFrame, alternateKeysFrame);
         break;
         
      case AltKeysViewDirectionRight:
         backgroundPath = _rightAlternateKeysBackgroundPath(bottomFrame, alternateKeysFrame);
         break;
         
      default:
         break;
   }

   return backgroundPath;
}

@interface AlternateKeysView ()
@property (nonatomic) CAShapeLayer* alternateKeysViewBackgroundLayer;
@property (nonatomic) CALayer* shadowContainerLayer;
@property (nonatomic) NSArray* altCharacters;
@property (nonatomic) KeyViewCollection* alternateKeysCollection;
@property (nonatomic) AltKeysViewDirection direction;
@end

@implementation AlternateKeysView

#pragma mark - Init
- (instancetype)initWithKeyView:(KeyView*)keyView
{
   if (self = [super initWithFrame:keyView.bounds])
   {
      [self setupAlternateKeysViewBackgroundLayer];
      [self setupShadowLayer];
      
      [self.layer addSublayer:self.shadowContainerLayer];
      [self.shadowContainerLayer addSublayer:self.alternateKeysViewBackgroundLayer];
      
      self.direction = _directionForCharacter(keyView.displayText);
      [self setupAlternateCharactersCollectionWithCharacter:keyView.displayText];
   }
   return self;
}

#pragma mark - Class Init
+ (instancetype)viewWithKeyView:(KeyView*)keyView
{
   return [[self alloc] initWithKeyView:keyView];
}

#pragma mark - Setup
- (void)setupAlternateKeysViewBackgroundLayer
{
   self.alternateKeysViewBackgroundLayer = [CAShapeLayer layer];
   
   self.alternateKeysViewBackgroundLayer.lineWidth = 2.f;
   self.alternateKeysViewBackgroundLayer.strokeColor =  [UIColor colorWithWhite:.2 alpha:1].CGColor;
   self.alternateKeysViewBackgroundLayer.fillColor = [UIColor colorWithWhite:1 alpha:.9].CGColor;
   
   self.alternateKeysViewBackgroundLayer.shadowOpacity = .1f;
   self.alternateKeysViewBackgroundLayer.shadowRadius = 1.5f;
   self.alternateKeysViewBackgroundLayer.shadowOffset = CGSizeMake(0, .5f);
   
   [self.alternateKeysViewBackgroundLayer disableAnimations];
   self.alternateKeysViewBackgroundLayer.backgroundColor = [UIColor redColor].CGColor;
}

- (void)setupShadowLayer
{
   self.shadowContainerLayer = [CALayer layer];
   self.shadowContainerLayer.shadowOpacity = .25f;
   self.shadowContainerLayer.shadowRadius = 1.5f;
   self.shadowContainerLayer.shadowOffset = CGSizeMake(0, .5f);
}

- (void)setupAlternateCharactersCollectionWithCharacter:(NSString*)character
{
   self.altCharacters = _altCharactersArray(self.direction, character);
   self.alternateKeysCollection = [KeyViewCollection collectionWithCharacterArray:self.altCharacters];
   
   [self addSubview:self.alternateKeysCollection];
}

#pragma mark - Private
- (void)updateAlternateKeysBackgroundPath
{
   CGFloat width = CGRectGetWidth(self.frame) * self.altCharacters.count;
   CGFloat height = CGRectGetHeight(self.frame);
   
   CGFloat x = 0;
   switch (self.direction)
   {
      case AltKeysViewDirectionCenter:
         x = width * -.5 + CGRectGetWidth(self.frame)*.5;
         break;
         
      case AltKeysViewDirectionLeft:
         x = -width + CGRectGetWidth(self.frame);
         break;
         
      default:
         break;
   }
   
   CGRect keyViewFrame = CGRectInset(self.bounds, 4, 8);
   CGRect alternateKeysBackgroundFrame = CGRectMake(x, -54, width, height);
   
   [self.alternateKeysCollection updateFrame:alternateKeysBackgroundFrame];
   
   CGPathRef backgroundPath = _alternateKeysBackgroundPath(keyViewFrame, alternateKeysBackgroundFrame, self.direction);
   self.alternateKeysViewBackgroundLayer.path = backgroundPath;
   CGPathRelease(backgroundPath);
}

#pragma mark - Public
- (void)updateFrame:(CGRect)frame
{
   self.frame = frame;
   [self updateAlternateKeysBackgroundPath];
}

- (void)updateForShiftMode:(KeyboardShiftMode)mode
{
   for (LetterSymbolKeyView* keyView in self.alternateKeysCollection.keyViews)
   {
      [keyView updateForShiftMode:mode];
   }
}

@end
