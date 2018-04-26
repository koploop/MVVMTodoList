//
//  RootModel.m
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/19.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import "CellModel.h"
#import "DateOperator.h"

@interface CellModel ()

@property (nonatomic, strong, readwrite) NSArray *randomTodos;

@end


@implementation CellModel

- (NSString *)formatterDateString {
    NSDateFormatter *formatter = [[DateOperator sharedOperator] formatter];
    NSString *dateString = [formatter stringFromDate:self.date];
    return dateString;
}

+ (CellModel *)randomTodo {
    return [[self alloc] initRandomTodo];
}

- (CellModel *)initRandomTodo {
    self = [super init];
    if (self) {
        int number = arc4random() % 7 + 0;
        self.index = [NSString stringWithFormat:@"%d", number];
        self.todoString = self.randomTodos[number];
        self.date = [NSDate dateWithTimeIntervalSinceNow:0];
    }
    return self;
}

#pragma mark - YYModel
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSNumber *timestamp = dic[@"date"];
    if (![timestamp isKindOfClass:[NSNumber class]]) return NO;
    _date = [NSDate dateWithTimeIntervalSince1970:timestamp.floatValue];
    return YES;
}

#pragma mark -
- (NSArray *)randomTodos {
    if (!_randomTodos) {
        _randomTodos = @[@"Go Study",
                         @"Go Sleep",
                         @"Make Lunch",
                         @"Make Dinner",
                         @"Watch Movie",
                         @"Play Games",
                         @"Do Works"];
    }
    return _randomTodos;
}

@end
