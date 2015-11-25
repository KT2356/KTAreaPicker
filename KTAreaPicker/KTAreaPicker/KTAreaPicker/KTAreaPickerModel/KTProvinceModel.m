//
//  KTProvinceModel.m
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTProvinceModel.h"
#import "KTCityModel.h"
#import "MJExtension.h"

@implementation KTProvinceModel
MJCodingImplementation;

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{ @"ID"       : @"id",
              @"name"     : @"areaName",
              @"parentID" : @"parentId"
             };
}

+ (NSDictionary *)objectClassInArray {
    return @{@"list" : @"KTCityModel"};
}
@end


