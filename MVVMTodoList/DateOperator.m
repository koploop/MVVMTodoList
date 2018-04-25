//
//  DateOperator.m
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/25.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import "DateOperator.h"

@interface DateOperator ()

@property (nonatomic, strong, readwrite) NSDateFormatter *formatter;

@end

@implementation DateOperator

static DateOperator *_operator;
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _operator = [super allocWithZone:zone];
    });
    return _operator;
}

+ (id)sharedOperator {
    return [[DateOperator alloc] init];
}

#pragma mark -
- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        _formatter.timeZone = [NSTimeZone systemTimeZone];
        _formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return _formatter;
}

@end
