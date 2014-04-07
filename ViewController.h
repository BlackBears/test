//
//  ViewController.h
//  Dummy Test
//
//  Created by Jack Higgins on 4/5/14.
//  Copyright (c) 2014 Higgins Software Design. All rights reserved.
//

@interface ViewController : UITableViewController <UIAlertViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (strong) NSMutableArray *lists;
@property (strong) NSMutableArray *items;

- (IBAction)add:(id)sender;

@end
