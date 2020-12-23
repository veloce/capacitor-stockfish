#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>
#import "Plugin.h"
#import "Stockfish.hpp"

@implementation Stockfish

NSNumber *isInit = @FALSE;

- (void) start:(CAPPluginCall *)call {
    if (![isInit boolValue]) {
      CapacitorStockfish::init((__bridge void*)self);
      isInit = @TRUE;
    }
    CAPPluginCallResult *result = [[CAPPluginCallResult alloc] init:[NSDictionary dictionary]];

    call.successHandler(result, call);
}

- (void) cmd: (CAPPluginCall*)call {
    if ([isInit boolValue]) {
        NSString* command = [self getString:call field:@"cmd" defaultValue: @""];
        if (command != nil) {
            CapacitorStockfish::cmd(std::string([command UTF8String]));
            CAPPluginCallResult *result = [[CAPPluginCallResult alloc] init:[NSDictionary dictionary]];

            call.successHandler(result, call);
        } else {
            CAPPluginCallError *error = [[CAPPluginCallError alloc] initWithMessage:@"Must supply cmd" code:nil error:nil data:nil];
            call.errorHandler(error);
        }
    } else {
        CAPPluginCallError *error = [[CAPPluginCallError alloc] initWithMessage:@"Please call start before anything else." code:nil error:nil data:nil];
        call.errorHandler(error);
    }
}

- (void) exit: (CAPPluginCall*)call {
    if ([isInit boolValue]) {
        CapacitorStockfish::cmd("quit");
        CapacitorStockfish::exit();
        isInit = @FALSE;
    }
    CAPPluginCallResult *result = [[CAPPluginCallResult alloc] init:[NSDictionary dictionary]];

    call.successHandler(result, call);
}

- (void) notifyListeners: (NSString*)output {
    NSDictionary *dict = @{ @"line" : output };
    [self notifyListeners:@"output" data:dict retainUntilConsumed:YES];
}

void StockfishSendOutput (void *bridge, const char *output)
{
  [(__bridge id) bridge notifyListeners:[NSString stringWithUTF8String:output]];
}

@end
