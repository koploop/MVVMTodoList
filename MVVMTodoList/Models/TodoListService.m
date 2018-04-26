//
//  TodoListService.m
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/25.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import "TodoListService.h"
#import "CellViewModel.h"
#import <YYModel/YYModel.h>

@interface TodoListService ()

@property (nonatomic, strong, readwrite) NSMutableArray<CellViewModel *> *cachedTodos;

@end

@implementation TodoListService

- (void)requestTodosCompletion:(void(^)(id collection))completion {
    // 模拟耗时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *resource = [[NSBundle mainBundle] pathForResource:@"todos" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:resource];
        NSError *error;
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        if (error) {
            completion(error);
            return;
        }
        
        NSMutableArray *viewModels = [NSMutableArray array];
        for (NSDictionary *dic in array) {
            CellModel *model = [CellModel yy_modelWithDictionary:dic];
            CellViewModel *viewModel = [CellViewModel viewModelWithModel:model];
            [viewModels addObject:viewModel];
        }
        self.cachedTodos = viewModels;
        completion(viewModels);
    });
}

- (void)searchTodo:(NSString *)todoIndex completion:(void(^)(id collection))completion {
    // 模拟耗时操作
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSMutableArray *results = [NSMutableArray array];
        if (todoIndex && todoIndex.length > 0) {
            for (CellViewModel *viewModel in self.cachedTodos) {
                if ([viewModel.index containsString:todoIndex]) {
                    [results addObject:viewModel];
                }
            }
        }
        else {
            results = self.cachedTodos;
        }
        if (completion) {completion(results);}
    });
}

#pragma mark -
- (NSMutableArray<CellViewModel *> *)cachedTodos {
    if (!_cachedTodos) {
        _cachedTodos = [NSMutableArray array];
    }
    return _cachedTodos;
}

@end
