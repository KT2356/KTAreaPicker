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
    if ([province.shortName isEqualToString:city.shortName]) {
        cityPisplayName = @"";
    } else {
        cityPisplayName = [city.shortName stringByAppendingString:@"-"];
    }
    
    NSString *outSting = [NSString stringWithFormat:@"%@-%@%@  >",province.shortName,cityPisplayName,district.name];
    
    selectModel.provinceModel = province;
    selectModel.cityModel     = city;
    selectModel.districtModel = district;
    selectModel.displayString = outSting;
    
    return selectModel;
}
@end
