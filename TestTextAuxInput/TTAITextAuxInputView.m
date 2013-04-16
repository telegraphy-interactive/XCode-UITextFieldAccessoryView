//
//  FltTiTextAuxInputView.m
//  myFltTime
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Telegraphy Interactive. All rights reserved.
//

#import "TTAITextAuxInputView.h"

@interface TTAITextAuxInputView ()
@property (copy) UITextField * textBaby;
@property (copy) UIView *doneView;
@end

@implementation TTAITextAuxInputView

@synthesize textBaby;

+ (void)decorate:(UITextField *)textField {
    TTAITextAuxInputView *aiv = [TTAITextAuxInputView alloc];
    [aiv setTextBaby:textField];
    [textField setInputAccessoryView:[aiv getDoneView]];
}

// private

- (IBAction)resignTextBaby:(id)sender {
    [textBaby resignFirstResponder];
}

- (UIView *)getDoneView {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,100,44)];
    [toolbar setBarStyle:UIBarStyleBlack];
        
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(resignTextBaby:)];
    [toolbar setItems:[NSArray arrayWithObject:doneButton] animated:false];
    return toolbar;
}

@end
