//
//  MyMainTableViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/1/22.
//  Copyright © 2019年 fishmwei. All rights reserved.
//

#import "MyMainTableViewController.h"
#import "MyResultsTableController.h"

@interface SearchControllerRestorableState : NSObject
@property (nonatomic, assign) BOOL wasActive;
@property (nonatomic, assign) BOOL wasFirstResponder;

@end


@interface MyMainTableViewController () <UITableViewDelegate,
UITableViewDataSource,
UISearchBarDelegate,
UISearchControllerDelegate,
UISearchResultsUpdating>

@property (nonatomic, strong) NSArray *products;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) MyResultsTableController *resultsTableController;
@property (nonatomic, strong) SearchControllerRestorableState *restoredState;


@end

@implementation MyMainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.resultsTableController = [MyResultsTableController new];
    self.resultsTableController.tableView.delegate = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:self.resultsTableController];
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    
    if (@available(iOS 11.0, *)) {
        self.navigationItem.searchController = self.searchController;
        self.navigationItem.hidesSearchBarWhenScrolling = NO;
    } else {
        self.tableView.tableHeaderView = self.searchController.searchBar;
    }
    
    self.searchController.delegate = self;
//    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.delegate = self;
    
    
    self.definesPresentationContext = YES;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.restoredState.wasActive) {
        self.searchController.active = self.restoredState.wasActive;
        self.restoredState.wasActive = NO;
        
        if (self.restoredState.wasFirstResponder) {
            [self.searchController.searchBar becomeFirstResponder];
            self.restoredState.wasFirstResponder = NO;
        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
     return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (tableView == self.tableView) {
//        return self.products.count;
//    } else {
//        return self.filteredProducts.count;
//    }
    return self.products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyTableViewID forIndexPath:indexPath];
    
    id data = [self.products objectAtIndex:indexPath.row];
    [self configureCell:cell data:data];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.tableView) {
        
    } else {
        
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSInteger count = rand()%10;
    NSMutableArray *filterData = [NSMutableArray array];
    for (NSInteger i = 0; i < count; i++) {
        [filterData addObject:@(i)];
    }
    
    self.resultsTableController.filteredProducts = filterData;
    [self.resultsTableController.tableView reloadData];
}
@end
