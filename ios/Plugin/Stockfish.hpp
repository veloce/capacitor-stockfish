#ifndef Stockfish_hpp
#define Stockfish_hpp

#include <string>

namespace CapacitorStockfishVariants {
void init(void *stockfish);
void cmd(std::string cmd);
void exit();
}

#endif /* Stockfish_hpp */
