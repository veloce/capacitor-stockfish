#ifndef Stockfish_hpp
#define Stockfish_hpp

#include <string>

namespace CapacitorStockfish {
void init(void *bridge);
void cmd(std::string cmd);
void exit();
}

#endif /* Stockfish_hpp */
