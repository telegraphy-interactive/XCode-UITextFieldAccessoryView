//
//  FltTiTextAuxInputView.m
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import "TTAITextAuxInputView.h"

@interface TTAITextAuxInputView ()

@property (nonatomic, strong) UITextField* txtActiveField;

@end



@implementation TTAITextAuxInputView


@synthesize txtActiveField;

- (void)done {
    [self.txtActiveField resignFirstResponder];
}

- (void)decorate:(UITextField *)textField {
    textField.delegate = self;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,100,44)];
    [toolbar setBarStyle:UIBarStyleBlack];
        
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc ]initWithTitle:@"Done"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(done)];
    [toolbar setItems:[NSArray arrayWithObject:doneButton] animated:false];

    [textField setInputAccessoryView:toolbar];
}

-(void)textFieldDidBeginEditing:(UITextField*)textField {
    self.txtActiveField = textField;
}

@end
