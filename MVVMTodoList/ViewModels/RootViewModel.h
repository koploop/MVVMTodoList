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

/*
 * 这里可能有一个疑问: 为什么todos中存放的还是ViewModel而不是更直接的CellModel呢?
 * 确实,存放CellModel更直观方便一些,cell可以一步拿到需要数据,然后更新View.
 * 但是这样一来,Cell岂不是直接就依赖了Model吗? 我们希望的是View只和ViewModel进行数据交互.ViewModel来管理Models.
 * ViewModel是View和Model的监视器,任何一方的改动都会通过ViewModel传递给另一方.
 */
@property (nonatomic, strong) NSMutableArray<CellViewModel *> *todos;

/*
 * MVVM的原则之一即为View之间不可直接进行数据交互.
 * 所以View的数据变化应能体现在ViewModel中,View的展示都是从ViewModel中获取数据.
 * 这里定义一个textFieldString, TextField的内容应能绑定到这个值,时刻变化.
 */
@property (nonatomic, copy) NSString *textFieldString;

/*
 * 我们假设这里要进行的是网络请求等耗时的操作(拿到原始数据.)
 * 之后将原始数据交由Model做处理,最终返回一个View需要的数据.
 */
- (void)loadAllTodos:(void(^)(id colletion))completion;

/*
 * 点击添加的时候,ViewModel将添加的关键词(可能是View中TextField的内容)传给Model,
 * Model负责组装,然后回调给ViewModel,再回调给View.
 * 在ReactiveCocoa中,使用的是RACCommand来绑定View中的某一个动作.
 * 比如我们这里定义一个AddTodoCommand命令属性,View中的addButton绑定这个命令,点击的时候就可以触发.就不需要单独写一个方法
 */
- (void)addTodo;

@end
