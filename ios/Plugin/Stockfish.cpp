#include <iostream>
#include "bitboard.h"
#include "endgame.h"
#include "position.h"
#include "search.h"
#include "thread.h"
#include "tt.h"
#include "uci.h"
#include "tbprobe.h"
#include "threadbuf.h"
#include "Stockfish.hpp"
#include "StockfishSendOutput.h"

namespace PSQT {
  void init();
}

namespace CapacitorStockfish
{
  static std::string CMD_EXIT = "stockfish:exit";

  auto readstdout = [](void *bridge) {
    std::streambuf* out = std::cout.rdbuf();

    threadbuf lichbuf(8, 8096);
    std::ostream lichout(&lichbuf);
    std::cout.rdbuf(lichout.rdbuf());
    std::istream lichin(&lichbuf);

    std::string o = "";

    while (o != CMD_EXIT) {
      std::string line;
      std::getline(lichin, line);
      if (line != CMD_EXIT) {
        const char* coutput = line.c_str();
        StockfishSendOutput(bridge, coutput);
      } else {
        o = CMD_EXIT;
      }
    };

    // Restore output standard
    std::cout.rdbuf(out);

    lichbuf.close();
  };

  std::thread reader;

  void init(void *bridge) {
    reader = std::thread(readstdout, bridge);

    UCI::init(Options);
    Tune::init();
    PSQT::init();
    Bitboards::init();
    Position::init();
    Bitbases::init();
    Endgames::init();
    Threads.set(size_t(Options["Threads"]));
    Search::clear(); // After threads are up
#ifdef USE_NNUE
    Eval::NNUE::init();
#endif

  }

  void cmd(std::string cmd) {
    UCI::command(cmd);
  }

  void exit() {
    UCI::command("quit");
    sync_cout << CMD_EXIT << sync_endl;
    reader.join();
    Threads.set(0);
  }
}

