//
//  ViewController.m
//  examples
//
//  Created by dxl on 2018/8/8.
//  Copyright © 2018 dxl. All rights reserved.
//

#import "ViewController.h"
#import <sdk_ios.framework/Headers/sdk_ios.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self getTransactionCacheByHash];
}

- (void) testRegex_Int64Max {
    NSString *temp2 = @"92233720368.54775807"; // 待检测的字符串
    int decimals = 8;
    NSString *ugas = [[Tools unitWithDecimals: temp2 :decimals] stringValue];
    NSLog(@"%@", ugas);
    NSLog(@"%@", [[Tools ToUGas: temp2] stringValue]);
    NSString *gas = [[Tools unitWithoutDecimals:ugas :8] stringValue];
    NSLog(@"%@", gas);
    NSLog(@"%@", [[Tools ToGas: ugas] stringValue]);
}

- (void) testMnemonicCodeAndKeyStore {
    NSString *password = @"huoss910926";
    NSString *mnemonicCodeStr = @"bundle swim distance spirit cactus piece want famous blame chat benefit test";
    NSArray * words1 = [mnemonicCodeStr componentsSeparatedByString:@" "];
    NSData * random = [Mnemonic randomFromMnemonicCode: words1];
    NSArray * words = [Mnemonic generateMnemonicCode: [random copy]];
    NSLog(@"%@", [words componentsJoinedByString:@" "]);
    // 身份账户、钱包账户
    NSMutableArray * hdPaths = [NSMutableArray arrayWithObjects:@"M/44H/526H/0H/0/0", @"M/44H/526H/1H/0/0", nil];
    NSArray *privateKeys = [Mnemonic generatePrivateKeys: words : hdPaths];
    NSLog(@"%@", privateKeys);
    // 随机数data -> 随机数字符串
    //        NSString * randomNumber  = [Tools dataToHexStr: random];
    // 存储随机数、身份账户、钱包账户、创建身份成功
    NSString * randomKey = [[KeyStore generateKeyStoreFromData:[password dataUsingEncoding: NSUTF8StringEncoding] Data:random :2] yy_modelToJSONString];
    NSLog(@"randomKey: %@", randomKey);
    // 私钥 -> 地址
    NSString *publicKey = [Keypair getEncPublicKey: [privateKeys firstObject]];
    NSString * identityAddress = [Keypair getEncAddress : publicKey];
    NSLog(@"identityAddress: %@", identityAddress);
    NSString * identityKey = [[KeyStore generateKeyStore:[password dataUsingEncoding: NSUTF8StringEncoding] PrivateKey:[privateKeys firstObject] :2] yy_modelToJSONString];
    NSLog(@"identityKey: %@", identityKey);
    NSString *identityPrivateKey = [KeyStore decipherKeyStore: [KeyStoreEty yy_modelWithJSON:identityKey] : [password dataUsingEncoding: NSUTF8StringEncoding]];
    NSLog(@"identityPrivateKey: %@", identityPrivateKey);
    
    NSString * purseAddress = [Keypair getEncAddress : [Keypair getEncPublicKey: [privateKeys lastObject]]];
    NSLog(@"purseAddress: %@", purseAddress);
    NSString * purseKey = [[KeyStore generateKeyStore:[password dataUsingEncoding: NSUTF8StringEncoding] PrivateKey:[privateKeys lastObject] :2] yy_modelToJSONString];
    NSLog(@"purseKey: %@", purseKey);
    NSString *pursePrivateKey = [KeyStore decipherKeyStore: [KeyStoreEty yy_modelWithJSON:purseKey] : [password dataUsingEncoding: NSUTF8StringEncoding]];
    NSLog(@"pursePrivateKey: %@", pursePrivateKey);
}

