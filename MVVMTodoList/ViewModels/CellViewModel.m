//
//  CellViewModel.m
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/19.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import "CellViewModel.h"

@interface CellViewModel ()

@property (nonatomic, copy, readwrite) NSString *index;
@property (nonatomic, copy, readwrite) NSString *todoString;
@property (nonatomic, copy, readwrite) NSString *dateString;

@property (nonatomic, strong, readwrite) NSArray<CellModel *> *models;

@end


@implementation CellViewModel

+ (CellViewModel *)viewModelWithModel:(CellModel *)model {
    return [[self alloc] initWithModel:model];
}

- (CellViewModel *)initWithModel:(CellModel *)model {
    self = [super init];
    if (self) {
        self.index = model.index;
        self.todoString = model.todoString;
        self.dateString = [model formatterDateString];
    }
    return self;
}

- (void)didTapTodo {
    
}

@end
