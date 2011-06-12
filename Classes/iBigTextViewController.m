//
//  iBigTextViewController.m
//  BigText
//
//  Created by Tom Rudick on 10/18/09.
//  Copyright Tom Rudick 2009. All rights reserved.
//

#import "iBigTextViewController.h"

@implementation iBigTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	bigText = [NSString stringWithString:@"Little Phrases. Big Text."];
	bigTextLabel.text = bigText;
	textField.text = bigText;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent*)event {	
	UITouch *touch = [[event allTouches] anyObject];
	if (touch.tapCount == 2) {
		[self showSettings];
		return;
	}
	
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
