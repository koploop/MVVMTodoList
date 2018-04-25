//
//  RootTableViewCell.m
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/19.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import "RootTableViewCell.h"

@implementation RootTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)bindingCellWithViewModel:(CellViewModel *)viewModel {
    self.indexLabel.text = viewModel.index;
    self.contentLabel.text = viewModel.todoString;
    self.dateLabel.text = viewModel.dateString;
}

@end
