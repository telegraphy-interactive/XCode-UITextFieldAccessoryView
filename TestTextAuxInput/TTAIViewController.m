//
//  TTAIViewController.m
//  TestTextAuxInput
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. All rights reserved.
//

#import "TTAIViewController.h"
#import "TTAITextAuxInputView.h"

@interface TTAIViewController ()

@end

@implementation TTAIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    // will crash hours input on done press
    [TTAITextAuxInputView decorate:self.hours];
    // on night input, will print "Hey" on done press
    [self.night setInputAccessoryView:[self getDoneView:self.night]];
    // will crash imc on done press
    [self.imc setInputAccessoryView:[self getIAView:self.imc]];
}

- (IBAction)textFieldDone:(id)sender {
    puts("Hey");
}

- (UIView *)getDoneView: (UITextField *)target {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,100,44)];
    [toolbar setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(textFieldDone:)];
    [toolbar setItems:[NSArray arrayWithObject:doneButton] animated:false];
    return toolbar;
}

- (UIView *)getIAView: (UITextField *)target {
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,100,44)];
    [toolbar setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:target action:@selector(resignFirstResponder:)];
    [toolbar setItems:[NSArray arrayWithObject:doneButton] animated:false];
    return toolbar;
}


- (void)viewDidUnload {
    [self setHours:nil];
    [self setNight:nil];
    [self setImc:nil];
    [super viewDidUnload];
}
@end
