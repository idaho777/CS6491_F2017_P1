// Place student's code here
// Student's names:
// Date last edited:
/* Functionality provided (say what works):

*/

// Part 1
pts getTangentPoints(pt S, pt E, pt L, pt R) {
  float s = d(S,L);          // radii
  vec SL  = V(S,L);        // radii vectors
  
  // Draw arc tangent to L
  pt T = P(L).add(-d(E,R), SL.normalize());
  pt U = P(T, E);
  vec TL = V(T, L);
  vec TU = V(T, U);

  float tu = n(V(TU));
  float tuExtra = dot(V(TL), V(TU).reverse().normalize());
  vec LUExtra = V(TU).normalize().scaleBy(tu + tuExtra);
  pt Lprime = P(L).add(V(LUExtra).scaleBy(2));  // tangent spot at other circle
  
  // tangent line on L
  vec Ltangent = V(TU).add(V(TL).normalize().scaleBy(dot(TU, V(TL).normalize())).reverse());
  Ltangent.normalize();
  
  vec ELprime = V(E, Lprime);
  vec EU      = V(E, U);
  // tangent line on L'
  vec LprimeTangent = V(EU).add(V(ELprime).normalize().scaleBy(dot(EU, V(ELprime).normalize())).reverse());
  LprimeTangent.normalize();
  
  float LtangentAngle = angle(Ltangent, LUExtra);
  pt A = P(L).add(n(LUExtra)/cos(LtangentAngle), Ltangent); 
  
  pts hat = new pts();
  hat.declare();
  hat.addPt(L);
  hat.addPt(A);
  hat.addPt(Lprime);

  return hat;
}


pts getArcClockPts(pt A, pt B, pt C, int n) {
  pts p = new pts();
  p.declare();
  
  float LSangle = angle(V(B, A));
  float LEangle = angle(V(B, C));
  if (LEangle <= LSangle) LEangle += TAU;
  float angleInBetween = LEangle - LSangle;
  float step = angleInBetween / (n-1);
  
  vec BA = V(B, A);
  for (int i = 0; i < n; ++i) {
    p.addPt(P(B, R(V(BA), i*step)));
  }
  
  return p;
}


// Part 2
pt getMedialAxis(pt P0, vec T0, pt C1, float c1) {
  T0 = U(T0);
  vec C1P0 = V(C1,P0);
  float d = (sq(c1) - sq(d(C1,P0))) / (2*(dot(T0, C1P0) - c1));
  pt X = P(P0).add(d, T0);
  return X;
}


pts getCircleArcInHat(pt PA, pt B, pt PC, int n) {// draws circular arc from PA to PB that starts tangent to B-PA and ends tangent to PC-B
  pts p = new pts();
  p.declare();
  float e = (d(B,PC)+d(B,PA))/2;
  pt A = P(B,e,U(B,PA));
  pt C = P(B,e,U(B,PC));
  vec BA = V(B,A), BC = V(B,C);
  float d = dot(BC,BC) / dot(BC,W(BA,BC));
  pt X = P(B,d,W(BA,BC));
  float r=abs(det(V(B,X),U(BA)));
  vec XA = V(X,A), XC = V(X,C); 
  float a = angle(XA,XC), da=a/(n-1);
  for (int i = 0; i < n; ++i) {
    p.addPt(P(X,R(V(XA), i*da)));
  }
  //p.G[p.pv] = PC; // makes sure the last point is PC
  return p;
}   