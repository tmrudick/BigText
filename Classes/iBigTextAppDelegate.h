//
//  iBigTextAppDelegate.h
//  BigText
//
//  Created by Tom Rudick on 10/18/09.
//  Copyright Tom Rudick 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class iBigTextViewController;

@interface iBigTextAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow *window;
    iBigTextViewController *viewController;	
}	

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet iBigTextViewController *viewController;
@end