- (void) generateKeyStore_data {
    for (int i = 0; i < 100; i++) {
        // generate random
        NSMutableData *random = [NSMutableData dataWithLength: 16];
        int status = SecRandomCopyBytes(kSecRandomDefault, random.length, random.mutableBytes);
        if (status == 0) {
            NSLog(@"%@", [Tools dataToHexStr: [random copy]]);
            NSData *password = [@"test1234" dataUsingEncoding : NSUTF8StringEncoding];
            KeyStoreEty *keyStoreEty = [KeyStore generateKeyStoreFromData:password Data:[random copy] :2];
            if (![Tools isEmpty : keyStoreEty]) {
                NSString *keyStoreValueStr = [keyStoreEty yy_modelToJSONString];
                //NSLog(@"%@", keyStoreValueStr);
                NSData *data = [KeyStore decipherKeyStoreWithData: [KeyStoreEty yy_modelWithJSON:keyStoreValueStr] : [@"test1234" dataUsingEncoding : NSUTF8StringEncoding]];
                NSLog(@"%@", [Tools dataToHexStr: data]);
            }
        }
    }
}

- (void) generateKeyStore_privateKey {
    for (int i = 0; i < 100; i++) {
        // generate random
        NSMutableData *random = [NSMutableData dataWithLength: 32];
        int status = SecRandomCopyBytes(kSecRandomDefault, random.length, random.mutableBytes);
        if (status == 0) {
            //NSString *encPrivateKey = @"privbtGQELqNswoyqgnQ9tcfpkuH8P1Q6quvoybqZ9oTVwWhS6Z2hi1B";
            Keypair *keyPair = [[Keypair alloc] initWithData: random];
            NSString *encPrivateKey = [keyPair getEncPrivateKey];
            NSLog(@"%@", encPrivateKey);
            NSData *password = [@"test1234" dataUsingEncoding : NSUTF8StringEncoding];
            KeyStoreEty *keyStoreEty = [KeyStore generateKeyStore:password PrivateKey:encPrivateKey :2];
            if (![Tools isEmpty : keyStoreEty]) {
                NSString *keyStoreEtyStr = [keyStoreEty yy_modelToJSONString];
                //NSLog(@"%@", keyStoreEtyStr);
                NSString *privateKey = [KeyStore decipherKeyStore: [KeyStoreEty yy_modelWithJSON:keyStoreEtyStr] : password];
                NSLog(@"%@", privateKey);
            }
        }
    }
}

- (void) generateMnemonicCode {
    // generate random
    NSMutableData *random = [NSMutableData dataWithLength: 16];
    int status = SecRandomCopyBytes(kSecRandomDefault, random.length, random.mutableBytes);
    if (status == 0) {
        NSLog(@"%@", [Tools dataToHexStr: random]);
        NSArray * words = [Mnemonic generateMnemonicCode: [random copy]];
        NSLog(@"%@", [words componentsJoinedByString:@" "]);
        
        NSData *random2 = [Mnemonic randomFromMnemonicCode: words];
        NSLog(@"%@", [Tools dataToHexStr: random2]);
    
        NSMutableArray *hdPaths = [NSMutableArray new];
        [hdPaths addObject: @"M/44H/80H/0H/0/1"];
        NSArray *privateKeys = [Mnemonic generatePrivateKeys: words : hdPaths];
        for (NSString *privateKey in privateKeys) {
            NSLog(@"privateKeys: %@", privateKey);
        }
    }
}

