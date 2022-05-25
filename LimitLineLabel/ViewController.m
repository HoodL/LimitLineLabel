//
//  ViewController.m
//  LimitLineLabel
//
//  Created by 李辉 on 2022/5/22.
//

#import "ViewController.h"
#import "LimitLabelTest1VC.h"
#import "LimitLabelTest2VC.h"

@interface ViewController ()
@property(nonatomic, copy) NSArray *titleArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _titleArr = @[@"方法一", @"方法二"];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = _titleArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        LimitLabelTest1VC *vc = [[LimitLabelTest1VC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.row == 1) {
        LimitLabelTest2VC *vc = [[LimitLabelTest2VC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
