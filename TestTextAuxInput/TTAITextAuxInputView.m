//
//  TTAITextAuxInputView.m
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import "TTAITextAuxInputView.h"

@interface TTAITextAuxInputView ()

@property (nonatomic, strong) UIScrollView *scrollView;

@end


@implementation TTAITextAuxInputView

@synthesize txtActiveField;

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWasShown:)
                                                     name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillBeHidden:)
                                                     name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

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

- (void)keyboardWasShown:(NSNotification*)aNotification {
    if (self.txtActiveField) {
        UIView *parent = self.txtActiveField.superview;
        if ([parent isKindOfClass:[UIScrollView class]]) {
            self.scrollView = (UIScrollView *)parent;
            NSDictionary* info = [aNotification userInfo];
            CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
            //printf("keyboard height %f\n", kbSize.height);
            UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
            self.scrollView.contentInset = contentInsets;
            self.scrollView.scrollIndicatorInsets = contentInsets;
            
            // If active text field is hidden by keyboard, scroll it so it's visible
            // Your application might not need or want this behavior.
            CGRect aRect = self.scrollView.frame;
            //printf("scrollView height %f\n", aRect.size.height);
            //printf("txtActiveField origin.y %f\n", txtActiveField.frame.origin.y);
            aRect.size.height -= kbSize.height;
            aRect.size.height -= txtActiveField.frame.size.height;
            //printf("aRect height %f\n", aRect.size.height);
            if (!CGRectContainsPoint(aRect, txtActiveField.frame.origin) ) {
                CGPoint scrollPoint = CGPointMake(0.0, txtActiveField.frame.origin.y - aRect.size.height);
                //printf("scrollPoint.y %f\n", scrollPoint.y);
                [self.scrollView setContentOffset:scrollPoint animated:YES];
            }
        }
    }
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    if (self.scrollView) {
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        self.scrollView.contentInset = contentInsets;
        self.scrollView.scrollIndicatorInsets = contentInsets;
        self.scrollView = nil;
    }
}

-(void)textFieldDidBeginEditing:(UITextField*)textField {
    self.txtActiveField = textField;
}

-(void)textFieldDidEndEditing:(UITextField*)textField {
    self.txtActiveField = nil;
}

@end
