//
//  KTAreaPickerModel.m
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTAreaPickerModel.h"
#import "MJExtension.h"
#import "KTProvinceModel.h"

@implementation KTAreaPickerModel
MJCodingImplementation

#pragma mark - public functions
+ (instancetype)sharedModel {
    static KTAreaPickerModel *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[KTAreaPickerModel alloc] init];
    });
    return model;
}

+ (NSDictionary *)objectClassInArray {
    return @{@"provinceList" : @"KTProvinceModel"};
}

@end
