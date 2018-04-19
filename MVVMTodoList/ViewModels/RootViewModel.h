//
//  RootViewModel.h
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/19.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CellViewModel;
@interface RootViewModel : NSObject

@property (nonatomic, strong) NSMutableArray<CellViewModel *> *todos;


- (void)loadAllTodos:(void(^)(id colletion))completion;

// 点击添加的时候,ViewModel将添加的关键词(可能是View中TextField的内容)传给Model,Model负责组装,然后回调给ViewModel,再回调给View?
- (void)addTodo;

@end
