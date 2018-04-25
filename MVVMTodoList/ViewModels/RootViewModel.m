//
//  RootViewModel.m
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/19.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import "RootViewModel.h"
#import "CellViewModel.h"
#import "TodoListService.h"

@interface RootViewModel ()

@property (nonatomic, strong, readwrite) NSMutableArray<CellViewModel *> *todos;

@property (nonatomic, strong) TodoListService *service;

@end

@implementation RootViewModel

- (void)loadAllTodos:(void(^)(id colletion))completion {
    [self.service requestTodosCompletion:^(id collection) {
        self.todos = collection;
    }];
}

- (void)addTodoAction {
    CellModel *model = [CellModel randomTodo];
    CellViewModel *viewModel = [CellViewModel viewModelWithModel:model];
    [self.todos addObject:viewModel];
    
    if (self.addTodoCommand) {
        self.addTodoCommand();
    }
}

- (void)searchTodoAction {
    if (self.textFieldString) {
        NSMutableArray *results = [NSMutableArray array];
        for (CellViewModel *viewModel in self.todos) {
            if ([viewModel.todoString containsString:self.textFieldString]) {
                [results addObject:viewModel];
            }
        }
        self.todos = results;
    } else {
        self.todos = [self.service loadCachedTodos];
    }
    
    if (self.searchTodoCommand) {
        self.searchTodoCommand();
    }
}

#pragma mark -
- (TodoListService *)service {
    if (!_service) {
        _service = [[TodoListService alloc] init];
    }
    return _service;
}




@end
