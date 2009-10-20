//
//  iBigTextTermsController.m
//  iBigText
//
//  Created by Tom Rudick on 10/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "iBigTextTermsController.h"


@implementation iBigTextTermsController

@synthesize delegate;

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	context = [(iBigTextAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext];
	
	NSFetchRequest *request = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@"Term" inManagedObjectContext:context];
	[request setEntity:entity];
	
	NSLog(@"Fetching...");
	NSError *error;
	terms = [[context executeFetchRequest:request error:&error] mutableCopy];

	if (terms == nil) {
		NSLog(@"We got nothing.");
	}else{
		NSLog(@"We got something...");
	}
	
	[termTableView reloadData];
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


- (void)dealloc {
    [super dealloc];
}

-(IBAction)save {
	if ([terms indexOfObject:[delegate getBigText]] != NSNotFound)
		return;
	
	Term *term = (Term *)[NSEntityDescription insertNewObjectForEntityForName:@"Term" inManagedObjectContext:context];

	[term setTitle:[delegate getBigText]];
	NSError *error;
	if (![context save:&error]) {
		NSLog(@"Error");
	}
	[terms addObject:term];
	[delegate updateBigText:[delegate getBigText]];
}

-(IBAction)done {
	[delegate updateBigText:[delegate getBigText]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return terms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
	}
	
	// Set up the cell...
	NSString *cellValue = [[terms objectAtIndex:indexPath.row] title];
	[cell.textLabel setText:cellValue];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[delegate updateBigText:[[terms objectAtIndex:indexPath.row] title]];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	// If row is deleted, remove it from the list.
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{		
		// Delete the managed object at the given index path.
        NSManagedObject* term = [terms objectAtIndex:indexPath.row];
        [context deleteObject:term];
		
        // Update the array and table view.
        [terms removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
		
        // Commit the change.
        NSError *error;
        if (![context save:&error]) {
            // Handle the error.
        }
	}
}

@end
