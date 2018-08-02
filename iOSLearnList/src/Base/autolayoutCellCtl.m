//
//  autolayoutCellCtl.m
//  iOSLearnList
//
//  Created by mingwei on 16/6/5.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "autolayoutCellCtl.h"
#import "autolayoutCell.h"


@interface autolayoutCellCtl ()
@property (nonatomic, strong) autolayoutCell *prototypeCell;
@end


@implementation autolayoutCellCtl

- (void)viewDidLoad
{
    [super viewDidLoad];


    UINib *cellNib = [UINib nibWithNibName:@"autolayoutCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"autolayoutCell"];

    self.showData = @[ @"1", @"2\n2", @"autolayoutCellautolayoutCellautolayoutCellautolayoutCellautolayoutCell5autolayoutCellautolayoutCellautolayoutCellautolayoutCellautolayoutCell5", @"\n\n\n5" ];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    autolayoutCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"autolayoutCell"];
    cell.label.text = [self.showData objectAtIndex:indexPath.row];
    cell.imgVeiw.image = [MWCommon imageNamed:@"lion"];


    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_prototypeCell == nil) {
        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"autolayoutCell"];
    }

    _prototypeCell.label.text = [self.showData objectAtIndex:indexPath.row];
    //    [_prototypeCell.label sizeto÷]
    [_prototypeCell.label sizeToFit];
    CGSize size = [_prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"h=%f", size.height + 1);
    return 1 + size.height;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (_prototypeCell == nil) {
//        _prototypeCell = [self.tableView dequeueReusableCellWithIdentifier:@"autolayoutCell"];
//    }
//
//    _prototypeCell.textLabel.text = [self.showData objectAtIndex:indexPath.row];
//
//
//    CGSize size = [_prototypeCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    NSLog(@"h=%f", size.height + 1);
//    return 1  + size.height;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
