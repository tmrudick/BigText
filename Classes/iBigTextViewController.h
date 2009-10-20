//
//  iBigTextViewController.h
//  iBigText
//
//  Created by Tom Rudick on 10/18/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iBigTextTermsController.h"

@interface iBigTextViewController : UIViewController <iBigTextSettingsDelegate> {
	IBOutlet UITextView* bigTextView;
	IBOutlet UILabel* bigTextLabel;
	IBOutlet UITextField* textField;
	UIFont* bigFont;
	NSString* bigText;
}

-(void)drawBigText;
-(void)showSettings;
@end

