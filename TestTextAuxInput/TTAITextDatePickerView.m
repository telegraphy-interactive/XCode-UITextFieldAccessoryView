//
//  TTAITextDatePickerView.m
//
//  Created by Doug Lovell on 4/19/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import "TTAITextDatePickerView.h"

@interface TTAITextDatePickerView ()

@property (nonatomic, strong) UIDatePicker* dateTimePicker;
@property (nonatomic, strong) NSDateFormatter* dateFormatter;

@end


@implementation TTAITextDatePickerView

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

- (void)dateChanged {
    NSString *dateTimeText = [self.dateFormatter stringFromDate:self.dateTimePicker.date];
    [self.txtActiveField setText:dateTimeText];
}

- (void)decorate:(UITextField *)textField {
    [super decorate:textField];
    [self.dateTimePicker addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventValueChanged];
    [textField setInputView:self.dateTimePicker];
}

-(void)textFieldDidBeginEditing:(UITextField*)textField {
    [super textFieldDidBeginEditing:textField];
    NSString* stringValue = [textField text];
    if (0 < [stringValue length]) {
         NSDate *curDate = [self.dateFormatter dateFromString:stringValue];
        [self.dateTimePicker setDate:curDate];
    }
}

@end
