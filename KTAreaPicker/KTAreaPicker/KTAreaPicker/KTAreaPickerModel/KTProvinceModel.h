//
//  KTProvinceModel.h
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KTProvinceModel : NSObject
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *parentID;
@property (nonatomic, strong) NSArray  *list;
@property (nonatomic, strong) NSString *shortName;
@end
