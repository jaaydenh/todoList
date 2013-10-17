//
//  ToDoItem.h
//  TodoList
//
//  Created by Jaayden on 10/13/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoItem : NSObject

@property (nonatomic, copy) NSString *text;
-(id)initWithText:(NSString*)text;
+(id)toDoItemWithText:(NSString*)text;

@end
