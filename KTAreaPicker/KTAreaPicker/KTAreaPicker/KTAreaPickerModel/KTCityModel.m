//
//  KTCityModel.m
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTCityModel.h"
#import "KTDistrictModel.h"
#import "MJExtension.h"

@implementation KTCityModel
MJCodingImplementation;

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{ @"ID"       : @"id",
              @"name"     : @"areaName",
              @"parentID" : @"parentId"
              };
}

+ (NSDictionary *)objectClassInArray {
    return @{@"list" : @"KTDistrictModel"};
}
@end
