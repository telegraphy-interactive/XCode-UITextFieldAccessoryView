//
//  TTAIModel.h
//  TestTextAuxInput
//
//  Created by Doug Lovell on 4/25/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import <Foundation/Foundation.h>

@interface TTAIModel : NSObject

@property (nonatomic, retain) NSNumber * hours;
@property (nonatomic, retain) NSNumber * night;
@property (nonatomic, retain) NSDate * started;
@property (nonatomic, retain) NSDate * ended;

//- (id)init;
- (id)initFromJSON:(NSDictionary *)json;
- (NSMutableDictionary *)foundify;

@end
