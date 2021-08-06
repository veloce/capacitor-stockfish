import { registerPlugin } from '@capacitor/core';

import type { StockfishPlugin } from './definitions';

const StockfishVariants = registerPlugin<StockfishPlugin>('Stockfish', {
  web: () => import('./web').then(m => new m.StockfishVariantsWeb()),
});

export * from './definitions';
export { StockfishVariants };
