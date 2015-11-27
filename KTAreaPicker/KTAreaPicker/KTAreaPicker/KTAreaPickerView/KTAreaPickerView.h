//
//  KTAreaPickerView.h
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTAreaSelecedModel.h"
#import "KTAreaPickerMacro.h"
@protocol KTAreaPickerDelegate<NSObject>
@required
- (void)KTAreaPickerDidFinished:(KTAreaSelecedModel *)selectModel;
@optional
- (void)KTAreaPickerDidDisappear;
@end;

@interface KTAreaPickerView : UIView
@property (nonatomic, weak) id <KTAreaPickerDelegate> delegate;

- (instancetype)initInSuperView:(UIView *)superView
                 WithPickerType:(KTPickerViewType)pickerType;

- (void)initPickerPosition:(NSString *)province
                      City:(NSString *)city
                  district:(NSString *)district;

- (void)showPicker:(BOOL)show;
@end
