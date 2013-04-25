//
//  TTAIAppDelegate.h
//  TestTextAuxInput
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import <UIKit/UIKit.h>

#include "TTAIModel.h"

@interface TTAIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) TTAIModel *model;

@end
