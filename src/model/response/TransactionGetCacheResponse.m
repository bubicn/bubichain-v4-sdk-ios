//
//  TransactionGetCacheResponse.m
//  sdk-ios
//
//  Created by bubi on 2021/9/13.
//  Copyright © 2021 dlx. All rights reserved.
//

#import "TransactionGetCacheResponse.h"
#import "YYModelClass.h"

@implementation TransactionGetCacheResponse
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"result" : TransactionGetCacheResult.class};
}

-(void)buildResponse:(int32_t)errorCode :(TransactionGetCacheResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = [SDKError getDescription:errorCode];
    self.result = result;
}

-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(TransactionGetCacheResult *)result {
    self.errorCode = errorCode;
    self.errorDesc = errorDesc;
    self.result = result;
}
@end
