# KTAreaPicker
#### Build an areapicker controller with area.json

##### Step 1: import "KTAreaPickerView.h","KTAreaSelecedModel.h" 
        The later file is used to get the information you have seleted.
##### Step 2: Use the "getter" method to initialize the "KTAreaPickerView"
        - (KTAreaPickerView *)ktPickerView {
              if (!_ktPickerView) {
                  _ktPickerView = [[KTAreaPickerView alloc] initInSuperView:self.view];
                  _ktPickerView.delegate = self;
              }
             return _ktPickerView;
        }
##### Step 3: Usage
         [self.ktPickerView showPicker:YES];
###### or you can locate the picker with:
         [self.ktPickerView initPickerPosition:@"山西" City:@"太原" district:@"古交市"];
