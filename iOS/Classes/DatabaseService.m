//
//  DatabaseService.m
//  iBigText
//
//  Created by Tom Rudick on 1/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "DatabaseService.h"


@implementation DatabaseService
@synthesize databasePath, databaseFileName;

- (id)init {
    if(self = [super init]) {
#pragma synchronous=OFF
#pragma temp_store=MEMORY
        
        databaseFileName = @"terms.db";
        [self checkAndCreateDatabase];
        if(sqlite3_enable_shared_cache(0) != SQLITE_OK) {
            return nil;
        }
        if(sqlite3_open([self.databasePath UTF8String], &database) != SQLITE_OK) {
            return nil;
        }
    }
    
    return self;
}

- (void)checkAndCreateDatabase {
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
    
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // Get the path to the documents directory and append the databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	self.databasePath = [documentsDir stringByAppendingPathComponent:self.databaseFileName];
    
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
    
	// If the database already exists then return without doing anything
	if(success) return;
    
	// If not then proceed to copy the database from the application to the users filesystem
    
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFileName];
    
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
    
	//[fileManager release];
}

- (NSArray*)loadTerms {
	NSMutableArray *terms = [[NSMutableArray alloc] init];
    	
    const char *sql = "SELECT term FROM `terms`";
    sqlite3_stmt *statement;
    if(sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            NSString *term = [[NSString alloc] initWithUTF8String:(char*)sqlite3_column_text(statement, 0)];
            [terms addObject:term];
            [term release];
        }
    }
    sqlite3_finalize(statement);
    
    return terms;
}

- (void)addTerm:(NSString*)newTerm {
	const char* sql = "INSERT INTO terms ('term') VALUES (?)";
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
		sqlite3_bind_text(statement, 1, [newTerm UTF8String], -1, SQLITE_TRANSIENT);
		NSAssert1(sqlite3_step(statement) == SQLITE_DONE, @"Error with %s", sqlite3_errmsg(database));
	}
	sqlite3_finalize(statement);
}

- (void)deleteTerm:(NSString *)oldTerm {
	const char* sql = "DELETE FROM terms WHERE term = ?";
	sqlite3_stmt *statement;
	if (sqlite3_prepare_v2(database, sql, -1, &statement, NULL) == SQLITE_OK) {
		sqlite3_bind_text(statement, 1, [oldTerm UTF8String], -1, SQLITE_TRANSIENT);
		NSAssert1(sqlite3_step(statement) == SQLITE_DONE, @"Error with %s", sqlite3_errmsg(database));
	}
	sqlite3_finalize(statement);
}

- (void)dealloc {
    [databasePath release];
    sqlite3_close(database);
    database = NULL;
    
    [super dealloc];
}


@end
