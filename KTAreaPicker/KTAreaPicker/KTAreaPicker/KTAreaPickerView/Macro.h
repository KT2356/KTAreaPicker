//
//  Macro.h
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

#define KT_UISCREEN_Width         [UIScreen mainScreen].bounds.size.width
#define KT_UISCREEN_HEIGHT        [UIScreen mainScreen].bounds.size.height

typedef enum : NSUInteger {
    PROVINCE_COMPONENT,
    CITY_COMPONENT,
    DISTRICT_COMPONENT,
} PickerCompontent;

#endif
