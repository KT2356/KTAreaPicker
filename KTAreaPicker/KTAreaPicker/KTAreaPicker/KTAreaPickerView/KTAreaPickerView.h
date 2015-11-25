//
//  KTAreaPickerView.h
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KTAreaSelecedModel.h"
@protocol KTAreaPickerDelegate<NSObject>
@required
- (void)KTAreaPickerDidFinished:(KTAreaSelecedModel *)selectModel;
@end;

@interface KTAreaPickerView : UIView
@property (nonatomic, weak) id <KTAreaPickerDelegate> delegate;


- (instancetype)initInSuperView:(UIView *)superView;
- (void)initPickerPosition:(NSString *)province
                      City:(NSString *)city
                  district:(NSString *)district;
- (void)showPicker:(BOOL)show;
@end
