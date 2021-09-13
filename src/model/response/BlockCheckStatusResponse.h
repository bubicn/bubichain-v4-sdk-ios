//
//  BlockCheckStatusResponse.h
//  sdk-ios
//
//  Created by dxl on 2018/8/15.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "BaseResponse.h"
#import "BlockCheckStatusResult.h"

@interface BlockCheckStatusResponse : NSObject
@property (nonatomic, assign) int32_t errorCode;
@property (nonatomic, copy) NSString *errorDesc;
@property (nonatomic, strong) BlockCheckStatusResult *result;

-(void)buildResponse:(int32_t)errorCode :(BlockCheckStatusResult *)result;
-(void)buildResponse:(int32_t)errorCode : (NSString *)errorDesc :(BlockCheckStatusResult *)result;
@end
