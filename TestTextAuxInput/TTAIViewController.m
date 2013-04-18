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

@property  (nonatomic, strong) TTAITextAuxInputView* decorator;

@end

@implementation TTAIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
 
    self.decorator = [[TTAITextAuxInputView alloc] init];
    [self.decorator decorate:self.hours];
    [self.decorator decorate:self.night];
    [self.decorator decorate:self.imc];
}

- (void)viewDidUnload {
    [self setHours:nil];
    [self setNight:nil];
    [self setImc:nil];
    [super viewDidUnload];
}
@end
