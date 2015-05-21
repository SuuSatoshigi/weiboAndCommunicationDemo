//
//  UIUtils.m
//  WXTime
//
//  Created by wei.chen on 12-7-22.
//  Copyright (c) 2012年 www.iphonetrain.com 无限互联ios开发培训中心 All rights reserved.
//

#import "UIUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "RegexKitLite.h" //处理正则
#import "NSString+URLEncoding.h"//处理中文
@implementation UIUtils

+ (NSString *)getDocumentsPath:(NSString *)fileName {
    
    //两种获取document路径的方式
//    NSString *documents = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documents = [paths objectAtIndex:0];
    NSString *path = [documents stringByAppendingPathComponent:fileName];
    
    return path;
}

+ (NSString*) stringFromFomate:(NSDate*) date formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formate];
	NSString *str = [formatter stringFromDate:date];
	[formatter release];
	return str;
}

+ (NSDate *) dateFromFomate:(NSString *)datestring formate:(NSString*)formate {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formate];
    NSDate *date = [formatter dateFromString:datestring];
    [formatter release];
    return date;
}

//Sat Jan 12 11:50:16 +0800 2013
+ (NSString *)fomateString:(NSString *)datestring {
    NSString *formate = @"E MMM d HH:mm:ss Z yyyy";
    NSDate *createDate = [UIUtils dateFromFomate:datestring formate:formate];
    NSString *text = [UIUtils stringFromFomate:createDate formate:@"MM-dd HH:mm"];
    return text;
}

//解析超链接
+ (NSString *)parseLink:(NSString *)sendText {

        NSString *text = sendText;
        //正则表达式
        NSString *regex = @"(@\\w+)|(#\\w+#)|(http(s)?://([A-Za-z0-9._-]+(/)?)*)";
        //导入外部库
        NSArray *matchArray = [text componentsMatchedByRegex:regex];
        //得到@user，＃话题＃，http：／／
        for (NSString *link in matchArray) {
            //拥有某前缀时
            NSString *reply = nil;
            if ([link hasPrefix:@"@"]) {
                //使用第三方库处理中文乱码问题
                reply = [NSString stringWithFormat:@"<a href='user://%@'>%@</a>",[link URLEncodedString],link];
            } else if ([link hasPrefix:@"http"]) {
                reply = [NSString stringWithFormat:@"<a href='%@'>%@</a>",link,link];
            } else if ([link hasPrefix:@"#"]) {
                reply = [NSString stringWithFormat:@"<a href='topic://%@'>%@</a>",[link URLEncodedString],link];
            }
            if (reply != nil) {
                text = [text stringByReplacingOccurrencesOfString:link withString:reply];
            }

        }
    return text;
}
@end
