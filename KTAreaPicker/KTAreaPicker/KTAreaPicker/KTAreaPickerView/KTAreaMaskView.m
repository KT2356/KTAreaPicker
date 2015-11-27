//
//  KTAreaMaskView.m
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "KTAreaMaskView.h"
#import "KTAreaPickerMacro.h"

@interface KTAreaMaskView()

@end;

@implementation KTAreaMaskView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.maskView];
    }
    return self;
}

#pragma mark - delegate trigger
- (void)areaPickerDidCancel {
    [self.delegate KTmaskViewDidTapped];
}

#pragma mark - setter / getter
- (UIView *)maskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _maskView.backgroundColor = [UIColor blackColor];
        _maskView.alpha = 0.0;
        UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc]
                                          initWithTarget:self
                                          action:@selector(areaPickerDidCancel)];
        _maskView.userInteractionEnabled = YES;
        [_maskView addGestureRecognizer:tapped];
    }
    return _maskView;
}


@end
