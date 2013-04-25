//
//  TTAIViewController.m
//  TestTextAuxInput
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import "TTAIViewController.h"
#import "TTAITextAuxInput.h"
#import "TTAITextDatePicker.h"

@interface TTAIViewController ()

@property  (nonatomic, strong) TTAITextAuxInput* decorator;
@property  (nonatomic, strong) TTAITextDatePicker* dateDecorator;
@property  (nonatomic, strong) TTAITextDatePicker* longDateDecorator;

@end

@implementation TTAIViewController

@synthesize model;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
    self.decorator = [[TTAITextAuxInput alloc] init];
    [self.decorator decorate:self.hours];
    [self.decorator decorate:self.night];
    
    self.dateDecorator = [[TTAITextDatePicker alloc] init];
    [self.dateDecorator decorate:self.startDateTime];

    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateStyle:NSDateFormatterFullStyle];
    [myDateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
    self.longDateDecorator = [[TTAITextDatePicker alloc] init];
    [self.longDateDecorator setDateFormatter:myDateFormatter];
    [self.longDateDecorator setDatePickerMode:UIDatePickerModeDate];
    [self.longDateDecorator decorate:self.endDateTime];
}

- (void)viewDidUnload {
    [self setHours:nil];
    [self setNight:nil];
    [self setStartDateTime:nil];
    [self setEndDateTime:nil];
    [self setDecorator:nil];
    [self setDateDecorator:nil];
    [self setLongDateDecorator:nil];
    [super viewDidUnload];
}

- (void)syncDisplayForModelState {
    [self.hours setText:[model.hours stringValue]];
    [self.night setText:[model.night stringValue]];
    [self.startDateTime setText:[[self.dateDecorator dateFormatter] stringFromDate:model.started]];
    [self.endDateTime setText:[[self.longDateDecorator dateFormatter] stringFromDate:model.ended]];
}

- (IBAction)hoursWasEdited:(id)sender {
    [model setHours:[NSNumber numberWithFloat:[[self.hours text] floatValue]]];
}

- (IBAction)nightWasEdited:(id)sender {
    [model setNight:[NSNumber numberWithFloat:[[self.night text] floatValue]]];
}

- (IBAction)startedWasEdited:(id)sender {
    [model setStarted:[[self.dateDecorator dateFormatter] dateFromString:[self.startDateTime text]]];
}

- (IBAction)endedWasEdited:(id)sender {
    [model setEnded:[[self.longDateDecorator dateFormatter] dateFromString:[self.endDateTime text]]];
}

@end
