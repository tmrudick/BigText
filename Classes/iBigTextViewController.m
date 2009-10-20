//
//  iBigTextViewController.m
//  iBigText
//
//  Created by Tom Rudick on 10/18/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "iBigTextViewController.h"

@implementation iBigTextViewController



/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	bigText = [NSString stringWithString:@"Big Text. Little Phrases."];//@"Big Text. Little Phrases."];
	bigTextLabel.text = bigText;
	textField.text = bigText;
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event {
	NSSet *allTouches = [event allTouches];
    if ([allTouches count] == 2) {
		[self showSettings];
	}else{
		textField.hidden = NO;
		bigTextLabel.hidden = YES;
		[textField becomeFirstResponder];
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)field {
	textField.hidden = YES;
	[textField resignFirstResponder];
	bigText = field.text;
	bigTextLabel.hidden = NO;

	[self drawBigText];
	
	return TRUE;
}

- (void)dealloc {
    [super dealloc];
}

-(void)showSettings {
	iBigTextTermsController *controller = [[iBigTextTermsController alloc] initWithNibName:@"iBigTextTermsController" bundle:nil];
	
	controller.delegate = self;
	controller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
	[self presentModalViewController:controller animated:YES];
	
	[controller release];
}

-(void)drawBigText {
	bigTextLabel.text = bigText;
	
	double fontSize = 200.0;
	while (fontSize > 36) {
		CGRect bounds = bigTextLabel.bounds;
		bounds.size = [bigText sizeWithFont:[UIFont fontWithName:@"Georgia" size:fontSize]];
		
		if (bigTextLabel.bounds.size.height >= bounds.size.height && bigTextLabel.bounds.size.width >= bounds.size.width) {
			[bigTextLabel setFont:[UIFont fontWithName:@"Georgia" size:fontSize]];
			break;
		}
		fontSize -= 2;
	}
}

-(void)updateBigText:(NSString *)newText {
	bigText = newText;
	[self dismissModalViewControllerAnimated:YES];
	[self drawBigText];
}

-(NSString*)getBigText {
	return bigText;
}

@end
