//
//  BlockGetRewardResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockGetRewardResult.h"

@interface BlockGetRewardResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) BlockGetRewardResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockGetRewardResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetRewardResult *)result;
@end
