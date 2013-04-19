//
//  FltTiTextDatePickerView.m
//
//  Created by Doug Lovell on 4/19/13.
//  Copyright (c) 2013 Telegraphy Interactive. All rights reserved.
//

#import "TTAITextDatePickerView.h"

@interface TTAITextDatePickerView ()

@property (nonatomic, strong) UITextField* txtActiveField;
@property (nonatomic, strong) UIDatePicker* dateTimePicker;
@property (nonatomic, strong) NSDateFormatter* dateFormatter;

@end


@implementation TTAITextDatePickerView

@synthesize txtActiveField;

- (id)init
{
    self = [super init];
    if (self) {
        self.dateTimePicker = [[UIDatePicker alloc ]initWithFrame:CGRectMake(0,0,100,44)];
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [self.dateFormatter setDateStyle:NSDateFormatterShortStyle];
        [self.dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    }
    return self;
}

- (void)done {
    [self.txtActiveField resignFirstResponder];
}

- (void)dateChanged {
    NSString *dateTimeText = [self.dateFormatter stringFromDate:self.dateTimePicker.date];
    [self.txtActiveField setText:dateTimeText];
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
    
    [self.dateTimePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    
    [textField setInputView:self.dateTimePicker];
}

-(void)textFieldDidBeginEditing:(UITextField*)textField {
    self.txtActiveField = textField;
    NSString* stringValue = [textField text];
    if (0 < [stringValue length]) {
         NSDate *curDate = [self.dateFormatter dateFromString:stringValue];
        [self.dateTimePicker setDate:curDate];
    }
}

@end
