//
//  KTAreaPickerView.m
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTAreaPickerView.h"
#import "KTAreaPickerModel.h"
#import "KTProvinceModel.h"
#import "KTCityModel.h"
#import "KTDistrictModel.h"
#import "KTAreaMaskView.h"

#import <MJExtension.h>

@interface KTAreaPickerView()<UIPickerViewDelegate,UIPickerViewDataSource,KTAreaMaskViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
- (IBAction)cancelBtnAction:(UIButton *)sender;
- (IBAction)finishBtnAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activitySpinner;

@property (nonatomic, strong) KTProvinceModel *provinceModel;
@property (nonatomic, strong) KTCityModel     *cityModel;
@property (nonatomic, strong) KTDistrictModel *disctrictModel;
@property (nonatomic, strong) KTAreaMaskView  *maskView;
@property (nonatomic, assign) float           compontentWidth;

@property (nonatomic) BOOL isShown;

@property (nonatomic, strong) NSString *tempProvince;
@property (nonatomic, strong) NSString *tempCity;
@property (nonatomic, strong) NSString *tempDistrict;


@end
@implementation KTAreaPickerView

#pragma mark - public methods
- (instancetype)initInSuperView:(UIView *)superView WithPickerType:(KTPickerViewType)pickerType {
    self = [super init];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"KTAreaPicker" owner:self options:nil] firstObject];
        if (![KTAreaPickerModel sharedModel].provinceList) {
            [self analysisJSON:@"area.json" finishBlock:^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_activitySpinner stopAnimating];
                    [_pickerView reloadAllComponents];
                    [self initPickerPosition:self.tempProvince City:self.tempCity district:self.tempDistrict];
                    _pickerView.userInteractionEnabled = YES;
                });
            }];
        }
        [superView addSubview:self.maskView];
        [self.maskView addSubview:self];
        [self setupViews:pickerType];
    }
    return self;
}


- (void)initPickerPosition:(NSString *)province
                      City:(NSString *)city
                  district:(NSString *)district {
    [self showPicker:YES];
    if ([KTAreaPickerModel sharedModel].provinceList) {
        [_pickerView selectRow: [self locatePickerWith:province inComponent:PROVINCE_COMPONENT]
                   inComponent: PROVINCE_COMPONENT animated: NO];
        [_pickerView selectRow: [self locatePickerWith:city inComponent:CITY_COMPONENT]
                   inComponent: CITY_COMPONENT animated: NO];
        [_pickerView selectRow: [self locatePickerWith:district inComponent:DISTRICT_COMPONENT]
                   inComponent: DISTRICT_COMPONENT animated: NO];
    } else {
        self.tempProvince = province;
        self.tempCity     = city;
        self.tempDistrict = district;
    }
    
}

- (void)showPicker:(BOOL)show {
    //appear
    if (!self.isShown && show) {
        [UIView animateWithDuration:0.3 animations:^{
            _maskView.hidden = NO;
            _maskView.maskView.alpha = 0.2;
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -252.0f);
            self.transform = transform;
        } completion:^(BOOL finished) {
            self.isShown = YES;
        }];
    }
    //disappear
    if (self.isShown && !show) {
        [UIView animateWithDuration:0.3 animations:^{
            _maskView.maskView.alpha = 0;
            CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 252.0f);
            self.transform = transform;
        } completion:^(BOOL finished) {
            _maskView.hidden = YES;
            self.isShown = NO;
            if ([self.delegate respondsToSelector:@selector(KTAreaPickerDidDisappear)]) {
                [self.delegate KTAreaPickerDidDisappear];
            }
        }];
    }
    
}

