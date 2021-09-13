//
//  AccountGetInfoResponse.h
//  test-sdk-ios
//
//  Created by dxl on 2018/8/2.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "AccountGetInfoResult.h"

@interface AccountGetInfoResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) AccountGetInfoResult *result;

-(void)buildResponse:(int32_t)errorCode :(AccountGetInfoResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(AccountGetInfoResult *)result;
@end
