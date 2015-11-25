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

@interface ViewController ()<KTAreaPickerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic, strong) KTAreaPickerView *ktPickerView;
- (IBAction)buttonAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ktPickerView showPicker:NO];
}


- (void)KTAreaPickerDidFinished:(KTAreaSelecedModel *)selectModel {
    self.label.text = selectModel.displayString;
}

- (IBAction)buttonAction:(UIButton *)sender {
    [self.ktPickerView initPickerPosition:@"山西" City:@"太原" district:@"古交市"];
    [self.ktPickerView showPicker:YES];
}

- (KTAreaPickerView *)ktPickerView {
    if (!_ktPickerView) {
        _ktPickerView = [[KTAreaPickerView alloc] initInSuperView:self.view];
        _ktPickerView.delegate = self;
    }
    return _ktPickerView;
}
@end
