//
//  iBigTextAppDelegate.h
//  BigText
//
//  Created by Tom Rudick on 10/18/09.
//  Copyright Tom Rudick 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class iBigTextViewController;

@interface iBigTextAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	UIWindow *window;
    iBigTextViewController *viewController;	
}	

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iBigTextViewController *viewController;

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (NSString *)applicationDocumentsDirectory;

@end

