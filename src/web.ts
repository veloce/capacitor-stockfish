import { WebPlugin } from '@capacitor/core';
import { StockfishPlugin } from './definitions';

export class StockfishWeb extends WebPlugin implements StockfishPlugin {
  constructor() {
    super({
      name: 'Stockfish',
      platforms: ['web'],
    });
  }

  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}

const Stockfish = new StockfishWeb();

export { Stockfish };

import { registerWebPlugin } from '@capacitor/core';
registerWebPlugin(Stockfish);