- (void) checkAccountValid {
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getAccountService];
    AccountCheckValidRequest *request = [AccountCheckValidRequest new];
    [request setAddress:@""];
    AccountCheckValidResponse *response = [accountService checkValid: nil];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) createNewAccount {
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getAccountService];
    AccountCreateResponse *response = [accountService create];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAccountInfo {
    NSString *address = @"adxSnR9FoSRnezU4rD2oBdcHCQbN9pLXK3Lrw";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getAccountService];
    AccountGetInfoRequest *request = [AccountGetInfoRequest new];
    [request setAddress : address];
    AccountGetInfoResponse *response = [accountService getInfo : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAccountNonce {
    NSString *address = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getAccountService];
    AccountGetNonceRequest * request = [AccountGetNonceRequest new];
    [request setAddress : address];
    AccountGetNonceResponse *response = [accountService getNonce : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAccountBalance {
    NSString *address = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getAccountService];
    AccountGetBalanceRequest * request = [AccountGetBalanceRequest new];
    [request setAddress : address];
    AccountGetBalanceResponse *response = [accountService getBalance : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAccountAssets {
    NSString *address = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getAccountService];
    AccountGetAssetsRequest * request = [AccountGetAssetsRequest new];
    [request setAddress : address];
    AccountGetAssetsResponse *response = [accountService getAssets : request];
    if (response.errorCode == 0) {
        //AssetInfo *assetInfo = [response.result.assets objectAtIndex : 0];
        //NSLog(@"%@, %@", assetInfo.key.code, assetInfo.key.issuer);
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAccountMetadata {
    NSString *address = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getAccountService];
    AccountGetMetadataRequest * request = [AccountGetMetadataRequest new];
    [request setAddress : address];
    AccountGetMetadataResponse *response = [accountService getMetadata : request];
    if (response.errorCode == 0) {
        //MetadataInfo *metadataInfo = [response.result.metadatas objectAtIndex:0];
        //NSLog(@"%@, %@. %lld", metadataInfo.key, metadataInfo.value, metadataInfo.version);
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) getAssetInfo {
    NSString *address = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    NSString *code = @"TST";
    NSString *issuer = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    AssetGetInfoRequest *request = [AssetGetInfoRequest new];
    [request setAddress : address];
    [request setCode : code];
    [request setIssuer : issuer];
    
    AssetService *assetService = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getAssetService];
    AssetGetInfoResponse *response = [assetService getInfo : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    } else {
        NSLog(@"%@", response.errorDesc);
    }
}

- (void) activateAccount {
    AccountService *accountService = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getAccountService];
    // Create an inactive account
    AccountCreateResponse *activateResponse = [accountService create];
    if (activateResponse.errorCode == 0) {
        NSLog(@"activate response: %@", [activateResponse yy_modelToJSONString]);
    } else {
        NSLog(@"%@", activateResponse.errorDesc);
        return;
    }
    // Build AccountActivateOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    NSString *destAddress = activateResponse.result.address;
    int64_t initBalance = 10000000;
    AccountActivateOperation *operation = [AccountActivateOperation new];
    [operation setSourceAddress : sourceAddress];
    [operation setDestAddress : destAddress];
    [operation setInitBalance : initBalance];
    [operation setMetadata : @"activate account"];

    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 68;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) setAccountMetadata {
    // Build AccountSetMetadataOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    NSString *key = @"setMetadataTest";
    NSString *value = @"201808";
    AccountSetMetadataOperation *operation = [AccountSetMetadataOperation new];
    [operation setSourceAddress : sourceAddress];
    [operation setKey : key];
    [operation setValue : value];
    [operation setMetadata : @"activate account"];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 73;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) setAccountPrivilege {
    // Build AccountSetPrivilegeOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    AccountSetPrivilegeOperation *operation = [AccountSetPrivilegeOperation new];
    [operation setSourceAddress : sourceAddress];
    SignerInfo *signer = [SignerInfo new];
    [signer setAddress : @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd"];
    [signer setWeight : 2];
    [operation addSigner : signer];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 74;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) issueAsset {
    // Build AssetIssueOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // Asset code
    NSString *code = @"RV";
    // Asset amount
    int64_t amount = 9223372036854775807;
    AssetIssueOperation *operation = [AssetIssueOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setCode: code];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 75;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) sendAsset {
    // Build AssetSendOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // Destination account
    NSString *destAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // Asset code
    NSString *code = @"TST";
    // Asset issuer
    NSString *issuer = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // Asset amount
    int64_t amount = 100000;
    AssetSendOperation *operation = [AssetSendOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDestAddress: destAddress];
    [operation setCode: code];
    [operation setIssuer: issuer];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 75;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) sendGas {
    // Build GasSendOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // Destination account
    NSString *destAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // Gas amount
    int64_t amount = 1000000;
    GasSendOperation *operation = [GasSendOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDestAddress: destAddress];
    [operation setAmount: amount];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 75;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) checkContractValid {
    ContractCheckValidRequest *request = [ContractCheckValidRequest new];
    [request setContractAddress: @"adxSqKcX8wGCMKhzNUBoDWfbeQaMhfnGdtyG2"];
    
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getContractService];
    ContractCheckValidResponse *response = [service checkValid: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getContractInfo {
    ContractGetInfoRequest *request = [ContractGetInfoRequest new];
    [request setContractAddress: @"adxSqKcX8wGCMKhzNUBoDWfbeQaMhfnGdtyG2"];
    
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getContractService];
    ContractGetInfoResponse *response = [service getInfo: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getContractAddress {
    ContractGetAddressRequest *request = [ContractGetAddressRequest new];
    [request setHash: @"44246c5ba1b8b835a5cbc29bdc9454cdb9a9d049870e41227f2dcfbcf7a07689"];
    
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getContractService];
    ContractGetAddressResponse *response = [service getAddress: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) callContract {
    ContractCallRequest *request = [ContractCallRequest new];
    [request setCode : @"\"use strict\";log(undefined);function query() { getBalance(thisAddress); }"];
    [request setFeeLimit : 1000000000];
    [request setOptType : 2];
    
    ContractService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getContractService];
    ContractCallResponse *response = [service call : request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) createContract {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // Contract account initialization Gas，the unit is UGas，and 1 Gas = 10^8 UGas
    int64_t initBalance = [[Tools ToUGas: @"0.01"] longLongValue];
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
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    //[self testBuildBlob :sourceAddress :nonce :gasPrice :feeLimit :operation];
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) invokeContractByAsset {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // The account to receive the assets
    NSString *contractAddress = @"adxSqKcX8wGCMKhzNUBoDWfbeQaMhfnGdtyG2";
    // The asset code to be sent
    NSString *assetCode = @"TST";
    // The account address to issue asset
    NSString *assetIssuer = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
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
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) invokeContractByGas {
    // Build ContractCreateOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // The account to receive the assets
    NSString *contractAddress = @"adxSqKcX8wGCMKhzNUBoDWfbeQaMhfnGdtyG2";
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
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 78;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) getTransactionByHash {
    TransactionGetInfoRequest *request = [TransactionGetInfoRequest new];
    [request setHash: @"ff14a4c42447f9da8a2aca9152df630e864c18dba2d6098533c1d20ebf807aca"];
    
    TransactionService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getTransactionService];
    TransactionGetInfoResponse *response = [service getInfo: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getTransactionCacheByHash {
    TransactionGetCacheRequest *request = [TransactionGetCacheRequest new];
    //[request setHash: @"ff14a4c42447f9da8a2aca9152df630e864c18dba2d6098533c1d20ebf807aca"];
    
    TransactionService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getTransactionService];
    TransactionGetCacheResponse *response = [service getCache: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) checkBlockStatus {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
    BlockCheckStatusResponse *response = [service checkStatus];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getTransactionsByBlockNumber {
    BlockGetTransactionsRequest *request = [BlockGetTransactionsRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
    BlockGetTransactionsResponse *response = [service getTransactions: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getLatestBlockNumber {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
    BlockGetNumberResponse *response = [service getNumber];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getBlockInfo {
    BlockGetInfoRequest *request = [BlockGetInfoRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
    BlockGetInfoResponse *response = [service getInfo: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getBlockLatestInfo {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
    BlockGetLatestInfoResponse *response = [service getLatestInfo];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getBlockValidators {
    BlockGetValidatorsRequest *request = [BlockGetValidatorsRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
    BlockGetValidatorsResponse *response = [service getValidators: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getLatestBlockValidators {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
    BlockGetLatestValidatorsResponse *response = [service getLatestValidators];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

//- (void) getBlockReward {
//    BlockGetRewardRequest *request = [BlockGetRewardRequest new];
//    [request setBlockNumber: 617247];
//
//    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
//    BlockGetRewardResponse *response = [service getReward: request];
//    if (response.errorCode == 0) {
//        NSLog(@"%@", [response.result yy_modelToJSONString]);
//    }
//    else {
//        NSLog(@"error: %@", response.errorDesc);
//    }
//}
//
//- (void) getLatestBlockReward {
//    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
//    BlockGetLatestRewardResponse *response = [service getLatestReward];
//    if (response.errorCode == 0) {
//        NSLog(@"%@", [response.result yy_modelToJSONString]);
//    }
//    else {
//        NSLog(@"error: %@", response.errorDesc);
//    }
//}

- (void) getBlockFees {
    BlockGetFeesRequest *request = [BlockGetFeesRequest new];
    [request setBlockNumber: 617247];
    
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
    BlockGetFeesResponse *response = [service getFees: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) getBlockLatestFees {
    BlockService *service = [[[SDK sharedInstance] setUrl: @"http://seed1-node.bubi.cn"] getBlockService];
    BlockGetLatestFeesResponse *response = [service getLatestFees];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) createLog {
    // Build LogCreateOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // The topic
    NSString *topic = @"hello";
    // The datas
    NSString *data1 = @"world";
    NSString *data2 = @"riven";

    LogCreateOperation *operation = [LogCreateOperation new];
    [operation setTopic:topic];
    [operation addData: data1];
    [operation addData: data2];
    
    // Build blob, sign and submit transaction
    NSString *privateKey = @"privbyQCRp7DLqKtRFCqKQJr81TurTqG6UKXMMtGAmPG3abcM9XHjWvq";
    int64_t gasPrice = 1000;
    int64_t feeLimit = 1000000;
    int64_t nonce = 128;
    [self buildBlobAndSignAndSubmit:privateKey :sourceAddress :nonce :gasPrice :feeLimit :operation];
}

- (void) parseTransactionBlob {
    NSString *transactionBlob = @"0a246275516e6e5545425245773268423670574847507a77616e5837643238786b364b566370104e18c0843d20e8073aab04080112246275516e6e5545425245773268423670574847507a77616e5837643238786b364b5663701a0f63726561746520636f6e747261637422ef0312e20312df030a202020202020202020202275736520737472696374223b0a2020202020202020202066756e6374696f6e20696e697428626172290a202020202020202020207b0a2020202020202020202020202f2a696e697420776861746576657220796f752077616e742a2f0a20202020202020202020202072657475726e3b0a202020202020202020207d0a202020202020202020200a2020202020202020202066756e6374696f6e206d61696e28696e707574290a202020202020202020207b0a2020202020202020202020206c65742070617261203d204a534f4e2e706172736528696e707574293b0a20202020202020202020202069662028706172612e646f5f666f6f290a2020202020202020202020207b0a20202020202020202020202020206c65742078203d207b0a202020202020202020202020202020202768656c6c6f27203a2027776f726c64270a20202020202020202020202020207d3b0a2020202020202020202020207d0a202020202020202020207d0a202020202020202020200a2020202020202020202066756e6374696f6e20717565727928696e707574290a202020202020202020207b200a20202020202020202020202072657475726e20696e7075743b0a202020202020202020207d0a20202020202020201a041a02080128c0843d400a";
    TransactionParseBlobRequest *request = [TransactionParseBlobRequest new];
    [request setBlob: transactionBlob];
    TransactionService *transactionServer = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getTransactionService];
    TransactionParseBlobResponse *response = [transactionServer parseBlob: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) evaluateSendBuFees {
    // Build GasSendOperation
    NSString *sourceAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // Destination account
    NSString *destAddress = @"adxSYvndiFG4zpbLGugX3j93fDn9nWZfWp8Gd";
    // Gas amount
    int64_t amount = 1000000;
    GasSendOperation *operation = [GasSendOperation new];
    [operation setSourceAddress: sourceAddress];
    [operation setDestAddress: destAddress];
    [operation setAmount: amount];
    int64_t nonce = 128;
    int32_t signatureNUM = 1;
    [self evaluateFees: sourceAddress : nonce : signatureNUM : operation];
}

- (void) evaluateFees: (NSString *) sourceAddress : (int64_t) nonce : (int32_t) signatureNum : (BaseOperation *)operation {
    TransactionEvaluateFeeRequest *request = [TransactionEvaluateFeeRequest new];
    [request setSourceAddress: sourceAddress];
    [request setNonce: nonce];
    [request setSignatureNumber: signatureNum];
    [request addOperation: operation];
    TransactionService *transactionServer = [[[SDK sharedInstance] setUrl:@"http://seed1-node.bubi.cn"] getTransactionService];
    TransactionEvaluateFeeResponse *response = [transactionServer evaluateFee: request];
    if (response.errorCode == 0) {
        NSLog(@"%@", [response.result yy_modelToJSONString]);
    }
    else {
        NSLog(@"error: %@", response.errorDesc);
    }
}

- (void) testBuildBlob : (NSString *) sourceAddress : (int64_t) nonce : (int64_t) gasPrice : (int64_t) feeLimit : (BaseOperation *)operation {
    TransactionBuildBlobRequest *buildBlobRequest = [TransactionBuildBlobRequest new];
    [buildBlobRequest setSourceAddress : sourceAddress];
    [buildBlobRequest setNonce : nonce];
    [buildBlobRequest setGasPrice : gasPrice];
    [buildBlobRequest setFeeLimit : feeLimit];
    [buildBlobRequest addOperation : operation];
    
    // set configure
    SDKConfigure *sdkConfigure = [SDKConfigure new];
    [sdkConfigure setTimeOut: 60];
    [sdkConfigure setChainId: 10];
    TransactionService *transactionServer = [[[[SDK sharedInstance]
                                               setUrl:@"http://seed1-node.bubi.cn"]
                                              setConfigure: sdkConfigure]
                                             getTransactionService];
    TransactionBuildBlobResponse *buildBlobResponse = [transactionServer buildBlob : buildBlobRequest];
    if (buildBlobResponse.errorCode == 0) {
        NSLog(@"blob: %@, hash: %@", buildBlobResponse.result.transactionBlob, buildBlobResponse.result.transactionHash);
    } else {
        NSLog(@"error: %@", buildBlobResponse.errorDesc);
        return;
    }
}

- (void) buildBlobAndSignAndSubmit : (NSString *) privateKey : (NSString *) sourceAddress : (int64_t) nonce : (int64_t) gasPrice : (int64_t) feeLimit : (BaseOperation *)operation {
    TransactionBuildBlobRequest *buildBlobRequest = [TransactionBuildBlobRequest new];
    [buildBlobRequest setSourceAddress : sourceAddress];
    [buildBlobRequest setNonce : nonce];
    [buildBlobRequest setGasPrice : gasPrice];
    [buildBlobRequest setFeeLimit : feeLimit];
    [buildBlobRequest addOperation : operation];
    
    // set configure
    SDKConfigure *sdkConfigure = [SDKConfigure new];
    [sdkConfigure setTimeOut: 60];
    [sdkConfigure setChainId: 10];
    TransactionService *transactionServer = [[[[SDK sharedInstance]
                                               setUrl:@"http://seed1-node.bubi.cn"]
                                               setConfigure: sdkConfigure]
                                               getTransactionService];
    TransactionBuildBlobResponse *buildBlobResponse = [transactionServer buildBlob : buildBlobRequest];
    if (buildBlobResponse.errorCode == 0) {
        NSLog(@"blob: %@, hash: %@", buildBlobResponse.result.transactionBlob, buildBlobResponse.result.transactionHash);
    } else {
        NSLog(@"error: %@", buildBlobResponse.errorDesc);
        return;
    }
    
    TransactionSignRequest *signRequest = [TransactionSignRequest new];
    [signRequest setBlob : buildBlobResponse.result.transactionBlob];
    [signRequest addPrivateKey : privateKey];
    TransactionSignResponse * signResponse = [transactionServer sign : signRequest];
    if (signResponse.errorCode == 0) {
        NSLog(@"sign response: %@", [signResponse yy_modelToJSONString]);
    } else {
        NSLog(@"error: %@", signResponse.errorDesc);
        return;
    }
    
    TransactionSubmitRequest *submitRequest = [TransactionSubmitRequest new];
    [submitRequest setTransactionBlob : buildBlobResponse.result.transactionBlob];
    [submitRequest setSignatures : [signResponse.result.signatures copy]];
    TransactionSubmitResponse *submitResponse = [transactionServer submit : submitRequest];
    if (submitResponse.errorCode == 0) {
        NSLog(@"submit response: %@", [submitResponse yy_modelToJSONString]);
    } else {
        NSLog(@"error: %@", submitResponse.errorDesc);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
