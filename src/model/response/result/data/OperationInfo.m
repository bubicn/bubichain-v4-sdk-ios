//
//  Operation.m
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "OperationInfo.h"
#import "YYModelClass.h"

@implementation OperationInfo
+ (NSDictionary *)modelCustomPropertyMapper {
    // value should be Class or Class name.
    return @{@"sourceAddress" : @"source_address",
             @"createAccount" : @"create_account",
             @"issueAsset" : @"issue_asset",
             @"sendAsset" : @"pay_asset",
             @"sendGas" : @"pay_coin",
             @"setMetadata" : @"set_metadata",
             @"setPrivilege" : @"set_privilege"};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"createAccount" : AccountActiviateInfo.class,
             @"issueAsset" : AssetIssueInfo.class,
             @"sendAsset" : AssetSendInfo.class,
             @"sendGas" : GasSendInfo.class,
             @"setMetadata" : AccountSetMetadataInfo.class,
             @"setPrivilege" : AccountSetPrivilegeInfo.class,
             @"log" : LogInfo.class};
}
@end
