//
//  Utils.m
//  qmkf
//
//  Created by Mac on 2019/12/7.
//  Copyright © 2019 Mac. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSString *)getSafeString:(id)aObj {
    if (aObj == nil
        || [aObj isKindOfClass:[NSNull class]]) {
        return @"";
    }
    NSString *aText = [NSString stringWithFormat:@"%@",aObj];
    
    if (aText.length == 0) {
        return @"";
    }
    if ([aText.lowercaseString isEqualToString:@"<null>"]) {
        return @"";
    }
    return aText;
}

@end
