//
//  TTAITextAuxInputView.h
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

/*
 It bothers me as an old Java guy that I have to expose the txtActiveField instance
 variable and the reset method in order to use them from the subclass.  There are 
 posts on this topic at StackOverflow
 http://stackoverflow.com/questions/3725857/protected-methods-in-objective-c
 with some pissy comments.  Sensitive topic, apparently.  The "solution" there looks
 more bothersome than the problem; so, here you are.  Treat them as protected.  
 Or not.  As you like.
 */

#import <Foundation/Foundation.h>

@interface TTAITextAuxInputView : NSObject <UITextFieldDelegate>

@property (nonatomic, strong) UITextField* txtActiveField;

/*
 Add cancel, undo, done button impementations as textField auxilliary input view.
 Side effect is that this becomes the delegate of the text field.
 */
- (void)decorate:(UITextField *)textField;

// set text field content to value held prior to edit
- (void)reset;

@end
