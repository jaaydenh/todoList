//
//  TableViewCellDelegate.h
//  TodoList
//
//  Created by Jaayden on 10/14/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoItem.h"

@protocol TableViewCellDelegate <NSObject>

-(void) toDoItemDeleted:(ToDoItem*)todoItem;

@end
