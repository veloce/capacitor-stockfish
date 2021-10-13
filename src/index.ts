import { registerPlugin } from '@capacitor/core';

import type { StockfishPlugin } from './definitions';

const StockfishVariants = registerPlugin<StockfishPlugin>('StockfishVariants');

export * from './definitions';
export { StockfishVariants };
