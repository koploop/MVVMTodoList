//
//  RootTableViewCell.h
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/19.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellViewModel.h"

@interface RootTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;


- (void)bindingCellWithViewModel:(CellViewModel *)viewModel;

@end
