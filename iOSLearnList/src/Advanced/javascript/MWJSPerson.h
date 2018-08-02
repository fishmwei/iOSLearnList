//
//  MWJSPerson.h
//  iOSLearnList
//
//  Created by huangmingwei on 16/8/11.
//  Copyright © 2016年 fishmwei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol MWJSPersonProtocol <JSExport>
@property (nonatomic, retain) NSDictionary *urls;
- (NSString *)fullName;
//- (void)setFirstName:(NSString *)firstName lastName:(NSString *)lastName; // longFunc

JSExportAs(setPersonFullName, -(void)setFirstName
           : (NSString *)firstName lastName
           : (NSString *)lastName); //shortname


@end


@interface MWJSPerson : NSObject <MWJSPersonProtocol>
@property (nonatomic, retain) NSString *firstName;
@property (nonatomic, retain) NSString *lastName;

//@property (nonatomic, retain) NSDictionary *urls;
@end
