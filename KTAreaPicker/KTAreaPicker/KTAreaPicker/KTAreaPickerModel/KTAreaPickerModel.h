//
//  KTAreaPickerModel.h
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTAreaPickerModel : NSObject
@property (nonatomic, strong) NSArray *provinceList;
+ (instancetype)sharedModel;
@end
