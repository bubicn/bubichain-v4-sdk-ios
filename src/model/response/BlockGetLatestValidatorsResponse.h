//
//  BlockGetLatestValidatorsResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockGetLatestValidatorsResult.h"

@interface BlockGetLatestValidatorsResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) BlockGetLatestValidatorsResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockGetLatestValidatorsResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockGetLatestValidatorsResult *)result;
@end