#pragma mark - private methods
- (void)setupViews:(KTPickerViewType)pickerType {
    self.pickerView.delegate = self;
    switch (pickerType) {
        case PickerTypeNormal:
            self.frame = CGRectMake(0, _maskView.bounds.size.height, KT_UISCREEN_Width, 252);
            break;
        case PickerTypeNavigationBar:
            _maskView.frame = CGRectMake(0, 64, KT_UISCREEN_Width, KT_UISCREEN_HEIGHT-64);
            self.frame = CGRectMake(0, _maskView.bounds.size.height, KT_UISCREEN_Width, 252);
            break;
        case PickerTypeNavigationAndAutoAdjusts:
            self.frame = CGRectMake(0, _maskView.bounds.size.height-64, KT_UISCREEN_Width, 252);
            break;
        default:
            break;
    }
    
}


- (void)analysisJSON:(NSString *)jsonName finishBlock:(void(^)(void))finishBolck {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        [_activitySpinner startAnimating];
        _pickerView.userInteractionEnabled = NO;
        NSString *path = [[NSBundle mainBundle] pathForResource:jsonName ofType:nil];
        NSData *data   = [NSData dataWithContentsOfFile:path];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingMutableContainers
                                                                   error:nil];
        [KTAreaPickerModel sharedModel].provinceList = [KTProvinceModel objectArrayWithKeyValuesArray:jsonDict[@"citylist"]];
        if ([KTAreaPickerModel sharedModel].provinceList) {
            finishBolck();
        }
    });
}


- (NSInteger)locatePickerWith:(NSString *)itemName inComponent:(NSInteger)compontent {
    if (!itemName || itemName.length < 2) {
        return 0;
    }
    NSString *cuttedItemName = compontent == DISTRICT_COMPONENT ? itemName : [itemName substringToIndex:2];
    switch (compontent) {
        case PROVINCE_COMPONENT: {
            for (KTProvinceModel *provinceModel in [KTAreaPickerModel sharedModel].provinceList) {
                if ([[provinceModel.shortName substringToIndex:2] isEqualToString:cuttedItemName]) {
                    self.provinceModel = provinceModel;
                    [_pickerView reloadAllComponents];
                    return [[KTAreaPickerModel sharedModel].provinceList indexOfObject:provinceModel];
                }
            }
        }
            break;
        case CITY_COMPONENT: {
            for (KTCityModel *cityModel in self.provinceModel.list) {
                if ([[cityModel.shortName substringToIndex:2] isEqualToString:cuttedItemName]) {
                    self.cityModel = cityModel;
                    [_pickerView reloadAllComponents];
                    return [self.provinceModel.list indexOfObject:cityModel];
                }
            }
        }
            break;
        case DISTRICT_COMPONENT: {
            for (KTDistrictModel *districtModel in self.cityModel.list) {
                if ([districtModel.name  isEqualToString:cuttedItemName]) {
                    self.disctrictModel = districtModel;
                    return [self.cityModel.list indexOfObject:districtModel];
                }
            }
        }
            break;
        default:
            return 0;
            break;
    }
    return 0;
}

- (UILabel *)setupPickerDisplayLabel {
    UILabel *displayLabel;
    displayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.compontentWidth, 30)] ;
    displayLabel.textAlignment = NSTextAlignmentCenter;
    displayLabel.font = [UIFont systemFontOfSize:15];
    displayLabel.backgroundColor = [UIColor clearColor];
    return  displayLabel;
}

#pragma mark - KTMaskViewDelegate
- (void)KTmaskViewDidTapped {
    [self showPicker:NO];
}


