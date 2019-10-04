/*********************************************
 * OPL 12.8.0.0 Model
 * Author: jamalwarida
 * Creation Date: Dec 9, 2018 at 2:10:10 PM
 *********************************************/
int i = 32;
int j = 32;
int k = 16;
int b = 4;
int bb = 4;
int c = 8;
int cc = 8;
int d = 12;
int dd = 12;
int e = 16;
int ee = 16;
int f = 20;
int ff = 20;
int g = 24;
int gg = 24;
int h = 28;
int hh = 28;
int l = 32;
int ll = 32;

range II = 1..i;
range I = 1..i;
range JJ = 1..j;
range J = 1..j;
range K = 1..k;
range A = 17..i;
range AA = 17..i;
range B = 1..b;
range BB = 1..bb;
range C = 5..c;
range CC = 5..cc;
range D = 9..d;
range DD = 9..dd;
range E = 13..e;
range EE = 13..ee;
range F = 17..f;
range FF = 17..ff;
range G = 21..g;
range GG = 21..gg;
range H = 25..h;
range HH = 25..hh;
range L = 29..l;
range LL = 29..ll;

// Parameters
//Dis is the distance between away city i and home city j
float Dis[I][J] = ...;
//R is the ranking of away team i from previous season
float R[I] = ...;

// Decision Variable
// xijk is 1 if game between away team i and home team j
// is played for week k, 0 otherwise
dvar boolean x[I][J][K];

// Objective fnc
// Our aim is to minimize the total distance travelled by the teams
minimize  sum(i in I,j in J,k in K) x[i][j][k]*Dis[i][j];

// Constraints
subject to {
// each week 16 games are played
	forall (k in K)
	  ct1: sum(i in I,j in J) x[i][j][k] == 16;
// all diagonal games are zeros, team doesn't face itself
	 forall (i in I,k in K)
	   ct2:  x[i][i][k] == 0;  	   
// sum of all away games for each team is 8
	forall(j in J)
	 	 ct4: sum(i in I,k in K) x[i][j][k]==8;
// sum of all home games for each team is 8
	forall(i in I)
	 	 ct5: sum(j in J,k in K) x[i][j][k]==8;
// sum of all games in season is 256	 	 
 ct6: sum(i in I,j in J,k in K) x[i][j][k] == 256;
// each team plays max once per week
forall(k in K)
  forall(j in J)
 ct7: sum(i in I) x[i][j][k] <= 1;
forall(k in K)
 forall(i in I)
 ct8: sum(j in J) x[i][j][k] <= 1;

  

// Each team in division faces other team in division home & away
ct9: sum(b in B,bb in BB,k in K) x[b][bb][k] == 12;
ct10: sum(c in C,cc in CC,k in K) x[c][cc][k] == 12;
ct11: sum(d in D,dd in DD,k in K) x[d][dd][k] == 12;
ct12: sum(e in E,ee in EE,k in K) x[e][ee][k] == 12;
ct13: sum(f in F,ff in FF,k in K) x[f][ff][k] == 12;
ct14: sum(g in G,gg in GG,k in K) x[g][gg][k] == 12;
ct15: sum(h in H,hh in HH,k in K) x[h][hh][k] == 12;
ct16: sum(l in L,ll in LL,k in K) x[l][ll][k] == 12;

//  no games can be repeated
forall(i in I,j in J)
  ct18: sum(k in K)x[i][j][k] <= 1;
  
// average away team ranking is 18 or lower
forall(j in J)
 ct19: sum(i in I,k in K) x[i][j][k]*R[i]/8 <= 18;


// Each NFC team plays 5 games to AFC teams in the season
//ct17: forall(i in II,jj in JJ) 
//sum(j in A,k in K) x[i][j][k] + sum(ii in A, k in K) x[ii][jj][k] == 5;



}  
