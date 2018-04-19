//
//  RootModel.h
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/19.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CellModel : NSObject

@property (nonatomic, copy) NSString *index;
@property (nonatomic, strong) NSDate *startTime;

@end
