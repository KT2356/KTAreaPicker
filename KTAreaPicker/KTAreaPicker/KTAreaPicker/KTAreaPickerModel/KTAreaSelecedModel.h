//
//  KTAreaSelecedModel.h
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTProvinceModel.h"
#import "KTCityModel.h"
#import "KTDistrictModel.h"

@interface KTAreaSelecedModel : NSObject
@property (nonatomic, strong) KTProvinceModel *provinceModel;
@property (nonatomic, strong) KTCityModel     *cityModel;
@property (nonatomic, strong) KTDistrictModel *districtModel;
@property (nonatomic, strong) NSString        *displayString;

+ (instancetype)bindDataWithProvince:(KTProvinceModel *)province
                                City:(KTCityModel *)city
                            District:(KTDistrictModel *)district;
@end
