//
//  TTAITextAuxInputView.m
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import "TTAITextAuxInputView.h"

@interface TTAITextAuxInputView ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (atomic, strong) NSString *origValue;

@end


@implementation TTAITextAuxInputView

@synthesize txtActiveField;

/*
 Adds self as observer to keyboard show and hide events in order to scroll the text field
 into view above the keyboard when the keyboard would otherwise hide it.
 Troublesome that the observation is global, called whether or not the keyboard edits a
 text field decorated by self.  Did not find another method that had access to
 the geometry of the keyboard.
 */
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

- (void)reset {
    [self.txtActiveField setText:self.origValue];
}

- (void)cancel {
    [self reset];
    [self done];
}

- (void)decorate:(UITextField *)textField {
    textField.delegate = self;
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,100,44)];
    [toolbar setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel                                                                 target:self
                                                                                  action:@selector(cancel)];
    UIBarButtonItem *spaceItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIBarButtonItem *resetButton = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemUndo
                                                                                 target:self
                                                                                 action:@selector(reset)];
    UIBarButtonItem *spaceItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc ]initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(done)];
    [toolbar setItems:[NSArray arrayWithObjects:cancelButton, spaceItem1, resetButton, spaceItem2, doneButton, nil] animated:false];
    
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
    self.origValue = textField.text;
}

-(void)textFieldDidEndEditing:(UITextField*)textField {
    self.txtActiveField = nil;
}

@end
