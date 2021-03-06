//
//  LimitLabelTest1VC.m
//  LimitLineLabel
//
//  Created by æè¾ on 2022/5/22.
//

#import "LimitLabelTest1VC.h"
#import "LimitLabelTableViewCell.h"

@interface LimitLabelTest1VC ()
@property(nonatomic, copy) NSArray *contentArray;
@end

@implementation LimitLabelTest1VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:LimitLabelTableViewCell.class forCellReuseIdentifier:@"LimitLabelTableViewCell"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    
    NSString *str1 = nil; NSString *str2 = nil; NSString *str3 = nil;NSString *str4 = nil;
    str1 = @"1111111ððæé½æ¯&%%sgvjhH 01siåå·ççä¼ï¼ç®ç§°11111111ðððð¶èï¼å«ç§°èåãé¦åï¼è¥¿åå°åºå¯ä¸ä¸ä¸ªå¯ççº§å¸ï¼ [1]  ç¹å¤§åå¸ï¼è¥¿é¨æåºæºå³é©»å°ï¼ [2]  å½å¡é¢ç¡®å®çå½å®¶éè¦é«æ°ææ¯äº§ä¸åºå°ã [3]  åè´¸ç©æµä¸­å¿åç»¼åäº¤éæ¢çº½ï¼æ¯è¥¿é¨å°åºéè¦çä¸­å¿åå¸ã [4]  2017å¹´ï¼å¨å¸ä¸è¾20ä¸ªåºï¼å¸ï¼å¿åé«æ°åºãå¤©åºæ°åºæé½ç´ç®¡åºï¼é¢ç§¯14335å¹³æ¹å¬éï¼å¸¸ä½äººå£1604.5ä¸äººï¼GDP13889.39äº¿åã";
    str2 = @"æé½æ¯åå·ççä¼ï¼ç®ç§°èï¼å«ç§°èåãé¦åï¼è¥¿åå°åºå¯ä¸ä¸ä¸ªå¯ççº§å¸ï¼ [1]  ç¹å¤§åå¸ï¼è¥¿é¨æåºæºå³é©»å°ï¼ [2]  å½å¡é¢ç¡®å®çå½å®¶éè¦é«æ°ææ¯äº§ä¸åºå°ã [3]  åè´¸ç©æµä¸­å¿åç»¼åäº¤éæ¢çº½ï¼æ¯è¥¿é¨å°åºéè¦çä¸­å¿åå¸ã [4]  2017å¹´ï¼å¨å¸ä¸è¾20ä¸ªåºï¼å¸ï¼å¿åé«æ°åºãå¤©åºæ°åºæé½ç´ç®¡åºï¼é¢ç§¯14335å¹³æ¹å¬éï¼å¸¸ä½äººå£1604.5ä¸äººï¼GDP13889.39äº¿åã";
    //çº¯è±æ
    str3 = @"There are many many foods we can eat, such as apple, banana, pear, carrot, onion, orange, potato and many others. My father likes to eat very thing, expect it is not be able to eat. My mother likes to eat vegetables and fruits, she usually eat some meat. I like to eat meat, and fruits, too, but I do not like to eat vegetables, and apple is favorite food.";
    //çº¯ä¸­æ
    str4 = @"æä»¬æµªè¿¹æ±æ¹çæ¶åï¼éæ¸è·å¾äºä¸ç§å¯ä»¥åºæ¥ççå®æ¬é¢ï¼å æ­¤å¯¹å¤§å­¦å­¦ä½ä¹å°±ä¸æå°ç¹å«éè¦ï¼å¯æ¯å¨è¢«å¤§éªå°å¨è¦æ ¹å±±èé£å¹¢å°å±éçæ¶åï¼æä»¬åæ¬¡æå°ï¼å¦ææä»¬ä»¥åç ç©¶è¿è·é©¬çä½åãå¸èæãæ°å­¦å·¾çåæ°ä»¥åæ¯è¾é«æ·±çå­¦é®ï¼é£æä»¬å¨æ²æé»æ³æ¹é¢ä¹è®¸å°±è½åºä»èªå¦äºã";

    _contentArray = @[str1, str2, str3, str4];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;// 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LimitLabelTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LimitLabelTableViewCell" forIndexPath:indexPath];
    [cell bindData:_contentArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LimitLabelTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell foldAllData];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
