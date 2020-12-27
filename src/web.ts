import { WebPlugin } from '@capacitor/core';
import { StockfishPlugin } from './definitions';

export class StockfishWeb extends WebPlugin implements StockfishPlugin {
  constructor() {
    super({
      name: 'Stockfish',
      platforms: ['web'],
    });
  }

  async getMaxMemory(): Promise<number> {
    console.log('getMaxMemory');
    return 0
  }

  async start(): Promise<void> {
    console.log('start');
  }

  async cmd(options: { cmd: string }): Promise<void> {
    console.log('cmd', options.cmd);
  }

  async exit(): Promise<void> {
    console.log('exit');
  }
}

const Stockfish = new StockfishWeb();

export { Stockfish };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(Stockfish);
