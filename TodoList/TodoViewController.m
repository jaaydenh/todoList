//
//  ViewController.m
//  TodoList
//
//  Created by Jaayden on 10/13/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TodoViewController.h"
#import "ToDoItem.h"
#import "TableViewCell.h"

@interface TodoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation TodoViewController

NSMutableArray* _toDoItems;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _toDoItems = [[NSMutableArray alloc] init];
        [_toDoItems addObject:[ToDoItem toDoItemWithText:@"Feed the cat"]];
        [_toDoItems addObject:[ToDoItem toDoItemWithText:@"Buy eggs"]];
        [_toDoItems addObject:[ToDoItem toDoItemWithText:@"Pack bags for WWDC"]];
        [_toDoItems addObject:[ToDoItem toDoItemWithText:@"Rule the web"]];
        [_toDoItems addObject:[ToDoItem toDoItemWithText:@"Buy a new iPhone"]];
        [_toDoItems addObject:[ToDoItem toDoItemWithText:@"Find missing socks"]];
        [_toDoItems addObject:[ToDoItem toDoItemWithText:@"Write a new tutorial"]];
        [_toDoItems addObject:[ToDoItem toDoItemWithText:@"Master Objective-C"]];
        [_toDoItems addObject:[ToDoItem toDoItemWithText:@"Remember your wedding anniversary!"]];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(itemAdded)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(editButton:)];
    
    [self.tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)editButton:(id)sender
{
    if(self.editing)
    {
        [super setEditing:NO animated:NO];
        [self.tableView setEditing:NO animated:NO];
        [self.tableView reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
    else
    {
        [super setEditing:YES animated:YES];
        [self.tableView setEditing:YES animated:YES];
        [self.tableView reloadData];
        [self.navigationItem.leftBarButtonItem setTitle:@"Done"];
        [self.navigationItem.leftBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
}

#pragma mark - UITableViewDataSource protocol methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _toDoItems.count;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    [textField resignFirstResponder];
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ident = @"cell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];

    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    int index = [indexPath row];
    ToDoItem *item = _toDoItems[index];
    cell.mainLabel.text = item.text;

    cell.delegate = self;
    cell.todoItem = item;
    
    return cell;
}

#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *todoItem = [_toDoItems objectAtIndex:indexPath.row];
        [self.tableView beginUpdates];
        [_toDoItems removeObject:todoItem];
        [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]]
                              withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *item = [_toDoItems objectAtIndex:fromIndexPath.row];
    [_toDoItems removeObject:item];
    [_toDoItems insertObject:item atIndex:toIndexPath.row];
}

-(void)toDoItemDeleted:(id)todoItem {
    NSUInteger index = [_toDoItems indexOfObject:todoItem];
    [self.tableView beginUpdates];
    [_toDoItems removeObject:todoItem];
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]]
                          withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

-(void)itemAdded {

    ToDoItem* toDoItem = [[ToDoItem alloc] init];
    [_toDoItems insertObject:toDoItem atIndex:0];
    [_tableView reloadData];

    TableViewCell* editCell;
    for (TableViewCell* cell in _tableView.visibleCells) {
        if (cell.todoItem == toDoItem) {
            editCell = cell;
            break;
        }
    }
    [editCell.textLabel becomeFirstResponder];
}

@end
