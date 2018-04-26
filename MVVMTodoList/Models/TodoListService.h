//
//  TodoListService.h
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/25.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellViewModel.h"

@interface TodoListService : NSObject

@property (nonatomic, strong, readonly) NSMutableArray<CellViewModel *> *cachedTodos;

- (void)requestTodosCompletion:(void(^)(id collection))completion;

- (void)searchTodo:(NSString *)todoIndex completion:(void(^)(id collection))completion;

@end
