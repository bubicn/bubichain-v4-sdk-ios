//
//  GasSendInfo.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "GasSendInfo.h"
#import "YYModelClass.h"

@implementation GasSendInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"destAddress" : @"dest_address"};
}
@end
