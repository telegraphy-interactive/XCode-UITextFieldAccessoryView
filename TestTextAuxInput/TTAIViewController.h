//
//  TTAIViewController.h
//  TestTextAuxInput
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import <UIKit/UIKit.h>
#import "TTAIModel.h"

@interface TTAIViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *hours;
@property (weak, nonatomic) IBOutlet UITextField *night;
@property (weak, nonatomic) IBOutlet UITextField *startDateTime;
@property (weak, nonatomic) IBOutlet UITextField *endDateTime;

@property (weak, nonatomic) TTAIModel *model;

- (void)syncDisplayForModelState;

- (IBAction)hoursWasEdited:(id)sender;
- (IBAction)nightWasEdited:(id)sender;
- (IBAction)startedWasEdited:(id)sender;
- (IBAction)endedWasEdited:(id)sender;

@end
