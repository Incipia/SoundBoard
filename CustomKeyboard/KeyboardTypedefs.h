//
//  KeyboardTypedefs.h
//  SoundBoard
//
//  Created by Klein, Greg on 1/24/15.
//  Copyright (c) 2015 Pure Virtual Studios, LLC. All rights reserved.
//

#ifndef SoundBoard_KeyboardTypedefs_h
#define SoundBoard_KeyboardTypedefs_h

typedef NS_ENUM(NSUInteger, KeyboardFunctionalKeyType)
{
   KeyboardShiftKey,
   KeyboardNumbersKey,
   KeyboardNextKeyboardKey,
   KeyboardDeleteKey,
   KeyboardReturnKey,
   KeyboardSpacebarKey
};

typedef NS_ENUM(NSUInteger, KeyboardMode)
{
   KeyboardModeLetters = 1,
   KeyboardModeNumbers,
   KeyboardModeSymbols
};

typedef NS_ENUM(NSUInteger, KeyboardRow)
{
   KeyboardRowTop,
   KeyboardRowMiddle,
   KeyboardRowBottom
};

#endif
