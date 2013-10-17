//
//  ToDoItem.m
//  TodoList
//
//  Created by Jaayden on 10/13/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "ToDoItem.h"

@implementation ToDoItem

-(id)initWithText:(NSString*)text {
    if (self = [super init]) {
        self.text = text;
    }
    return self;
}

+(id)toDoItemWithText:(NSString *)text {
    return [[ToDoItem alloc] initWithText:text];
}

@end
