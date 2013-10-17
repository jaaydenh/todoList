//
//  TableViewCell.h
//  TodoList
//
//  Created by Jaayden on 10/14/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableViewCellDelegate.h"

@interface TableViewCell : UITableViewCell <UITextFieldDelegate>

@property (nonatomic) ToDoItem *todoItem;

@property (strong, nonatomic) UITextField *mainLabel;

@property (nonatomic, assign) id<TableViewCellDelegate> delegate;

@end
