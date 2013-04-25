//
//  TTAIAppDelegate.m
//  TestTextAuxInput
//
//  Created by Doug Lovell on 4/16/13.
//  Copyright (c) 2013 Douglas Lovell. MIT License.
//

#import "TTAIAppDelegate.h"
#import "TTAIViewController.h"

@implementation TTAIAppDelegate

@synthesize model;

+ (NSURL*)appDataFile {
    NSArray* possibleURLs = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL* fileURL = nil;
    if ([possibleURLs count] >= 1) {
        // Use the last directory (if multiple are returned)
        fileURL = [[possibleURLs lastObject] URLByAppendingPathComponent:@"myFltTime"];
    }
    
    return fileURL;
}

- (void) fetchModel {
    model = [TTAIModel alloc];
    NSURL * inURL = [TTAIAppDelegate appDataFile];
    NSData * data = [NSData dataWithContentsOfURL:inURL];
    if (data != nil) {
        NSError * err = [NSError alloc];
        NSDictionary * json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (json == nil) {
            NSLog(@"%s Error is %@", __func__, err);
        }
        else {
            model = [model initFromJSON:json];
        }
    } else {
        model = [model init];
    }
}

- (void) persistModel {
    NSURL * outURL = [TTAIAppDelegate appDataFile];
    NSDictionary * founder = [model foundify];
    NSError * err = [NSError alloc];
    NSData * data = [NSJSONSerialization dataWithJSONObject:founder options:NSJSONWritingPrettyPrinted error:&err];
    [data writeToURL:outURL options:0 error:&err];
}

- (void) setup {
    [self fetchModel];
    TTAIViewController *appController = (TTAIViewController *)self.window.rootViewController;
    appController.model = model;
    [appController syncDisplayForModelState];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setup];
    return YES;
}
							
- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [self persistModel];
    model = nil;
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [self setup];
}

@end
