//
//  SimpleMigrationTestTests.m
//  SimpleMigrationTestTests
//
//  Created by Callum Jones on 13/02/2014.
//  Copyright (c) 2014 Callum Jones. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <SlimMigration.h>

@interface SimpleMigrationTestTests : XCTestCase

@end

@implementation SimpleMigrationTestTests

- (void)setUp
{
  [super setUp];
  // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown
{
  // Put teardown code here; it will be run once, after the last test case.
  [super tearDown];
}

- (void)testCreateTableSyntax
{
  SlimMigration *migration = [[SlimMigration alloc] init];
  [migration createTable:@"Person" withColumns:[NSDictionary dictionaryWithObjectsAndKeys:@"INTEGER PRIMARY KEY", @"id", @"TEXT NOT NULL DEFAULT ''", @"name", nil]];
  
  NSArray *opts = [migration finalOperations];
  NSAssert([opts count] == 1, @"Operations has one item");
  NSString *operation = [opts objectAtIndex:0];
  NSComparisonResult result = [operation compare:@"CREATE TABLE Person (id INTEGER PRIMARY KEY,name TEXT NOT NULL DEFAULT '')"];
  NSAssert(result == NSOrderedSame, @"Operation should contain proper definition");
}

- (void)testCreateUniqueIndexSyntax
{
  SlimMigration *migration = [[SlimMigration alloc] init];
  [migration createIndexForTable:@"Person" named:@"SomeINDEX" withColumns:[NSArray arrayWithObjects:@"Col1", @"Col2", nil] isUnique:YES];
  
  NSArray *opts = [migration finalOperations];
  NSAssert([opts count] == 1, @"Operations has one item");
  NSString *operation = [opts objectAtIndex:0];
  NSComparisonResult result = [operation compare:@"CREATE UNIQUE INDEX IF NOT EXISTS SomeINDEX ON Person (Col1,Col2)"];
  NSAssert(result == NSOrderedSame, @"Operation should contain proper definition");
}

- (void)testCreateIndexSyntax
{
  SlimMigration *migration = [[SlimMigration alloc] init];
  [migration createIndexForTable:@"Person" named:@"SomeINDEX" withColumns:[NSArray arrayWithObjects:@"Col1", @"Col2", nil] isUnique:NO];
  
  NSArray *opts = [migration finalOperations];
  NSAssert([opts count] == 1, @"Operations has one item");
  NSString *operation = [opts objectAtIndex:0];
  NSComparisonResult result = [operation compare:@"CREATE INDEX IF NOT EXISTS SomeINDEX ON Person (Col1,Col2)"];
  NSAssert(result == NSOrderedSame, @"Operation should contain proper definition");
}

- (void)testCreateAutoNameIndexSyntax
{
  SlimMigration *migration = [[SlimMigration alloc] init];
  [migration createIndexForTable:@"Person" named:nil withColumns:[NSArray arrayWithObjects:@"Col1", @"Col2", nil] isUnique:NO];
  
  NSArray *opts = [migration finalOperations];
  NSAssert([opts count] == 1, @"Operations has one item");
  NSString *operation = [opts objectAtIndex:0];
  NSComparisonResult result = [operation compare:@"CREATE INDEX IF NOT EXISTS Person_Col1_Col2 ON Person (Col1,Col2)"];
  NSAssert(result == NSOrderedSame, @"Operation should contain proper definition");
}

- (void)testAddColumnSyntax
{
  SlimMigration *migration = [[SlimMigration alloc] init];
  [migration addColumnsToTable:@"table" withAttributesAndTypes:[NSDictionary dictionaryWithObjectsAndKeys:@"TEXT DEFAULT NULL", @"someColumn", nil]];
  
  NSArray *opts = [migration finalOperations];
  NSAssert([opts count] == 1, @"Operations has one item");
  NSString *operation = [opts objectAtIndex:0];
  NSComparisonResult result = [operation compare:@"ALTER TABLE table ADD COLUMN someColumn TEXT DEFAULT NULL"];
  NSAssert(result == NSOrderedSame, @"Operation should contain proper definition");
}

- (void)testDropIndexForTableSyntax
{
  SlimMigration *migration = [[SlimMigration alloc] init];
  [migration dropIndexForTable:@"Person" withColumns:[NSArray arrayWithObjects:@"Col1", @"Col3", @"Col2", nil]];
  
  NSArray *opts = [migration finalOperations];
  NSAssert([opts count] == 1, @"Operations has one item");
  NSString *operation = [opts objectAtIndex:0];
  NSComparisonResult result = [operation compare:@"DROP INDEX IF EXISTS Person_Col1_Col2_Col3"];
  NSAssert(result == NSOrderedSame, @"Operation should contain proper definition");
}

- (void)testDropIndexNamedSyntax
{
  SlimMigration *migration = [[SlimMigration alloc] init];
  [migration dropIndexNamed:@"Person_Index" ];
  
  NSArray *opts = [migration finalOperations];
  NSAssert([opts count] == 1, @"Operations has one item");
  NSString *operation = [opts objectAtIndex:0];
  NSComparisonResult result = [operation compare:@"DROP INDEX IF EXISTS Person_Index"];
  NSAssert(result == NSOrderedSame, @"Operation should contain proper definition");
}

- (void)testDropTableSyntax
{
  SlimMigration *migration = [[SlimMigration alloc] init];
  [migration dropTable:@"Person" ];
  
  NSArray *opts = [migration finalOperations];
  NSAssert([opts count] == 1, @"Operations has one item");
  NSString *operation = [opts objectAtIndex:0];
  NSComparisonResult result = [operation compare:@"DROP TABLE IF EXISTS Person"];
  NSAssert(result == NSOrderedSame, @"Operation should contain proper definition");
}

@end
