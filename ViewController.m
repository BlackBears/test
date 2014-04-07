//
//  ViewController.m
//  Dummy Test
//
//  Created by Jack Higgins on 4/5/14.
//  Copyright (c) 2014 Higgins Software Design. All rights reserved.
//

#import "ViewController.h"
#import "WishListView.h"
#import "AddViewController.h"
#import "List.h"
#import "Item.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    // Fetch the lists from persistent data store
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    self.lists = [[[self managedObjectContext] executeFetchRequest:fetchRequest error:nil] mutableCopy];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSManagedObject *list = [self.lists objectAtIndex:indexPath.row];
    [cell.textLabel setText:[list valueForKey:@"name"]];
    
    return cell;
}

-(IBAction)add:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add List" message:@"Create a New Wish List" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert setTag:2];
    [alert show];
    alert.delegate = self;
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != 0 && alertView.tag == 2) {
        UITextField *tf = [alertView textFieldAtIndex:0];
        NSManagedObjectContext *context = [self managedObjectContext];
        
        // Create a new managed object
        NSManagedObject *newList = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:context];
        [newList setValue:tf.text forKey:@"name"];
        
        NSError *error = nil;
        // Save the object to persistent store
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
   
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"List"];
    self.lists = [[[self managedObjectContext] executeFetchRequest:fetchRequest error:nil] mutableCopy];
    
    [self.tableView reloadData];
   
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObjectContext *context = [self managedObjectContext];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete object from database
        [context deleteObject:[self.lists objectAtIndex:indexPath.row]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Delete! %@ %@", error, [error localizedDescription]);
            return;
        }
        // Remove list from table view
        [self.lists removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - Storyboard support

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WishListView *wishListController = segue.destinationViewController;
    
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    List *selectedList = self.lists[indexPath.row];
    wishListController.list = selectedList;
    wishListController.managedObjectContext = self.managedObjectContext;
}

@end
