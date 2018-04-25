//
//  DateOperator.h
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/25.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateOperator : NSObject

@property (nonatomic, strong, readonly) NSDateFormatter *formatter;

+ (id)sharedOperator;

@end
