//
//  KTAreaSelecedModel.m
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTAreaSelecedModel.h"

@implementation KTAreaSelecedModel

+ (instancetype)bindDataWithProvince:(KTProvinceModel *)province
                                City:(KTCityModel *)city
                            District:(KTDistrictModel *)district
{
    KTAreaSelecedModel *selectModel = [[KTAreaSelecedModel alloc] init];
    
    NSString *cityPisplayName;
    if ([province.name isEqualToString:city.name]) {
        cityPisplayName = @"";
    } else {
        cityPisplayName = [city.name stringByAppendingString:@"-"];
    }
    
    NSString *outSting = [NSString stringWithFormat:@"%@-%@%@  >",province.name,cityPisplayName,district.name];
    
    selectModel.provinceModel = province;
    selectModel.cityModel     = city;
    selectModel.districtModel = district;
    selectModel.displayString = outSting;
    
    return selectModel;
}
@end
