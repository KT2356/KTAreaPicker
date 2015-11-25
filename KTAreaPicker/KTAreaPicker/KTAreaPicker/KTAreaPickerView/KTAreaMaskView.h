//
//  KTAreaMaskView.h
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol KTAreaMaskViewDelegate<NSObject>
- (void)KTmaskViewDidTapped;
@end

@interface KTAreaMaskView : UIView
@property (nonatomic, weak) id <KTAreaMaskViewDelegate> delegate;
@property (nonatomic, strong) UIView *maskView;
@end
