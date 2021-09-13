//
//  AccountGetInfoResult.m
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "AccountGetInfoResult.h"
#import "YYModelClass.h"

@implementation AccountGetInfoResult
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"priv" : Priv.class};
}

+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"metadatasHash" : @"metadatas_hash",
             @"assetsHash" : @"assets_hash"};
}
@end
