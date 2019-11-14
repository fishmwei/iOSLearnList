//
//  FileBrowserViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/11/14.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "FileBrowserViewController.h"
#import "FileBrowserInfo.h"
#import "FileBrowserCell.h"

@interface FileBrowserViewController ()
@property (nonatomic, strong) NSString *directoryPath;
@end

@implementation FileBrowserViewController

- (instancetype)initWithDirectoryPath:(NSString *)directoryPath {
    self = [super init];
    if (self) {
        _directoryPath = directoryPath;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[FileBrowserCell class] forCellReuseIdentifier:@"FileBrowserCell"];
    
    [self getFileInfos];
}

- (void)getFileInfos {
    NSError *error = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *files = [fileManager contentsOfDirectoryAtPath:self.directoryPath error:&error];
    if (error) {
        return;
    }
    
    NSMutableArray *filesMutArr = [NSMutableArray array];
    for (NSString *fileName in files) {
        NSString *filePath = [self.directoryPath stringByAppendingPathComponent:fileName];
        BOOL isFolder = NO;
        BOOL isFileExist = [fileManager fileExistsAtPath:filePath isDirectory:&isFolder];
        if (isFileExist) {
            FileBrowserInfo *fileInfo = [[FileBrowserInfo alloc] init];
            fileInfo.fileName = fileName;
            fileInfo.filePath = filePath;
            fileInfo.isFolder = isFolder;
            if (self.fileListDelegate) {
                if ([self.fileListDelegate shouldShowFileInfo:fileInfo]) {
                    [filesMutArr addObject:fileInfo];
                }
            } else {
                [filesMutArr addObject:fileInfo];
            }
        }
    }
    
    self.showData = [filesMutArr copy];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.showData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FileBrowserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FileBrowserCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[FileBrowserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FileBrowserCell"];
    }
    
    [cell fillWithInfo:[self.showData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FileBrowserInfo *info = [self.showData objectAtIndex:indexPath.row];
    if (info.isFolder) {
        
        FileBrowserViewController *vc = [[FileBrowserViewController alloc] initWithDirectoryPath:info.filePath];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
        
    }
    
}

@end
