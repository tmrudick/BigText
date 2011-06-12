//
//  iBigTextTermsController.m
//  BigText
//
//  Created by Tom Rudick on 10/19/09.
//  Copyright Tom Rudick 2009. All rights reserved.
//

#import "iBigTextTermsController.h"


@implementation iBigTextTermsController

@synthesize delegate;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	dbService = [[DatabaseService alloc] init];
	NSArray* t_array = [dbService loadTerms];
	terms = [[NSMutableArray alloc] initWithArray:t_array];
	[t_array release];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
	[dbService release];
	[terms release];
    [super dealloc];
}

-(IBAction)save {
	if (![terms containsObject:[delegate getBigText]]) {
		[dbService addTerm:[delegate getBigText]];
		[terms addObject:[delegate getBigText]];
		[termTableView reloadData];
	}
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
	NSString *cellValue = [terms objectAtIndex:indexPath.row];
	[cell.textLabel setText:cellValue];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[delegate updateBigText:[terms objectAtIndex:indexPath.row]];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	// If row is deleted, remove it from the list.
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{		
		// Delete the managed object at the given index path.
		[dbService deleteTerm:[terms objectAtIndex:indexPath.row]];
		[terms removeObjectAtIndex:indexPath.row];
		[tableView reloadData];
	}
}

@end
