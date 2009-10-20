//
//  iBigTextTermsController.h
//  iBigText
//
//  Created by Tom Rudick on 10/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Term.h"

@protocol iBigTextSettingsDelegate;

@interface iBigTextTermsController : UIViewController {
	id <iBigTextSettingsDelegate> delegate;
	IBOutlet UITableView* termTableView;
	
	NSMutableArray* terms;
}
@property(nonatomic, assign) id <iBigTextSettingsDelegate> delegate;
-(IBAction)save;
-(IBAction)edit;

@end

@protocol iBigTextSettingsDelegate
-(void)updateBigText:(NSString *)newText;
-(NSString*)getBigText;
@end
