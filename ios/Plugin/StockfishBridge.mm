
#import <Foundation/Foundation.h>

#import "StockfishBridge.h"
#import "Stockfish.hpp"

@implementation StockfishBridge

- (void) start {
    CapacitorStockfish::init((__bridge void*)self);
}

- (void) cmd: (NSString*)command {
    CapacitorStockfish::cmd(std::string([command UTF8String]));
}
@end
