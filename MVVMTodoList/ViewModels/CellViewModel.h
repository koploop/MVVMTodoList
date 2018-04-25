//
//  CellViewModel.h
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/19.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellModel.h"

@interface CellViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *index;

@property (nonatomic, copy, readonly) NSString *todoString;

@property (nonatomic, copy, readonly) NSString *dateString;

+ (CellViewModel *)viewModelWithModel:(CellModel *)model;

- (void)didTapTodo;

@end
