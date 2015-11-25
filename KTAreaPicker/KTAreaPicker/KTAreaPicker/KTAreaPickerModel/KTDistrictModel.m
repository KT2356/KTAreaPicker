//
//  KTDistrictModel.m
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTDistrictModel.h"
#import "MJExtension.h"

@implementation KTDistrictModel
MJCodingImplementation;

+ (NSDictionary *)replacedKeyFromPropertyName {
    return @{ @"ID"       : @"id",
              @"name"     : @"areaName",
              @"parentID" : @"parentId"
              };
}

+ (NSArray *)ignoredPropertyNames {
    return @[@"list"];
}
@end
