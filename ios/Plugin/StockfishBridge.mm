#include <string>
#import "StockfishBridge.h"
#import "Stockfish.hpp"

@implementation StockfishBridge

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
    // todo
}

void StockfishSendOutput (void *bridge, const char *output)
{
  [(__bridge id) bridge notifyListeners:[NSString stringWithUTF8String:output]];
}

@end
