//
//  YTKTableDetailViewController.m
//  iOSLearnList
//
//  Created by huangmingwei on 2019/8/27.
//  Copyright © 2019 fishmwei. All rights reserved.
//

#import "YTKTableDetailViewController.h"
#import "ItemModel.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "YTKStoreManager.h"
#import "ItemModelCell.h"

@interface YTKTableDetailViewController ()

@end

@implementation YTKTableDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *right1 = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleDone target:self action:@selector(addItem)];
    
    [self.navigationItem setRightBarButtonItems:@[right1]];
    
    [[YTKStoreManager sharedManager] createTable:self.title];
    self.showData = [[YTKStoreManager sharedManager] getItems:self.title];
    
    [self.tableView registerClass:[ItemModelCell class] forCellReuseIdentifier:@"ItemModelCell"];
}

- (void)addItem {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"输入要添加的信息" preferredStyle:UIAlertControllerStyleAlert];
    
    //取消按钮
    UIAlertAction *CancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    //警示按钮
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *name = alertController.textFields.firstObject.text;
        NSString *position = alertController.textFields.lastObject.text;
        
        if (name.length <=0 || position.length <= 0) {
            MBProgressHUD *hudBar = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hudBar.mode = MBProgressHUDModeText;
            hudBar.detailsLabelText = @"输入不能为空!";
            [hudBar hide:YES afterDelay:1.0];
            return;
        }
        [self addContent:name :position];
    }];
    
    //文本输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //配置文本框的代码块
        textField.placeholder = @"姓名";
        textField.textColor = [UIColor greenColor];
    }];
    
    //文本输入框
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        //配置文本框的代码块
        textField.placeholder = @"职业";
        textField.textColor = [UIColor greenColor];
    }];
    
    [alertController addAction:CancelAction];
    [alertController addAction:doneAction];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (void)addContent:(NSString *)name :(NSString *)position {
    ItemModel *item = [[ItemModel alloc] init];
    item.key = [[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
    item.time = [[NSDate date] timeIntervalSince1970];
    item.name = name;
    item.position = position;
    
    [[YTKStoreManager sharedManager] addItem:item talbeName:self.title];
    
    self.showData = [[YTKStoreManager sharedManager] getItems:self.title];
    [self.tableView reloadData];
}

- (void)removeItem:(ItemModel *)item {
    [[YTKStoreManager sharedManager] removeItem:item talbeName:self.title];
    self.showData = [[YTKStoreManager sharedManager] getItems:self.title];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    ItemModelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ItemModelCell" forIndexPath:indexPath];
    
    ItemModel *info = [self.showData objectAtIndex:indexPath.row];
    [cell fillWithInfo:info];
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ItemModel *info = [self.showData objectAtIndex:indexPath.row];
    NSDictionary *item = [MTLJSONAdapter JSONDictionaryFromModel:info error:nil];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[self DataTOjsonString:item] preferredStyle:UIAlertControllerStyleAlert];
    
    //取消按钮
    UIAlertAction *CancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    //警示按钮
    UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self removeItem:info];
    }];
    
    [alertController addAction:CancelAction];
    [alertController addAction:doneAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(NSString*)DataTOjsonString:(id)object
{
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
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

@end
