// n=4 c=3
// total variables: 54
// total constraints: 81
ring R = QQ[
    w0100, w0101, w0102, w0110, w0111, w0112, w0120, w0121, w0122,
    w0200, w0201, w0202, w0210, w0211, w0212, w0220, w0221, w0222,
    w0300, w0301, w0302, w0310, w0311, w0312, w0320, w0321, w0322,
    w1200, w1201, w1202, w1210, w1211, w1212, w1220, w1221, w1222,
    w1300, w1301, w1302, w1310, w1311, w1312, w1320, w1321, w1322,
    w2300, w2301, w2302, w2310, w2311, w2312, w2320, w2321, w2322];
ideal I =
  w0100*w2300 + w0200*w1300 + w0300*w1200 - 1,
  w0100*w2301 + w0200*w1301 + w0301*w1200,
  w0100*w2302 + w0200*w1302 + w0302*w1200,
  w0100*w2310 + w0201*w1300 + w0300*w1201,
  w0100*w2311 + w0201*w1301 + w0301*w1201,
  w0100*w2312 + w0201*w1302 + w0302*w1201,
  w0100*w2320 + w0202*w1300 + w0300*w1202,
  w0100*w2321 + w0202*w1301 + w0301*w1202,
  w0100*w2322 + w0202*w1302 + w0302*w1202,
  w0101*w2300 + w0200*w1310 + w0300*w1210,
  w0101*w2301 + w0200*w1311 + w0301*w1210,
  w0101*w2302 + w0200*w1312 + w0302*w1210,
  w0101*w2310 + w0201*w1310 + w0300*w1211,
  w0101*w2311 + w0201*w1311 + w0301*w1211,
  w0101*w2312 + w0201*w1312 + w0302*w1211,
  w0101*w2320 + w0202*w1310 + w0300*w1212,
  w0101*w2321 + w0202*w1311 + w0301*w1212,
  w0101*w2322 + w0202*w1312 + w0302*w1212,
  w0102*w2300 + w0200*w1320 + w0300*w1220,
  w0102*w2301 + w0200*w1321 + w0301*w1220,
  w0102*w2302 + w0200*w1322 + w0302*w1220,
  w0102*w2310 + w0201*w1320 + w0300*w1221,
  w0102*w2311 + w0201*w1321 + w0301*w1221,
  w0102*w2312 + w0201*w1322 + w0302*w1221,
  w0102*w2320 + w0202*w1320 + w0300*w1222,
  w0102*w2321 + w0202*w1321 + w0301*w1222,
  w0102*w2322 + w0202*w1322 + w0302*w1222,
  w0110*w2300 + w0210*w1300 + w0310*w1200,
  w0110*w2301 + w0210*w1301 + w0311*w1200,
  w0110*w2302 + w0210*w1302 + w0312*w1200,
  w0110*w2310 + w0211*w1300 + w0310*w1201,
  w0110*w2311 + w0211*w1301 + w0311*w1201,
  w0110*w2312 + w0211*w1302 + w0312*w1201,
  w0110*w2320 + w0212*w1300 + w0310*w1202,
  w0110*w2321 + w0212*w1301 + w0311*w1202,
  w0110*w2322 + w0212*w1302 + w0312*w1202,
  w0111*w2300 + w0210*w1310 + w0310*w1210,
  w0111*w2301 + w0210*w1311 + w0311*w1210,
  w0111*w2302 + w0210*w1312 + w0312*w1210,
  w0111*w2310 + w0211*w1310 + w0310*w1211,
  w0111*w2311 + w0211*w1311 + w0311*w1211 - 1,
  w0111*w2312 + w0211*w1312 + w0312*w1211,
  w0111*w2320 + w0212*w1310 + w0310*w1212,
  w0111*w2321 + w0212*w1311 + w0311*w1212,
  w0111*w2322 + w0212*w1312 + w0312*w1212,
  w0112*w2300 + w0210*w1320 + w0310*w1220,
  w0112*w2301 + w0210*w1321 + w0311*w1220,
  w0112*w2302 + w0210*w1322 + w0312*w1220,
  w0112*w2310 + w0211*w1320 + w0310*w1221,
  w0112*w2311 + w0211*w1321 + w0311*w1221,
  w0112*w2312 + w0211*w1322 + w0312*w1221,
  w0112*w2320 + w0212*w1320 + w0310*w1222,
  w0112*w2321 + w0212*w1321 + w0311*w1222,
  w0112*w2322 + w0212*w1322 + w0312*w1222,
  w0120*w2300 + w0220*w1300 + w0320*w1200,
  w0120*w2301 + w0220*w1301 + w0321*w1200,
  w0120*w2302 + w0220*w1302 + w0322*w1200,
  w0120*w2310 + w0221*w1300 + w0320*w1201,
  w0120*w2311 + w0221*w1301 + w0321*w1201,
  w0120*w2312 + w0221*w1302 + w0322*w1201,
  w0120*w2320 + w0222*w1300 + w0320*w1202,
  w0120*w2321 + w0222*w1301 + w0321*w1202,
  w0120*w2322 + w0222*w1302 + w0322*w1202,
  w0121*w2300 + w0220*w1310 + w0320*w1210,
  w0121*w2301 + w0220*w1311 + w0321*w1210,
  w0121*w2302 + w0220*w1312 + w0322*w1210,
  w0121*w2310 + w0221*w1310 + w0320*w1211,
  w0121*w2311 + w0221*w1311 + w0321*w1211,
  w0121*w2312 + w0221*w1312 + w0322*w1211,
  w0121*w2320 + w0222*w1310 + w0320*w1212,
  w0121*w2321 + w0222*w1311 + w0321*w1212,
  w0121*w2322 + w0222*w1312 + w0322*w1212,
  w0122*w2300 + w0220*w1320 + w0320*w1220,
  w0122*w2301 + w0220*w1321 + w0321*w1220,
  w0122*w2302 + w0220*w1322 + w0322*w1220,
  w0122*w2310 + w0221*w1320 + w0320*w1221,
  w0122*w2311 + w0221*w1321 + w0321*w1221,
  w0122*w2312 + w0221*w1322 + w0322*w1221,
  w0122*w2320 + w0222*w1320 + w0320*w1222,
  w0122*w2321 + w0222*w1321 + w0321*w1222,
  w0122*w2322 + w0222*w1322 + w0322*w1222 - 1;
option(redSB);
option(prot);
ideal subI = ideal(w1212);
matrix T; // ?? not sure why it needs this extra matrix
matrix T2 = lift(I, subI, T, "slimgb");
T;
T2;
