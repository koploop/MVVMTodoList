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

- (void)requestTodosCompletion:(void(^)(id collection))completion;

- (NSMutableArray<CellViewModel *> *)loadCachedTodos;

@end
