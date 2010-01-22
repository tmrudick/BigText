//
//  DatabaseService.h
//  iBigText
//
//  Created by Tom Rudick on 1/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@interface DatabaseService : NSObject {
    NSString *databasePath;
    NSString *databaseFileName;
    sqlite3 *database;
}

@property (nonatomic, retain) NSString *databasePath;
@property (nonatomic, retain) NSString *databaseFileName;

- (void)checkAndCreateDatabase;
- (NSArray*)loadTerms;
- (void)addTerm:(NSString*)newTerm;
- (void)deleteTerm:(NSString*)oldTerm;
@end
