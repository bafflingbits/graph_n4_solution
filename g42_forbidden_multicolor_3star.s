// n=4 c=2
// total variables: 24
// total constraints: 16
ring R = QQ[
    w0100, w0101, w0110, w0111,
    w0200, w0201, w0210, w0211,
    w0300, w0301, w0310, w0311,
    w1200, w1201, w1210, w1211,
    w1300, w1301, w1310, w1311,
    w2300, w2301, w2310, w2311];
ideal I =
  w0100*w2300 + w0200*w1300 + w0300*w1200 - 1,
  w0100*w2301 + w0200*w1301 + w0301*w1200,
  w0100*w2310 + w0201*w1300 + w0300*w1201,
  w0100*w2311 + w0201*w1301 + w0301*w1201,
  w0101*w2300 + w0200*w1310 + w0300*w1210,
  w0101*w2301 + w0200*w1311 + w0301*w1210,
  w0101*w2310 + w0201*w1310 + w0300*w1211,
  w0101*w2311 + w0201*w1311 + w0301*w1211,
  w0110*w2300 + w0210*w1300 + w0310*w1200,
  w0110*w2301 + w0210*w1301 + w0311*w1200,
  w0110*w2310 + w0211*w1300 + w0310*w1201,
  w0110*w2311 + w0211*w1301 + w0311*w1201,
  w0111*w2300 + w0210*w1310 + w0310*w1210,
  w0111*w2301 + w0210*w1311 + w0311*w1210,
  w0111*w2310 + w0211*w1310 + w0310*w1211,
  w0111*w2311 + w0211*w1311 + w0311*w1211 - 1;
//option(redSB);
//option(prot); // show progress/debug output
ideal subI = ideal(w0101*w0201*w0301);
matrix T;
matrix T2 = lift(I, subI, T, "slimgb");
T2;
// verify lift
matrix(I)*T2;