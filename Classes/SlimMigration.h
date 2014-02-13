//
//  SlimMiration.h
//  ProjectExtended
//
//  Created by Callum Jones on 31/01/2014.
//  Copyright (c) 2014 Callum Jones. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SlimMigration : NSObject {
  NSMutableArray *sqlOperations;
  NSArray *finalSqlOperations;
}

- (void)collectOperations;
- (NSArray *)finalOperations;

- (void)createTable:(NSString *)name withColumns:(NSDictionary *)columns;

- (void)dropTable:(NSString *)name;

- (void)createIndexForTable:(NSString *)tableName withColumns:(NSArray *)columns;
- (void)createUniqueIndexForTable:(NSString *)tableName withColumns:(NSArray *)columns;
- (void)createIndexForTable:(NSString *)tableName named:(NSString *)name withColumns:(NSArray *)columns isUnique:(BOOL)unique;

- (void)addColumnsToTable:(NSString *)name withAttributesAndTypes:(NSDictionary *)columns;

- (void)removeColumns:(NSArray *)columns fromTable:(NSString *)tableName;

- (void)dropIndexForTable:(NSString *)tableName withColumns:(NSArray *)columns;
- (void)dropIndexNamed:(NSString *)name;

- (void)alterIndexForTable:(NSString *)name withPreviousColumns:(NSArray *)previousColumns withColumns:(NSArray *)columns;
- (void)alterIndexNamed:(NSString *)name to:(NSString*)newName withColumns:(NSArray *)colums;

@end
