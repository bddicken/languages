import { readFileSync } from 'node:fs';

const { instance: { exports } } = await WebAssembly.instantiate(
  readFileSync(`${import.meta.dirname}/code.wasm`),
  {
    env: {
      abort() {},
      seed() {},
      memory: new WebAssembly.Memory({
        initial: 0
      }),
    },
  },
);

console.log(exports.fibonacci(Number(process.argv[2])));
