//
//  sdkTests.m
//  sdkTests
//
//  Created by dxl on 2018/8/16.
//  Copyright © 2018 dlx. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <sdk_ios.framework/Headers/sdk_ios.h>

@interface sdkTests : XCTestCase

@end

@implementation sdkTests
SDK *sdk;

- (void)setUp {
    [super setUp];
    sdk = [[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
//    [self checkAccountValid];
//    [self createNewAccount];
//    [self getAccountInfo];
//    [self getAccountNonce];
//    [self getAccountBalance];
//    [self getAccountAssets];
//    [self getAccountMetadata];
//    [self getAssetInfo];
//    [self activateAccount];
//    [self setAccountMetadata];
//    [self setAccountPrivilege];
//    [self issueAsset];
//    [self sendAsset];
//    [self sendGas];
//    [self createContract];
//    [self checkContractValid];
//    [self getContractInfo];
//    [self getContractAddress];
//    [self invokeContractByAsset];
//    [self invokeContractByGas];
//    [self callContract];
//    [self getTransactionByHash];
//    [self checkBlockStatus];
//    [self getTransactionsByBlockNumber];
//    [self getLatestBlockNumber];
    [self getBlockInfo];
//    [self getBlockLatestInfo];
//    [self getBlockValidators];
//    [self getLatestBlockValidators];
//    [self getBlockFees];
//    [self getBlockLatestFees];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
}

- (void) checkAccountValid {
    AccountService *accountService = [sdk getAccountService];
    AccountCheckValidRequest *request = [AccountCheckValidRequest new];
    [request setAddress:@"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd"];
    AccountCheckValidResponse *response = [accountService checkValid: request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) createNewAccount {
    AccountService *accountService = [sdk getAccountService];
    AccountCreateResponse *response = [accountService create];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAccountInfo {
    NSString *address = @"adxSaoPcBaAhKf9d1AQYPCGUiUCvQ7nRiPnp1";
    AccountService *accountService = [sdk getAccountService];
    AccountGetInfoRequest *request = [AccountGetInfoRequest new];
    [request setAddress : address];
    AccountGetInfoResponse *response = [accountService getInfo : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAccountNonce {
    NSString *address = @"adxSaoPcBaAhKf9d1AQYPCGUiUCvQ7nRiPnp1";
    AccountService *accountService = [sdk getAccountService];
    AccountGetNonceRequest * request = [AccountGetNonceRequest new];
    [request setAddress : address];
    AccountGetNonceResponse *response = [accountService getNonce : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAccountBalance {
    NSString *address = @"adxSYPYtcPfZgCWf1kXZT2tgGpQ27W1U8Wd9b";
    AccountService *accountService = [sdk getAccountService];
    AccountGetBalanceRequest * request = [AccountGetBalanceRequest new];
    [request setAddress : address];
    AccountGetBalanceResponse *response = [accountService getBalance : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAccountAssets {
    NSString *address = @"adxSYPYtcPfZgCWf1kXZT2tgGpQ27W1U8Wd9b";
    AccountService *accountService = [sdk getAccountService];
    AccountGetAssetsRequest * request = [AccountGetAssetsRequest new];
    [request setAddress : address];
    AccountGetAssetsResponse *response = [accountService getAssets : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAccountMetadata {
    NSString *address = @"adxSYPYtcPfZgCWf1kXZT2tgGpQ27W1U8Wd9b";
    AccountService *accountService = [sdk getAccountService];
    AccountGetMetadataRequest * request = [AccountGetMetadataRequest new];
    [request setAddress : address];
    AccountGetMetadataResponse *response = [accountService getMetadata : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getAssetInfo {
    NSString *address = @"adxSYPYtcPfZgCWf1kXZT2tgGpQ27W1U8Wd9b";
    NSString *code = @"CZT99";
    NSString *issuer = @"adxSYPYtcPfZgCWf1kXZT2tgGpQ27W1U8Wd9b";
    AssetGetInfoRequest *request = [AssetGetInfoRequest new];
    [request setAddress : address];
    [request setCode : code];
    [request setIssuer : issuer];
    
    AssetService *assetService = [sdk getAssetService];
    AssetGetInfoResponse *response = [assetService getInfo : request];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) activateAccount {
    AccountService *accountService = [sdk getAccountService];
    // Create an inactive account
    AccountCreateResponse *activateResponse = [accountService create];
    XCTAssert(activateResponse.errorCode == 0, @"%@", activateResponse.errorDesc);
    
    // Build AccountActivateOperation
    NSString *sourceAddress = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    NSString *destAddress = activateResponse.result.address;
    int64_t initBalance = 10000000;
    AccountActivateOperation *operation = [AccountActivateOperation new];
    [operation setSourceAddress : sourceAddress];
    [operation setDestAddress : destAddress];
    [operation setInitBalance : initBalance];
    [operation setMetadata : @"activate account"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbUFLEWrHdBKUCKJ9A63xLycv4TJKfdNCmbZUjJsav2c3fgMuFRLm";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = [self getAccountNonce : sourceAddress] + 1;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) setAccountMetadata {
    // Build AccountSetMetadataOperation
    NSString *sourceAddress = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    NSString *key = @"setMetadataTest";
    NSString *value = @"201808";
    AccountSetMetadataOperation *operation = [AccountSetMetadataOperation new];
    [operation setSourceAddress : sourceAddress];
    [operation setKey : key];
    [operation setValue : value];
    [operation setMetadata : @"set metadata"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbUFLEWrHdBKUCKJ9A63xLycv4TJKfdNCmbZUjJsav2c3fgMuFRLm";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = [self getAccountNonce : sourceAddress] + 1;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) setAccountPrivilege {
    // Build AccountSetPrivilegeOperation
    NSString *sourceAddress = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    AccountSetPrivilegeOperation *operation = [AccountSetPrivilegeOperation new];
    [operation setSourceAddress : sourceAddress];
    SignerInfo *signer = [SignerInfo new];
    [signer setAddress : @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd"];
    [signer setWeight : 2];
    [operation addSigner : signer];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbUFLEWrHdBKUCKJ9A63xLycv4TJKfdNCmbZUjJsav2c3fgMuFRLm";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = [self getAccountNonce : sourceAddress] + 1;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) issueAsset {
    // Build AssetIssueOperation
    NSString *sourceAddress = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    // Asset code
    NSString *code = @"RV";
    // Asset amount
    int64_t amount = 9223372036854775807;
    AssetIssueOperation *operation = [AssetIssueOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setCode: code];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbUFLEWrHdBKUCKJ9A63xLycv4TJKfdNCmbZUjJsav2c3fgMuFRLm";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 5100403000;
    int64_t nonce = [self getAccountNonce : sourceAddress] + 1;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) sendAsset {
    // Build AssetSendOperation
    NSString *sourceAddress = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    // Destination account
    NSString *destAddress = @"adxSrGbxwGGsAEvhqMKwo4Hu9XK6JQqNCtwoc";
    // Asset code
    NSString *code = @"RV";
    // Asset issuer
    NSString *issuer = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    // Asset amount
    int64_t amount = 100000;
    AssetSendOperation *operation = [AssetSendOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDestAddress: destAddress];
    [operation setCode: code];
    [operation setIssuer: issuer];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbUFLEWrHdBKUCKJ9A63xLycv4TJKfdNCmbZUjJsav2c3fgMuFRLm";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = [self getAccountNonce : sourceAddress] + 1;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) sendGas {
    // Build GasSendOperation
    NSString *sourceAddress = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    // Destination account
    NSString *destAddress = @"adxSrGbxwGGsAEvhqMKwo4Hu9XK6JQqNCtwoc";
    // Gas amount
    int64_t amount = 1000000;
    GasSendOperation *operation = [GasSendOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDestAddress: destAddress];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbUFLEWrHdBKUCKJ9A63xLycv4TJKfdNCmbZUjJsav2c3fgMuFRLm";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = [self getAccountNonce : sourceAddress] + 1;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) createContract {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"adxSps42rYHaDJwohJ1RjJuSJGmMS6fnN2yuu";
    // Contract account initialization Gas，the unit is UGas，and 1 Gas = 10^8 UGas
    int64_t initBalance = [[Tools ToUGas: @"0.1"] longLongValue];
    // Contract code
    NSString *payload = @"\n          \"use strict\";\n          function init(bar)\n          {\n            /*init whatever you want*/\n            return;\n          }\n          \n          function main(input)\n          {\n            let para = JSON.parse(input);\n            if (para.do_foo)\n            {\n              let x = {\n                \'hello\' : \'world\'\n              };\n            }\n          }\n          \n          function query(input)\n          { \n            return input;\n          }\n        ";
    // The contract account address of contract token code
    NSString *initInput = @"";
    ContractCreateOperation *operation = [ContractCreateOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setInitBalance: initBalance];
    [operation setPayload: payload];
    [operation setInitInput: initInput];
    [operation setMetadata: @"create contract"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbwkMDEohu2fm5znuWUwKvRZd5MP1oHNqT9PyvaSREAqkKx4rxm6C";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1100908000;
    int64_t nonce = [self getAccountNonce : sourceAddress] + 1;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) getContractAddress {
    ContractGetAddressRequest *request = [ContractGetAddressRequest new];
    [request setHash: @"ff14a4c42447f9da8a2aca9152df630e864c18dba2d6098533c1d20ebf807aca"];
    
    ContractService *service = [sdk getContractService];
    ContractGetAddressResponse *response = [service getAddress: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
    ContractAddressInfo *contractAddressInfo = [response.result.contractAddressInfos objectAtIndex:0];
    NSLog(@"%@", contractAddressInfo.contractAddress);
}

- (void) checkContractValid {
    ContractCheckValidRequest *request = [ContractCheckValidRequest new];
    [request setContractAddress: @"adxSBaWZYTqKdYdRikmboU6KFhW96QnemxuN3"];
    
    ContractService *service = [sdk getContractService];
    ContractCheckValidResponse *response = [service checkValid: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getContractInfo {
    ContractGetInfoRequest *request = [ContractGetInfoRequest new];
    [request setContractAddress: @"adxSBaWZYTqKdYdRikmboU6KFhW96QnemxuN3"];
    
    ContractService *service = [sdk getContractService];
    ContractGetInfoResponse *response = [service getInfo: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) invokeContractByAsset {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    // The account to receive the assets
    NSString *contractAddress = @"adxSBaWZYTqKdYdRikmboU6KFhW96QnemxuN3";
    // The asset code to be sent
    NSString *assetCode = @"RV";
    // The account address to issue asset
    NSString *assetIssuer = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    // 0 means that the contract is only triggered
    int64_t amount = 0;
    // Contract main function entry
    NSString *input = @"";
    ContractInvokeByAssetOperation *operation = [ContractInvokeByAssetOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setCode: assetCode];
    [operation setIssuer: assetIssuer];
    [operation setAmount: amount];
    [operation setInput: input];
    [operation setMetadata: @"send asset and invoke contract"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbUFLEWrHdBKUCKJ9A63xLycv4TJKfdNCmbZUjJsav2c3fgMuFRLm";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = [self getAccountNonce : sourceAddress] + 1;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) invokeContractByGas {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    // The account to receive the assets
    NSString *contractAddress = @"adxSBaWZYTqKdYdRikmboU6KFhW96QnemxuN3";
    // 0 means that the contract is only triggered
    int64_t amount = 0;
    // Contract main function entry
    NSString *input = @"";
    ContractInvokeByGasOperation *operation = [ContractInvokeByGasOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setContractAddress: contractAddress];
    [operation setAmount: amount];
    [operation setInput: input];
    [operation setMetadata: @"send gas and invoke contract"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbUFLEWrHdBKUCKJ9A63xLycv4TJKfdNCmbZUjJsav2c3fgMuFRLm";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = [self getAccountNonce : sourceAddress] + 1;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) callContract {
    ContractCallRequest *request = [ContractCallRequest new];
    [request setCode : @"\"use strict\";log(undefined);function query() { getBalance(thisAddress); }"];
    [request setFeeLimit : 1000000000];
    [request setOptType : 2];
    
    ContractService *service = [sdk getContractService];
    ContractCallResponse *response = [service call : request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getTransactionByHash {
    TransactionGetInfoRequest *request = [TransactionGetInfoRequest new];
    [request setHash: @"ff14a4c42447f9da8a2aca9152df630e864c18dba2d6098533c1d20ebf807aca"];
    
    TransactionService *service = [sdk getTransactionService];
    TransactionGetInfoResponse *response = [service getInfo: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) checkBlockStatus {
    BlockService *service = [sdk getBlockService];
    BlockCheckStatusResponse *response = [service checkStatus];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getTransactionsByBlockNumber {
    BlockGetTransactionsRequest *request = [BlockGetTransactionsRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [sdk getBlockService];
    BlockGetTransactionsResponse *response = [service getTransactions: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getLatestBlockNumber {
    BlockService *service = [sdk getBlockService];
    BlockGetNumberResponse *response = [service getNumber];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockInfo {
    BlockGetInfoRequest *request = [BlockGetInfoRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [sdk getBlockService];
    BlockGetInfoResponse *response = [service getInfo: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockLatestInfo {
    BlockService *service = [sdk getBlockService];
    BlockGetLatestInfoResponse *response = [service getLatestInfo];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockValidators {
    BlockGetValidatorsRequest *request = [BlockGetValidatorsRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [sdk getBlockService];
    BlockGetValidatorsResponse *response = [service getValidators: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getLatestBlockValidators {
    BlockService *service = [sdk getBlockService];
    BlockGetLatestValidatorsResponse *response = [service getLatestValidators];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockReward {
    BlockGetRewardRequest *request = [BlockGetRewardRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [sdk getBlockService];
    BlockGetRewardResponse *response = [service getReward: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockFees {
    BlockGetFeesRequest *request = [BlockGetFeesRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [sdk getBlockService];
    BlockGetFeesResponse *response = [service getFees: request];
     XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) getBlockLatestFees {
    BlockService *service = [sdk getBlockService];
    BlockGetLatestFeesResponse *response = [service getLatestFees];
    XCTAssert(response.errorCode == 0, @"%@", response.errorDesc);
}

- (void) buildBlobAndSignAndSubmit : (NSString *) privateKey : (NSString *) sourceAddress : (int64_t) nonce : (int64_t) gasPrice : (int64_t) feeLimit : (BaseOperation *)operation {
    TransactionBuildBlobRequest *buildBlobRequest = [TransactionBuildBlobRequest new];
    [buildBlobRequest setSourceAddress : sourceAddress];
    [buildBlobRequest setNonce : nonce];
    [buildBlobRequest setGasPrice : gasPrice];
    [buildBlobRequest setFeeLimit : feeLimit];
    [buildBlobRequest addOperation : operation];
    
    TransactionService *transactionServer = [sdk getTransactionService];
    TransactionBuildBlobResponse *buildBlobResponse = [transactionServer buildBlob : buildBlobRequest];
    XCTAssert(buildBlobResponse.errorCode == 0, @"%@", buildBlobResponse.errorDesc);
    
    TransactionSignRequest *signRequest = [TransactionSignRequest new];
    [signRequest setBlob : buildBlobResponse.result.transactionBlob];
    [signRequest addPrivateKey : privateKey];
    TransactionSignResponse * signResponse = [transactionServer sign : signRequest];
    XCTAssert(signResponse.errorCode == 0, @"%@", signResponse.errorDesc);
    
    TransactionSubmitRequest *submitRequest = [TransactionSubmitRequest new];
    [submitRequest setTransactionBlob : buildBlobResponse.result.transactionBlob];
    [submitRequest setSignatures : [signResponse.result.signatures copy]];
    TransactionSubmitResponse *submitResponse = [transactionServer submit : submitRequest];
    XCTAssert(submitResponse.errorCode == 0, @"%@", submitResponse.errorDesc);
    NSLog(@"The tx hash: %@", submitResponse.result.transactionHash);
}

- (int64_t) getAccountNonce  : (NSString *) address {
    AccountService *accountService = [sdk getAccountService];
    AccountGetNonceRequest * request = [AccountGetNonceRequest new];
    [request setAddress : address];
    AccountGetNonceResponse *response = [accountService getNonce : request];
    if (response.errorCode == 0) {
        return response.result.nonce;
    }
    return -1;
}


@end
