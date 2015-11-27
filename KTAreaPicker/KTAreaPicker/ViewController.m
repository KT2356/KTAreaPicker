//
//  ViewController.m
//  KTAreaPicker
//
//  Created by KT on 15/11/25.
//  Copyright © 2015年 KT. All rights reserved.
//

#import "ViewController.h"
#import "KTAreaPickerView.h"
#import "KTAreaSelecedModel.h"

@interface ViewController ()<KTAreaPickerDelegate>//step 1
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) KTAreaPickerView *ktPickerView;
- (IBAction)buttonAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// delegate step 3
- (void)KTAreaPickerDidFinished:(KTAreaSelecedModel *)selectModel {
    self.label.text = selectModel.displayString;
}

- (IBAction)initAction:(UIButton *)sender {
    [self.ktPickerView showPicker:YES];
}

- (IBAction)buttonAction:(UIButton *)sender {
    [self.ktPickerView initPickerPosition:@"山西" City:@"太原" district:@"古交市"];
}

//init step 2
- (KTAreaPickerView *)ktPickerView {
    if (!_ktPickerView) {
        _ktPickerView = [[KTAreaPickerView alloc] initInSuperView:self.view WithPickerType:PickerTypeNormal];
        _ktPickerView.delegate = self;
    }
    return _ktPickerView;
}
@end
