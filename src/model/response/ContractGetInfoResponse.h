//
//  ContractGetInfoResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/14.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "ContractGetInfoResult.h"

@interface ContractGetInfoResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) ContractGetInfoResult *result;

-(void)buildResponse:(int32_t)errorCode :(ContractGetInfoResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(ContractGetInfoResult *)result;
@end
