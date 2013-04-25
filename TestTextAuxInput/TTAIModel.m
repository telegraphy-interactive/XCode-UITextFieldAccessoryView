//
//  TTAIModel.m
//  TestTextAuxInput
//
//  Created by Doug Lovell on 4/25/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import "TTAIModel.h"

@implementation TTAIModel

@synthesize hours;
@synthesize night;
@synthesize started;
@synthesize ended;

- (id)init {
    self = [super init];
    if (self) {
        started = ended = [NSDate date];
        hours = night = @0;
    }
    return self;
}

static NSString * const hoursKey = @"Hours";
static NSString * const nightKey = @"Night";
static NSString * const startedKey = @"Started";
static NSString * const endedKey = @"Ended";

- (id)initFromJSON:(NSDictionary *)json {
    self = [super init];
    if (self) {
        NSNumber *startedCoding = [json objectForKey:startedKey];
        if (startedCoding != nil) {
            started = [NSDate dateWithTimeIntervalSinceReferenceDate:[startedCoding doubleValue]];
        }
        else {
            started = [NSDate date];
        }
        NSNumber *endedCoding = [json objectForKey:endedKey];
        if (endedCoding != nil) {
            ended = [NSDate dateWithTimeIntervalSinceReferenceDate:[endedCoding doubleValue]];
        }
        else {
            ended = [NSDate date];
        }
        hours = [json objectForKey:hoursKey];
        night = [json objectForKey:nightKey];
    }
    return self;
}

- (NSMutableDictionary *) foundify {
    NSMutableDictionary *dictForm = [[NSMutableDictionary alloc] init];
    [dictForm setObject:hours forKey:hoursKey];
    [dictForm setObject:night forKey:nightKey];
    if (started == nil) {
        started = [NSDate date];
    }
    NSNumber * startedCoding = [NSNumber numberWithDouble:[started timeIntervalSinceReferenceDate]];
    [dictForm setObject:startedCoding forKey:startedKey];
    if (ended == nil) {
        ended = [NSDate date];
    }
    NSNumber * endedCoding = [NSNumber numberWithDouble:[ended timeIntervalSinceReferenceDate]];
    [dictForm setObject:endedCoding forKey:endedKey];
    return dictForm;
}

@end
