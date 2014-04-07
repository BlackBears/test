//
//  List.h
//  Dummy Test
//
//  Created by Jack Higgins on 4/6/14.
//  Copyright (c) 2014 Higgins Software Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface List : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *item;
@end

@interface List (CoreDataGeneratedAccessors)

- (void)addItemObject:(NSManagedObject *)value;
- (void)removeItemObject:(NSManagedObject *)value;
- (void)addItem:(NSSet *)values;
- (void)removeItem:(NSSet *)values;

@end
