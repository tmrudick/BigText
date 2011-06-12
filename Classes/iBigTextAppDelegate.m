//
//  iBigTextAppDelegate.m
//  BigText
//
//  Created by Tom Rudick on 10/18/09.
//  Copyright Tom Rudick 2009. All rights reserved.
//

#import "iBigTextAppDelegate.h"
#import "iBigTextViewController.h"

@interface iBigTextAppDelegate (Private)
- (void)createEditableCopyOfDatabaseIfNeeded;
- (void)initializeDatabase;
@end

@implementation iBigTextAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}

- (void)dealloc {
    [viewController release];
	[window release];
	[super dealloc];
}
@end
