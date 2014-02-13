//
//  SlimMiration.m
//  ProjectExtended
//
//  Created by Callum Jones on 31/01/2014.
//  Copyright (c) 2014 Callum Jones. All rights reserved.
//

#import "SlimMigration.h"

@implementation SlimMigration

- (id)init {
  self = [super init];
  
  sqlOperations = [[NSMutableArray alloc] init];
  finalSqlOperations = nil;
  
  return self;
}

- (NSArray *)finalOperations
{
  if (finalSqlOperations == nil)
  {
    [self collectOperations];
    finalSqlOperations = [NSArray arrayWithArray:sqlOperations];
  }
  
  return finalSqlOperations;
}

- (void)collectOperations
{
  
}

- (void)createTable:(NSString *)name withColumns:(NSDictionary *)columns
{
  NSMutableString *stmt = [NSMutableString stringWithFormat:@"CREATE TABLE %@", name];
  
  [stmt appendString:@" ("];
  NSArray *keys = [columns allKeys];
  for (int index = 0; index < keys.count; index++) {
    NSString *key = keys[index];
    NSString *definition = [columns objectForKey:key];
    [stmt appendString:[NSString stringWithFormat:@"%@ %@", key, definition]];
    if (index != (keys.count - 1))
      [stmt appendString:@","];
  }
  
  [stmt appendString:@")"];
  [sqlOperations addObject:[NSString stringWithString:stmt]];
}

- (void)createIndexForTable:(NSString *)tableName named:(NSString *)name withColumns:(NSArray *)columns isUnique:(BOOL)unique
{
  NSMutableString *stmt = [NSMutableString stringWithString:@"CREATE "];
  
  if (name == nil)
    name = [self indexForTable:tableName withColumns:columns];
  
  if (unique)
    [stmt appendString:@"UNIQUE "];
  
  [stmt appendFormat:@"INDEX IF NOT EXISTS %@ ON %@", name, tableName];
  
  [stmt appendString:@" ("];
  for (int index = 0; index < columns.count; index++)
  {
    NSString *column = [columns objectAtIndex:index];
    [stmt appendString:column];
    if (index != (columns.count - 1))
      [stmt appendString:@","];
  }
  [stmt appendString:@")"];
  
  [sqlOperations addObject:[NSString stringWithString:stmt]];
}

- (void)dropTable:(NSString *)name
{
  [sqlOperations addObject:[NSString stringWithFormat:@"DROP TABLE IF EXISTS %@", name]];
}

- (void)createIndexForTable:(NSString *)tableName withColumns:(NSArray *)columns
{
  [self createIndexForTable:tableName named:nil withColumns:columns isUnique:NO];
}

- (void)createUniqueIndexForTable:(NSString *)tableName withColumns:(NSArray *)columns
{
  [self createIndexForTable:tableName named:nil withColumns:columns isUnique:YES];
}

- (void)addColumnsToTable:(NSString *)name withAttributesAndTypes:(NSDictionary *)columns
{
  NSMutableString *stmt = [NSMutableString stringWithFormat:@"ALTER TABLE %@ ", name];
  
  NSArray *keys = [columns allKeys];
  for (int index = 0; index < keys.count; index++) {
    NSString *key = keys[index];
    NSString *definition = [columns objectForKey:key];
    [stmt appendString:[NSString stringWithFormat:@"ADD COLUMN %@ %@", key, definition]];
  }
  
  [sqlOperations addObject:[NSString stringWithString:stmt]];
}

- (void)dropIndexForTable:(NSString *)tableName withColumns:(NSArray *)columns
{
  [self dropIndexNamed:[self indexForTable:tableName withColumns:columns]];
}

- (void)dropIndexNamed:(NSString *)name
{
  [sqlOperations addObject:[NSString stringWithFormat:@"DROP INDEX IF EXISTS %@", name]];
}

- (NSString *)indexForTable:(NSString *)tableName withColumns:(NSArray *)columns
{
  NSArray *sorted = [columns sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
  NSString *colSet = [sorted componentsJoinedByString:@"_"];
  return [NSString stringWithFormat:@"%@_%@", tableName, colSet];
}

@end
