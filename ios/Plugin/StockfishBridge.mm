#include <string>
#import "StockfishBridge.h"
#import "Stockfish.hpp"

@implementation StockfishBridge

- (instancetype)initWithPlugin:(CAPPlugin *)plugin {
    self = [super init];
    if (self) {
        _plugin = plugin;
    }
    return self;
}

- (void) start {
    CapacitorStockfish::init((__bridge void*)self);
}

- (void) cmd: (NSString*)command {
    CapacitorStockfish::cmd(std::string([command UTF8String]));
}

- (void) exit {
    CapacitorStockfish::exit();
}

- (void) notifyListeners: (NSString*)output {
    NSDictionary *dict = @{ @"line" : output };
    [_plugin notifyListeners:@"output" data:dict retainUntilConsumed:YES];
}

void StockfishSendOutput (void *bridge, const char *output)
{
  [(__bridge id) bridge notifyListeners:[NSString stringWithUTF8String:output]];
}

@end
