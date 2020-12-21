#include "../../lib/threadbuf.h"
#include "../../stockfish/src/bitboard.h"
#include "../../stockfish/src/endgame.h"
#include "../../stockfish/src/position.h"
#include "../../stockfish/src/search.h"
#include "../../stockfish/src/thread.h"
#include "../../stockfish/src/tt.h"
#include "../../stockfish/src/uci.h"

#include "Stockfish.hpp"


namespace PSQT {
  void init();
}

namespace CapacitorStockfish
{
  static std::string CMD_EXIT = "stockfish:exit";

  auto readstdout = [](void *stockfish) {
    std::streambuf* out = std::cout.rdbuf();

    threadbuf lichbuf(8, 8096);
    std::ostream lichout(&lichbuf);
    std::cout.rdbuf(lichout.rdbuf());
    std::istream lichin(&lichbuf);

    std::string o = "";

    while(o != CMD_EXIT) {
      std::string line;
      std::getline(lichin, line);
      if(line != CMD_EXIT) {
        const char* coutput = line.c_str();
        //StockfishSendOutput(stockfish, coutput);
      } else {
        o = CMD_EXIT;
      }
    };

    // Restore output standard
    std::cout.rdbuf(out);

    lichbuf.close();
  };

  std::thread reader;

  void init(void *stockfish) {
    reader = std::thread(readstdout, stockfish);

    UCI::init(Options);
    Tune::init();
    PSQT::init();
    Bitboards::init();
    Position::init();
    Bitbases::init();
    Endgames::init();
    Threads.set(Options["Threads"]);
#ifdef USE_NNUE
    Eval::NNUE::init();
#endif
  }

  void cmd(std::string cmd) {
    UCI::command(cmd);
  }

  void exit() {
    sync_cout << CMD_EXIT << sync_endl;
    reader.join();
    Threads.set(0);
  }
}
