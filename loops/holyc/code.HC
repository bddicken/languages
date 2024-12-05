U0 Main(U32 n) {
  U32 r = RandU32 % 10000;
  U32 *a = MAlloc(sizeof(U32)) * 10000);
  U32 i;
  U32 j;
  for (i = 0; i < 10000; ++i) {
    for (j = 0; j < 100000; ++j) {
      a[i] = a[i] + (j % n);
    }
    a[i] = a[i] + r;
  }
  "%d\n",a[r];
  Free(a);
}

Main(10);
