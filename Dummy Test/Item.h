//
//  Item.h
//  Dummy Test
//
//  Created by Jack Higgins on 4/6/14.
//  Copyright (c) 2014 Higgins Software Design. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class List;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSData * picture;
@property (nonatomic, retain) NSString * price;
@property (nonatomic, retain) List *list;

@end
