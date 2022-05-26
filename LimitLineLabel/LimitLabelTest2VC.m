//
//  LimitLabelTest2VC.m
//  LimitLineLabel
//
//  Created by 李辉 on 2022/5/25.
//

#import "LimitLabelTest2VC.h"
#import "LimitLabelTableViewCell2.h"
#import "UnfoldIndexManager.h"

@interface LimitLabelTest2VC ()
@property(nonatomic, copy) NSArray *contentArray;

@end

@implementation LimitLabelTest2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:LimitLabelTableViewCell2.class forCellReuseIdentifier:@"LimitLabelTableViewCell2"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    NSString *str1 = nil; NSString *str2 = nil; NSString *str3 = nil;NSString *str4 = nil;
    str1 = @"1111111😂😁成都是&%%sgvjhH 01si四川省省会，简称11111111😆😆😋🌶蓉，别称蓉城、锦城，西南地区唯一一个副省级市， [1]  特大城市，西部战区机关驻地， [2]  国务院确定的国家重要高新技术产业基地、 [3]  商贸物流中心和综合交通枢纽，是西部地区重要的中心城市。 [4]  2017年，全市下辖20个区（市）县和高新区、天府新区成都直管区，面积14335平方公里，常住人口1604.5万人，GDP13889.39亿元。";
    str2 = @"成都是四川省省会，简称蓉，别称蓉城、锦城，西南地区唯一一个副省级市， [1]  特大城市，西部战区机关驻地， [2]  国务院确定的国家重要高新技术产业基地、 [3]  商贸物流中心和综合交通枢纽，是西部地区重要的中心城市。 [4]  2017年，全市下辖20个区（市）县和高新区、天府新区成都直管区，面积14335平方公里，常住人口1604.5万人，GDP13889.39亿元。";
    //纯英文
    str3 = @"There are many many foods we can eat, such as apple, banana, pear, carrot, onion, orange, potato and many others. My father likes to eat very thing, expect it is not be able to eat. My mother likes to eat vegetables and fruits, she usually eat some meat. I like to eat meat, and fruits, too, but I do not like to eat vegetables, and apple is favorite food.";
    //纯中文
    str4 = @"我们浪迹江湖的时候，逐渐获得了一种可以应急的真实本领，因此对大学学位也就不感到特别需要，可是在被大雪封在苦根山脉那幢小屋里的时候，我们初次感到，如果我们以前研究过荷马的作品、希腊文、数学巾的分数以及比较高深的学问，那我们在沉思默想方面也许就能应付自如了。";

    _contentArray = @[str1, str2, str3, str4];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 120;

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _contentArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LimitLabelTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:@"LimitLabelTableViewCell2" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    [cell bindData:_contentArray[indexPath.row]];
    return cell;
}

- (void)dealloc {
    [UnfoldIndexManager resetUnfoldIndexs];
}

@end