#pragma mark - UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([KTAreaPickerModel sharedModel].provinceList) {
        switch (component) {
            case PROVINCE_COMPONENT:
                return [KTAreaPickerModel sharedModel].provinceList.count;
                break;
            case CITY_COMPONENT:
                return [self.provinceModel.list count];
                break;
            case DISTRICT_COMPONENT:
                return [self.cityModel.list count];
                break;
            default:
                return 0;
                break;
        }
    } else {
        return 1;
    }
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case PROVINCE_COMPONENT: {
            self.provinceModel = [KTAreaPickerModel sharedModel].provinceList[row];
            self.cityModel     = self.provinceModel.list[0];
            self.disctrictModel = self.cityModel.list[0];
            [pickerView reloadComponent:CITY_COMPONENT];
            [pickerView reloadComponent:DISTRICT_COMPONENT];
            [pickerView selectRow:0 inComponent:CITY_COMPONENT animated:YES];
            [pickerView selectRow:0 inComponent:DISTRICT_COMPONENT animated:YES];
        }
            break;
        case CITY_COMPONENT: {
            self.cityModel = self.provinceModel.list[row];
            self.disctrictModel = self.cityModel.list[0];
            [pickerView reloadComponent:DISTRICT_COMPONENT];
            [pickerView selectRow:0 inComponent:DISTRICT_COMPONENT animated:YES];
        }
            break;
        case DISTRICT_COMPONENT:
            self.disctrictModel = self.cityModel.list[row];
        default:
            break;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.compontentWidth;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *displayView = nil;
    displayView = [self setupPickerDisplayLabel];
    
    switch (component) {
        case PROVINCE_COMPONENT: {
            displayView.text = ((KTProvinceModel *)[KTAreaPickerModel sharedModel].provinceList[row]).shortName;
            displayView.frame = CGRectMake(20, 0, self.compontentWidth, 30);
        }
            break;
        case CITY_COMPONENT: {
            KTCityModel *tempCity = self.provinceModel.list[row];
            displayView.text = tempCity.shortName;
        }
            break;
        case DISTRICT_COMPONENT: {
            KTDistrictModel *tempDistrict = self.cityModel.list[row];
            displayView.text = tempDistrict.name;
        }
            break;
        default:
            break;
    }
    if (![KTAreaPickerModel sharedModel].provinceList) {
        displayView.text = @"加载中...";
    }
    return displayView;
}

#pragma mark - Action Response
- (IBAction)cancelBtnAction:(UIButton *)sender {
    [self showPicker:NO];
}

- (IBAction)finishBtnAction:(UIButton *)sender {
    [self showPicker:NO];
    if ([self.delegate respondsToSelector:@selector(KTAreaPickerDidFinished:)]) {
        [self.delegate KTAreaPickerDidFinished:[KTAreaSelecedModel bindDataWithProvince:self.provinceModel City:self.cityModel District:self.disctrictModel]];
    }
}


#pragma mark -setter / getter
- (KTAreaMaskView *)maskView {
    if (!_maskView) {
        _maskView = [[KTAreaMaskView alloc] initWithFrame:CGRectMake(0, 0, KT_UISCREEN_Width, KT_UISCREEN_HEIGHT)];
        _maskView.delegate = self;
    }
    return _maskView;
}

- (KTProvinceModel *)provinceModel {
    if(!_provinceModel) {
        _provinceModel = [[KTProvinceModel alloc] init];
        _provinceModel = [KTAreaPickerModel sharedModel].provinceList[0];
    }
    return _provinceModel;
}
- (KTCityModel *)cityModel {
    if (!_cityModel) {
        _cityModel = [[KTCityModel alloc] init];
        _cityModel = self.provinceModel.list[0];
    }
    return  _cityModel;
}
- (KTDistrictModel *)disctrictModel {
    if (!_disctrictModel) {
        _disctrictModel = [[KTDistrictModel alloc] init];
        _disctrictModel = self.cityModel.list[0];
    }
    return  _disctrictModel;
}

- (float)compontentWidth {
    return (_pickerView.bounds.size.width - 20)/3;
}

- (NSString *)tempProvince {
    if (!_tempProvince) {
        _tempProvince = [[NSString alloc] init];
    }
    return _tempProvince;
}
- (NSString *)tempCity {
    if (!_tempCity) {
        _tempCity = [[NSString alloc] init];
    }
    return _tempCity;
}
- (NSString *)tempDistrict {
    if (!_tempDistrict) {
        _tempDistrict = [[NSString alloc] init];
    }
    return _tempDistrict;
}

@end

