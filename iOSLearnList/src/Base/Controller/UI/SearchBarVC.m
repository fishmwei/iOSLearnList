//
//  SearchBarVC.m
//  iOSLearnList
//
//  Created by huangmingwei on 16/7/25.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import "SearchBarVC.h"

#import <MBProgressHUD/MBProgressHUD.h>


@interface SearchBarVC () <UISearchDisplayDelegate,
                            UISearchBarDelegate> {
    UISearchDisplayController *searchController;
    UISearchBar *searchBar;
}

@property (nonatomic, retain) NSMutableArray *showData;
@property (nonatomic, retain) NSArray *historyData;
@property (nonatomic, retain) MBProgressHUD *tipHud;


@end

@implementation SearchBarVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    self.navigationItem.hidesBackButton = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupMyData];
    [self setupMyUI];
    
    
   
//    self.navigationItem.hidesBackButton = YES;
    
//    self.navigationItem.leftBarButtonItem  = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:NULL];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStyleDone target:self action:@selector(backBtnPressed)];
    
    _tipHud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:_tipHud];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UI
- (void)setupMyUI {
    [self.tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    searchBar = [[UISearchBar alloc] init];
    [searchBar setShowsCancelButton:YES animated:NO];
    searchBar.text = @"aa";
    searchBar.delegate = self;
    [searchBar setBarTintColor:[UIColor blueColor]];
    
    //    [self.tableView setTableHeaderView:searchBar];
    
    
    searchController = [[UISearchDisplayController alloc]
                        initWithSearchBar:searchBar contentsController:self];
    searchController.delegate = self;
    searchController.searchResultsDataSource = self;
    searchController.searchResultsDelegate = self;
    searchController.displaysSearchBarInNavigationBar = YES;
    searchController.searchResultsTableView.hidden = YES;
//    searchController.navigationItem.hidesBackButton = YES;
    
//    searchController.searchContentsController.view.alpha = 0;
    
    [searchController.searchBar setValue:@"取消" forKey:@"cancelButtonText"];
    
    
    
}


#pragma mark - Data
- (void)setupMyData {
    self.showData = [NSMutableArray arrayWithArray:@[@"1", @"2", @"3"]];
    self.historyData = @[@"H0", @"H1", @"H2", @"H3"];
}

-  (void)getData {
    [self showLoadingTips];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^ {
        [self.showData addObjectsFromArray:@[@1, @2, @3]];
//        self.historyData = self.showData;
        [self.tableView reloadData];
        [searchController setActive:NO animated:YES];
        [self dismissLoadingTips];
    });
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == searchController.searchResultsTableView) {
//        return self.historyData.count;
        return 0;
    } else if (tableView == self.tableView) {
        return self.showData.count;
    } else {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == searchController.searchResultsTableView) {
//        static NSString *cellId = @"ReuseIdHistory";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//        }
//        
//        cell.textLabel.text = [self.historyData objectAtIndex:indexPath.row];
//        return cell;
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor blueColor];
        return cell;
    } else if (tableView == self.tableView) {
//        static NSString *cellId = @"ReuseIdHistory";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
//        if (!cell) {
//            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
//        }
//        cell.textLabel.text = [self.showData objectAtIndex:indexPath.row];
//        return cell;
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.backgroundColor = [UIColor redColor];
        return cell;
    } else {
        return [[UITableViewCell alloc] init];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == searchController.searchResultsTableView) {
        [self getData];
//        [self.navigationController pushViewController:[[UIViewController alloc] init] animated:YES];
        
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - SearchBar delegate

//- ([CATransaction setDisableActions:YES];

//- (BOOL)searchbar

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {

    [self getData];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)showTextTips:(NSString *)tips
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view addSubview:_tipHud];
    [self.view bringSubviewToFront:_tipHud];
    
    _tipHud.mode = MBProgressHUDModeText;
    _tipHud.labelText = tips;
    [_tipHud show:YES];
    [_tipHud hide:YES afterDelay:1];
}

- (void)showLoadingTips
{
    [MBProgressHUD hideHUDForView:self.view animated:NO];
    [self.view addSubview:_tipHud];
    [self.view bringSubviewToFront:_tipHud];
    
    _tipHud.labelText = nil;
    _tipHud.mode = MBProgressHUDModeIndeterminate;
    [_tipHud show:YES];
}

- (void)dismissLoadingTips
{
    [_tipHud hide:YES];
}

@end
