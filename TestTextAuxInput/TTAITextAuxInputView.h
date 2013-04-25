//
//  TTAITextAuxInputView.h
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import <Foundation/Foundation.h>

@interface TTAITextAuxInputView : NSObject <UITextFieldDelegate>

@property (nonatomic, strong) UITextField* txtActiveField;

- (void)decorate:(UITextField *)textField;

@end
