//
//  RootViewController.m
//  MVVMTodoList
//
//  Created by SuperMario@lvhan on 2018/4/20.
//  Copyright © 2018年 Koploop. All rights reserved.
//

#import "RootViewController.h"
#import "RootViewModel.h"
#import "RootTableViewCell.h"
#import <SVProgressHUD/SVProgressHUD.h>

#import <IQKeyboardManager/IQKeyboardManager.h>


static NSString *identifier = @"rootCell";

@interface RootViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addButton;

@property (nonatomic, strong) RootViewModel *viewModel;


@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = self.addButton;
    [self.tableView registerNib:[UINib nibWithNibName:@"RootTableViewCell" bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:identifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 65;
    self.searchTextField.returnKeyType = UIReturnKeyGo;
    self.searchTextField.delegate = self;
    
    [self viewModelCommandsHandler];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewModelCommandsHandler {
    self.viewModel = [RootViewModel new];
    [SVProgressHUD show];
    [self.viewModel loadAllTodos:^(id colletion) {
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
    }];
    
    typeof(self)weakSelf = self;
    self.viewModel.addTodoCommand = ^{
        [weakSelf.tableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:weakSelf.viewModel.todos.count - 1 inSection:0];
        [weakSelf.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    };
    self.viewModel.searchTodoCommand = ^{
        [weakSelf.tableView reloadData];
    };
}

#pragma mark -
// 增加一条todo
- (IBAction)addTodo:(UIBarButtonItem *)sender {
    [self.viewModel addTodoAction];
}

// 搜索todo index
- (IBAction)goTodo:(UIButton *)sender {
    [self.searchTextField resignFirstResponder];
    self.viewModel.textFieldString = self.searchTextField.text;
    [SVProgressHUD show];
    [self.viewModel searchTodoActionCompletion:^{
        [SVProgressHUD dismiss];
    }];
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.todos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RootTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell bindingCellWithViewModel:self.viewModel.todos[indexPath.row]];
    return cell;
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
