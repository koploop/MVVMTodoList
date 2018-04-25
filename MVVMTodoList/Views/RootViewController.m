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
    [self viewModelCommandsHandler];
    [self.tableView registerNib:[UINib nibWithNibName:@"RootTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.searchTextField.returnKeyType = UIReturnKeyGo;
    self.searchTextField.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
//    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewModelCommandsHandler {
    self.viewModel = [RootViewModel new];
    [self.viewModel loadAllTodos:^(id colletion) {
        [self.tableView reloadData];
    }];
    
    typeof(self)weakSelf = self;
    self.viewModel.addTodoCommand = ^{
        [weakSelf.tableView reloadData];
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
    [self.viewModel searchTodoAction];
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

#pragma mark -
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.viewModel.textFieldString = [textField.text stringByAppendingString:string];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self goTodo:nil];
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
