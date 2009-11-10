//
//  iBigTextTermsController.h
//  BigText
//
//  Created by Tom Rudick on 10/19/09.
//  Copyright Tom Rudick 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Term.h"
#import "iBigTextAppDelegate.h"

@protocol iBigTextSettingsDelegate;

@interface iBigTextTermsController : UIViewController {
	id <iBigTextSettingsDelegate> delegate;
	IBOutlet UITableView* termTableView;
	
	NSMutableArray* terms;
	NSManagedObjectContext* context;
}
@property(nonatomic, assign) id <iBigTextSettingsDelegate> delegate;
-(IBAction)save;
-(IBAction)done;

@end

@protocol iBigTextSettingsDelegate
-(void)updateBigText:(NSString *)newText;
-(NSString*)getBigText;
@end
