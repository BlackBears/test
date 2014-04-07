//
//  AddViewController.h
//  Dummy Test
//
//  Created by Jack Higgins on 4/5/14.
//  Copyright (c) 2014 Higgins Software Design. All rights reserved.
//

typedef void(^AddViewControllerCompletionBlock)(BOOL saved);

@class Item;

@interface AddViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (strong) NSMutableArray *lists;
@property (strong) NSMutableArray *items;

@property (nonatomic, strong) Item *item;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *price;
@property (strong, nonatomic) IBOutlet UITextField *desc;

@property (nonatomic, strong) AddViewControllerCompletionBlock completionBlock;


- (IBAction)cancel:(id)sender;
- (IBAction)save:(id)sender;

@end
