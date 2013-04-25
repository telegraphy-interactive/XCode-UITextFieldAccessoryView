//
//  TTAIViewController.m
//  TestTextAuxInput
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import "TTAIViewController.h"
#import "TTAITextAuxInputView.h"
#import "TTAITextDatePickerView.h"

@interface TTAIViewController ()

@property  (nonatomic, strong) TTAITextAuxInputView* decorator;
@property  (nonatomic, strong) TTAITextDatePickerView* dateDecorator;

@end

@implementation TTAIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
    self.decorator = [[TTAITextAuxInputView alloc] init];
    [self.decorator decorate:self.hours];
    [self.decorator decorate:self.night];
    
    self.dateDecorator = [[TTAITextDatePickerView alloc] init];
    [self.dateDecorator decorate:self.startDateTime];
    [self.dateDecorator decorate:self.endDateTime];
}

- (void)viewDidUnload {
    [self setHours:nil];
    [self setNight:nil];
    [self setStartDateTime:nil];
    [self setEndDateTime:nil];
    [super viewDidUnload];
}
@end
