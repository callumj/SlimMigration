# SlimMigration

A **Work In Progress** library for writing migrations as classes, tying them together to generate the necessary SQL operations needed to bring your database to the appropriate version.

```objc

#import "SlimMigration.h"

@interface CreateBooksTablev1 : SlimMigration

@end

@implementation CreateBooksTablev1

- (void)collectOperations
{
  NSDictionary *colOpts = [NSDictionary dictionaryWithObjectsAndKeys:
                           @"INTEGER PRIMARY KEY", @"id",
                           @"TEXT DEFAULT NULL", @"title",
                           @"INTEGER DEFAULT NULL", @"reference",
                           @"INTEGER", @"createdAt",
                           @"INTEGER", @"updatedAt",
                           nil];
  [self createTable:@"Book" withColumns:colOpts];
  [self createIndexForTable:@"Book" withColumns:[NSArray arrayWithObjects:@"createdAt", nil]];
  [self createIndexForTable:@"Book" withColumns:[NSArray arrayWithObjects:@"updatedAt", nil]];
}

@end

```