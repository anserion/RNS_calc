//Copyright 2018 Andrey S. Ionisyan (anserion@gmail.com)
//
//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.
//========================================================================

unit RNS_lib;

interface
const primes_num=128;
const max_n=54;
const max_p=255;
const max_pow2=1024;
const max_pow10=1024;

type
   T_RNS=array[0..max_n] of integer;
   T_bin=array[0..max_pow2] of integer;
   T_dec=array[0..max_pow10] of integer;
   T_int_vector=array of integer;

var
   primes:array[0..primes_num] of integer;
   P:array[0..max_n] of integer;
   rns_a_table:array[0..max_p] of T_RNS;
   rns_a_neg_table:array[0..max_p] of T_RNS;
   rns_a_inv_table:array[0..max_p] of T_RNS;
   rns_pow2_table:array[0..max_pow2] of T_RNS;
   rns_pow10_table:array[0..max_pow10] of T_RNS;
   rns_add_table,rns_sub_table,rns_mul_table:array[0..max_p,0..max_p] of T_RNS;
//========================================================================

procedure print_vector(n:integer; pre_str:string; a,p_sv:T_int_vector);
procedure print_vector(n:integer; pre_str:string; a:array of integer);
procedure print_vector(n:integer; pre_str:string; a,p_sv:T_int_vector; post_str:string; value:int64; print_value,newline:boolean);
procedure print_vector(n:integer; pre_str:string; a:array of integer; post_str:string; value:int64; print_value,newline:boolean);
procedure print_vector(n:integer; pre_str:string; a:array of int64; post_str:string; value:int64; print_value,newline:boolean);
procedure print_vector(n:integer; pre_str:string; a:array of boolean; post_str:string; value:int64; print_value,newline:boolean);

procedure modulo_set(n:integer; value:integer; var a:array of integer);
procedure modulo_copy(n:integer; src:array of integer; var dst:array of integer);
function modulo_cmp_equ(n:integer; r1,r2:array of integer):boolean;
function modulo_cmp(n:integer; r1,r2:array of integer):integer;
procedure modulo_shl(n:integer; var m:array of integer);
procedure modulo_mix(n:integer; r_src,p_sv:T_int_vector; var r_dst:array of integer);
function modulo_to_str(n:integer; a:array of integer):string;
procedure str_to_modulo(n:integer; a_str:string; var res:array of integer);

procedure int64_to_bin(n_bin:integer; a:int64; var res:T_bin);
function int64_to_bin(n_bin:integer; a:int64):T_bin;

procedure int64_to_dec(n_dec:integer; a:int64; var res:T_dec);
function int64_to_dec(n_dec:integer; a:int64):T_dec;

procedure bin_add(n_bin:integer; a1,a2:T_bin; var res:T_bin);
function bin_add(n_bin:integer; a1,a2:T_bin):T_bin;

procedure dec_add(n_dec:integer; a1,a2:T_dec; var res:T_dec);
function dec_add(n_dec:integer; a1,a2:T_dec):T_dec;

procedure bin_mul(n_bin:integer; m1,m2:T_bin; var res:T_bin);
function bin_mul(n_bin:integer; m1,m2:T_bin):T_bin;

procedure dec_mul(n_dec:integer; m1,m2:T_dec; var res:T_dec);
function dec_mul(n_dec:integer; m1,m2:T_dec):T_dec;

procedure calc_P;
procedure calc_Primes;

function calc_PP_int64(n:integer; p_sv:T_int_vector):int64;

procedure calc_PP_bin(n,n_bin:integer; p_sv:T_int_vector; var pp:T_bin);
function calc_PP_bin(n,n_bin:integer; p_sv:T_int_vector):T_bin;

procedure calc_PP_dec(n,n_dec:integer; p_sv:T_int_vector; var pp:T_dec);
function calc_PP_dec(n,n_dec:integer; p_sv:T_int_vector):T_dec;

procedure calc_rns_a_tables;
procedure calc_rns_math_tables;
procedure calc_rns_pow2_table;
procedure calc_rns_pow10_table;

procedure rns_a_table_get(n,a:integer; p_sv:T_int_vector; var res:T_RNS);
function rns_a_table_get(n,a:integer; p_sv:T_int_vector):T_RNS;

procedure rns_a_neg_table_get(n,a:integer; p_sv:T_int_vector; var res:T_RNS);
function rns_a_neg_table_get(n,a:integer; p_sv:T_int_vector):T_RNS;

procedure rns_a_inv_table_get(n,a:integer; p_sv:T_int_vector; var res:T_RNS);
function rns_a_inv_table_get(n,a:integer; p_sv:T_int_vector):T_RNS;

procedure rns_pow2_table_get(n,pow_idx:integer; p_sv:T_int_vector; var res:T_RNS);
function rns_pow2_table_get(n,pow_idx:integer; p_sv:T_int_vector):T_RNS;

procedure rns_pow10_table_get(n,pow_idx:integer; p_sv:T_int_vector; var res:T_RNS);
function rns_pow10_table_get(n,pow_idx:integer; p_sv:T_int_vector):T_RNS;

procedure RNS_add(n:integer; r1,r2:T_RNS; p_sv:T_int_vector; var res:T_RNS);
function RNS_add(n:integer; r1,r2:T_RNS; p_sv:T_int_vector):T_RNS;

procedure RNS_sub(n:integer; r1,r2:T_RNS; p_sv:T_int_vector; var res:T_RNS);
function RNS_sub(n:integer; r1,r2:T_RNS; p_sv:T_int_vector):T_RNS;

procedure RNS_mul(n:integer; r1,r2:T_RNS; p_sv:T_int_vector; var res:T_RNS);
function RNS_mul(n:integer; r1,r2:T_RNS; p_sv:T_int_vector):T_RNS;

procedure RNS_formal_div(n:integer; r1,r2:T_RNS; p_sv:T_int_vector; var res:T_RNS);
function RNS_formal_div(n:integer; r1,r2:T_RNS; p_sv:T_int_vector):T_RNS;

function RNS_cmp_equ(n:integer; r1,r2:T_RNS):boolean;

procedure RNS_scale_trunc(n,p_idx:integer; r:T_RNS; p_sv:T_int_vector; var res:T_RNS);
function RNS_scale_trunc(n,p_idx:integer; r:T_RNS; p_sv:T_int_vector):T_RNS;

procedure RNS_scale(n,p_idx:integer; r:T_RNS; p_sv:T_int_vector; var res:T_RNS);
function RNS_scale(n,p_idx:integer; r:T_RNS; p_sv:T_int_vector):T_RNS;

function MRS_to_int64(n:integer; mrs:T_RNS; p_sv:T_int_vector):int64;

procedure MRS_to_bin(n,n_bin:integer; mrs:T_RNS; p_sv:T_int_vector; var res:T_bin);
function MRS_to_bin(n,n_bin:integer; mrs:T_RNS; p_sv:T_int_vector):T_bin;

procedure MRS_to_dec(n,n_dec:integer; mrs:T_RNS; p_sv:T_int_vector; var res:T_dec);
function MRS_to_dec(n,n_dec:integer; mrs:T_RNS; p_sv:T_int_vector):T_dec;

procedure MRS_to_RNS(n:integer; mrs:T_RNS; p_sv:T_int_vector; var res:T_RNS);
function MRS_to_RNS(n:integer; mrs:T_RNS; p_sv:T_int_vector):T_RNS;

procedure int64_to_RNS(n:integer; A:int64; p_sv:T_int_vector; var res:T_RNS);
function int64_to_RNS(n:integer; A:int64; p_sv:T_int_vector):T_RNS;

procedure bin_to_RNS(n,n_bin:integer; bin:T_bin; p_sv:T_int_vector; var res:T_RNS);
function bin_to_RNS(n,n_bin:integer; bin:T_bin; p_sv:T_int_vector):T_RNS;

procedure dec_to_RNS(n,n_dec:integer; dec:T_dec; p_sv:T_int_vector; var res:T_RNS);
function dec_to_RNS(n,n_dec:integer; dec:T_dec; p_sv:T_int_vector):T_RNS;

procedure RNS_to_MRS(n:integer; r:T_RNS; p_sv:T_int_vector; var res:T_RNS);
function RNS_to_MRS(n:integer; r:T_RNS; p_sv:T_int_vector):T_RNS;

procedure int64_to_MRS(n:integer; A:int64; p_sv:T_int_vector; var res:T_RNS);
function int64_to_MRS(n:integer; A:int64; p_sv:T_int_vector):T_RNS;

procedure bin_to_MRS(n,n_bin:integer; A_bin:T_bin; p_sv:T_int_vector; var res:T_RNS);
function bin_to_MRS(n,n_bin:integer; A_bin:T_bin; p_sv:T_int_vector):T_RNS;

procedure dec_to_MRS(n,n_dec:integer; A_dec:T_dec; p_sv:T_int_vector; var res:T_RNS);
function dec_to_MRS(n,n_dec:integer; A_dec:T_dec; p_sv:T_int_vector):T_RNS;

procedure MRS_product(n:integer; a_mrs,b_mrs:T_RNS; p_sv:T_int_vector; var res:T_RNS);
function MRS_product(n:integer; a_mrs,b_mrs:T_RNS; p_sv:T_int_vector):T_RNS;

function RNS_to_int64(n:integer; r:T_RNS; p_sv:T_int_vector):int64;

procedure RNS_to_bin(n,n_bin:integer; r:T_RNS; p_sv:T_int_vector; var res:T_bin);
function RNS_to_bin(n,n_bin:integer; r:T_RNS; p_sv:T_int_vector):T_bin;

procedure RNS_to_dec(n,n_dec:integer; r:T_RNS; p_sv:T_int_vector; var res:T_dec);
function RNS_to_dec(n,n_dec:integer; r:T_RNS; p_sv:T_int_vector):T_dec;

function RNS_cmp(n:integer; r1,r2:T_RNS; p_sv:T_int_vector):integer;

procedure RNS_change_mod(n_src:integer; r_src:T_RNS; p_sv_src:T_int_vector; n_dst:integer; p_sv_dst:T_int_vector; var r_dst:T_RNS);
function RNS_change_mod(n_src:integer; r_src:T_RNS; p_sv_src:T_int_vector; n_dst:integer; p_sv_dst:T_int_vector):T_RNS;

procedure calc_RNS_basis_int64(n:integer; p_sv:T_int_vector; var basis:array of int64);

procedure calc_RNS_basis_bin(n,n_bin,basis_idx:integer; p_sv:T_int_vector; var basis:T_bin);
function calc_RNS_basis_bin(n,n_bin,basis_idx:integer; p_sv:T_int_vector):T_bin;

procedure calc_RNS_basis_dec(n,n_dec,basis_idx:integer; p_sv:T_int_vector; var basis:T_dec);
function calc_RNS_basis_dec(n,n_dec,basis_idx:integer; p_sv:T_int_vector):T_dec;

function RNS_to_int64_CRT(n:integer; a:T_RNS; p_sv:T_int_vector;basis:array of int64):int64;

procedure RNS_to_RNS_CRT(n,n_ext:integer; a:T_RNS; p_sv:T_int_vector; var res:T_RNS);
function RNS_to_RNS_CRT(n,n_ext:integer; a:T_RNS; p_sv:T_int_vector):T_RNS;

procedure RNS_to_bin_CRT(n,n_ext,n_bin:integer; a:T_RNS; p_sv:T_int_vector; var res:T_bin);
function RNS_to_bin_CRT(n,n_ext,n_bin:integer; a:T_RNS; p_sv:T_int_vector):T_bin;

procedure RNS_to_dec_CRT(n,n_ext,n_dec:integer; a:T_RNS; p_sv:T_int_vector; var res:T_dec);
function RNS_to_dec_CRT(n,n_ext,n_dec:integer; a:T_RNS; p_sv:T_int_vector):T_dec;

procedure RNS_rank(n,n_ext:integer; a:T_RNS; p_sv:T_int_vector; var rank:T_RNS);
function RNS_rank(n,n_ext:integer; a:T_RNS; p_sv:T_int_vector):T_RNS;

procedure RNS_mod(n:integer; A,B:T_RNS; p_sv:T_int_vector; var R:T_RNS);
function RNS_mod(n:integer; A,B:T_RNS; p_sv:T_int_vector):T_RNS;

procedure RNS_divmod(n:integer; A,B:T_RNS; p_sv:T_int_vector; var Q,R:T_RNS);

procedure RNS_div(n:integer; A,B:T_RNS; p_sv:T_int_vector; var Q:T_RNS);
function RNS_div(n:integer; A,B:T_RNS; p_sv:T_int_vector):T_RNS;

implementation

//=========================================================================

procedure print_vector(n:integer; pre_str:string; a,p_sv:T_int_vector);
var k:integer;
begin
   write(pre_str);
   for k:=1 to n do write(a[p_sv[k]]:6);
   writeln;
end;

procedure print_vector(n:integer; pre_str:string; a:array of integer);
var k:integer;
begin
   write(pre_str);
   for k:=1 to n do write(a[k]:6);
   writeln;
end;

procedure print_vector(n:integer; pre_str:string; a,p_sv:T_int_vector; post_str:string; value:int64; print_value,newline:boolean);
var k:integer;
begin
   write(pre_str);
   for k:=1 to n do write(a[p_sv[k]]:6);
   write(post_str);
   if print_value then write(value);
   if newline then writeln;
end;

procedure print_vector(n:integer; pre_str:string; a:array of integer; post_str:string; value:int64; print_value,newline:boolean);
var k:integer;
begin
   write(pre_str);
   for k:=1 to n do write(a[k]:6);
   write(post_str);
   if print_value then write(value);
   if newline then writeln;
end;

procedure print_vector(n:integer; pre_str:string; a:array of int64; post_str:string; value:int64; print_value,newline:boolean);
var k:integer;
begin
   write(pre_str);
   for k:=1 to n do write(a[k]:6);
   write(post_str);
   if print_value then write(value);
   if newline then writeln;
end;

procedure print_vector(n:integer; pre_str:string; a:array of boolean; post_str:string; value:int64; print_value,newline:boolean);
var k:integer;
begin
   write(pre_str);
   for k:=1 to n do write(a[k]:6);
   write(post_str);
   if print_value then write(value);
   if newline then writeln;
end;
//=========================================================================

procedure modulo_set(n:integer; value:integer; var a:array of integer);
var k:integer;
begin
   for k:=1 to n do a[k]:=value;
end;

procedure modulo_copy(n:integer; src:array of integer; var dst:array of integer);
var k:integer;
begin
   for k:=1 to n do dst[k]:=src[k];
end;

function modulo_cmp_equ(n:integer; r1,r2:array of integer):boolean;
var k:integer; tmp:boolean;
begin
   tmp:=true;
   for k:=1 to n do if r1[k]<>r2[k] then tmp:=false;
   modulo_cmp_equ:=tmp;
end;

function modulo_cmp(n:integer; r1,r2:array of integer):integer;
var k,tmp:integer;
begin
   tmp:=0;
   for k:=n downto 1 do
   begin
      if r1[k]<r2[k] then begin tmp:=-1; break; end;
      if r1[k]>r2[k] then begin tmp:=1; break; end;
   end;
   modulo_cmp:=tmp;
end;

procedure modulo_shl(n:integer; var m:array of integer);
var k:integer;
begin
     for k:=n downto 2 do m[k]:=m[k-1];
     m[1]:=0;
end;

procedure modulo_mix(n:integer; r_src,p_sv:T_int_vector; var r_dst:array of integer);
var k:integer; tmp:T_RNS;
begin
   for k:=1 to n do tmp[k]:=r_src[p_sv[k]];
   for k:=1 to n do r_dst[k]:=tmp[k];
end;

function modulo_to_str(n:integer; a:array of integer):string;
var k:integer; tmp:string; flag:boolean;
begin
   tmp:=''; flag:=false;
   for k:=n downto 1 do
   begin
      if a[k]<>0 then flag:=true;
      if flag then tmp:=tmp+chr(a[k]+ord('0'));
   end;
   if not(flag) then tmp:='0';
   modulo_to_str:=tmp;
end;

procedure str_to_modulo(n:integer; a_str:string; var res:array of integer);
var k,nn:integer;
begin
   nn:=length(a_str);
   for k:=1 to nn do res[nn-k+1]:=ord(a_str[k])-ord('0');
   for k:=nn+1 to n do res[k]:=0;
end;

procedure int64_to_bin(n_bin:integer; a:int64; var res:T_bin);
var k:integer;
begin
   for k:=1 to n_bin do
   begin
      res[k]:=A and 1;
      A:=A shr 1;
   end;
end;

function int64_to_bin(n_bin:integer; a:int64):T_bin;
begin int64_to_bin(n_bin,a,int64_to_bin); end;

procedure int64_to_dec(n_dec:integer; a:int64; var res:T_dec);
var k:integer;
begin
   for k:=1 to n_dec do
   begin
      res[k]:=A mod 10;
      A:=A div 10;
   end;
end;

function int64_to_dec(n_dec:integer; a:int64):T_dec;
begin int64_to_dec(n_dec,a,int64_to_dec); end;

procedure bin_add(n_bin:integer; a1,a2:T_bin; var res:T_bin);
var k:integer; carry:byte;
begin
   carry:=0;
   for k:=1 to n_bin do
   begin
      res[k]:=a1[k]+a2[k]+carry; carry:=0;
      if res[k]=2 then begin res[k]:=0; carry:=1; end;
      if res[k]=3 then begin res[k]:=1; carry:=1; end;
   end;
end;

function bin_add(n_bin:integer; a1,a2:T_bin):T_bin;
begin bin_add(n_bin,a1,a2,bin_add); end;

procedure dec_add(n_dec:integer; a1,a2:T_dec; var res:T_dec);
var k:integer; carry:byte;
begin
   carry:=0;
   for k:=1 to n_dec do
   begin
      res[k]:=a1[k]+a2[k]+carry; carry:=0;
      if res[k]>9 then begin res[k]:=res[k]-10; carry:=1; end;
   end;
end;

function dec_add(n_dec:integer; a1,a2:T_dec):T_dec;
begin dec_add(n_dec,a1,a2,dec_add); end;

procedure bin_mul(n_bin:integer; m1,m2:T_bin; var res:T_bin);
var k:integer; tmp:T_bin;
begin
   modulo_copy(n_bin,m1,tmp);
   modulo_copy(n_bin,m2,m1);
   modulo_set(n_bin,0,m2);
   for k:=1 to n_bin do
   begin
      if tmp[k]=1 then
      begin
         bin_add(n_bin,m1,m2,res);
         modulo_copy(n_bin,res,m2);
      end;
      modulo_shl(n_bin,m1);
   end;
end;

function bin_mul(n_bin:integer; m1,m2:T_bin):T_bin;
begin bin_mul(n_bin,m1,m2,bin_mul); end;

procedure dec_mul(n_dec:integer; m1,m2:T_dec; var res:T_dec);
var i,k,carry:integer; tmp:T_dec;
begin
   modulo_copy(n_dec,m1,tmp);
   modulo_copy(n_dec,m2,m1);
   modulo_set(n_dec,0,m2);
   modulo_set(n_dec,0,res);
   for k:=1 to n_dec do
   begin
      carry:=0;
      for i:=1 to n_dec do
      begin
         m2[i]:=tmp[k]*m1[i]+carry;
         carry:=m2[i] div 10;
         m2[i]:=m2[i] mod 10;
      end;
      dec_add(n_dec,res,m2,res);
      modulo_copy(n_dec,res,m2);
      modulo_shl(n_dec,m1);
   end;
end;

function dec_mul(n_dec:integer; m1,m2:T_dec):T_dec;
begin dec_mul(n_dec,m1,m2,dec_mul); end;

procedure calc_P;
begin
   modulo_copy(max_n,primes,P);
end;

procedure calc_primes;
var n,k,i,sqrt_i:longint; flag:boolean;
begin
   n:=1; Primes[1]:=2;
   i:=2;
   while n<primes_num do
   begin
      i:=i+1;
      flag:=true; sqrt_i:=trunc(sqrt(i));

      k:=1;
      while Primes[k]<=sqrt_i do
      begin
         if (i mod Primes[k])=0 then flag:=false;
         k:=k+1;
      end;

      if flag then
      begin
         n:=n+1;
         Primes[n]:=i;
      end;
   end;
end;

function calc_PP_int64(n:integer; p_sv:T_int_vector):int64;
var k:integer; tmp:int64;
begin
   tmp:=1;
   for k:=1 to n do tmp:=tmp*P[P_sv[k]];
   calc_PP_int64:=tmp;
end;

procedure calc_PP_bin(n,n_bin:integer; p_sv:T_int_vector; var pp:T_bin);
var k:integer; tmp,p_bin:T_bin;
begin
   modulo_set(n_bin,0,tmp); tmp[1]:=1;
   for k:=1 to n do
   begin
      int64_to_bin(n_bin,P[P_sv[k]],p_bin);
      bin_mul(n_bin,tmp,p_bin,tmp);
   end;
   modulo_copy(n_bin,tmp,pp);
end;

function calc_PP_bin(n,n_bin:integer; p_sv:T_int_vector):T_bin;
begin calc_PP_bin(n,n_bin,p_sv,calc_PP_bin); end;

procedure calc_PP_dec(n,n_dec:integer; p_sv:T_int_vector; var pp:T_dec);
var k:integer; tmp,p_dec:T_dec;
begin
   modulo_set(n_dec,0,tmp); tmp[1]:=1;
   for k:=1 to n do
   begin
      int64_to_dec(n_dec,P[P_sv[k]],p_dec);
      dec_mul(n_dec,tmp,p_dec,pp);
      modulo_copy(n_dec,pp,tmp);
   end;
end;

function calc_PP_dec(n,n_dec:integer; p_sv:T_int_vector):T_dec;
begin calc_PP_dec(n,n_dec,p_sv,calc_PP_dec); end;

procedure calc_rns_a_tables;
var a,k,i:integer;
begin
   for k:=1 to max_n do
   for a:=0 to max_p do
      rns_a_table[a,k]:=a mod P[k];

   for k:=1 to max_n do
   for a:=0 to max_p do
   begin
      if rns_a_table[a,k]=0 then rns_a_neg_table[a,k]:=0
         else rns_a_neg_table[a,k]:=P[k]-rns_a_table[a,k];
      rns_a_inv_table[a,k]:=0;
      for i:=1 to P[k]-1 do
         if (rns_a_table[a,k]*i)mod P[k]=1 then rns_a_inv_table[a,k]:=i;
   end;
end;

procedure calc_rns_math_tables;
var k:integer; a1,a2:integer;
begin
   for k:=1 to max_n do
      for a1:=0 to max_p do
         for a2:=0 to max_p do
         begin
            rns_add_table[a1,a2,k]:=(a1+a2) mod P[k];
            rns_sub_table[a1,a2,k]:=(a1-a2) mod P[k];
            if rns_sub_table[a1,a2,k]<0 then
               rns_sub_table[a1,a2,k]:=rns_sub_table[a1,a2,k]+P[k];
            rns_mul_table[a1,a2,k]:=(a1*a2) mod P[k];
         end;
end;

procedure calc_rns_pow2_table;
var k,i:integer;
begin
   modulo_set(max_pow2,1,rns_pow2_table[0]);
   for k:=1 to max_n do
      for i:=1 to max_pow2 do
         rns_pow2_table[i,k]:=rns_add_table[rns_pow2_table[i-1,k],rns_pow2_table[i-1,k],k];
end;

procedure calc_rns_pow10_table;
var k,i:integer;
begin
   modulo_set(max_pow10,1,rns_pow10_table[0]);
   for k:=1 to max_n do
   begin
      rns_pow10_table[1,k]:=rns_a_table[10,k];
      for i:=1 to max_pow10 do
         rns_pow10_table[i,k]:=rns_mul_table[rns_pow10_table[i-1,k],rns_pow10_table[1,k],k];
   end;
end;

procedure rns_a_table_get(n,a:integer; p_sv:T_int_vector; var res:T_RNS);
var k:integer;
begin
   for k:=1 to n do res[k]:=rns_a_table[a,p_sv[k]];
end;

function rns_a_table_get(n,a:integer; p_sv:T_int_vector):T_RNS;
begin rns_a_table_get(n,a,p_sv,rns_a_table_get); end;

procedure rns_a_neg_table_get(n,a:integer; p_sv:T_int_vector; var res:T_RNS);
var k:integer;
begin
   for k:=1 to n do res[k]:=rns_a_neg_table[a,p_sv[k]];
end;

function rns_a_neg_table_get(n,a:integer; p_sv:T_int_vector):T_RNS;
begin rns_a_neg_table_get(n,a,p_sv,rns_a_neg_table_get); end;

procedure rns_a_inv_table_get(n,a:integer; p_sv:T_int_vector; var res:T_RNS);
var k:integer;
begin
   for k:=1 to n do res[k]:=rns_a_inv_table[a,p_sv[k]];
end;

function rns_a_inv_table_get(n,a:integer; p_sv:T_int_vector):T_RNS;
begin rns_a_inv_table_get(n,a,p_sv,rns_a_inv_table_get); end;

procedure rns_pow2_table_get(n,pow_idx:integer; p_sv:T_int_vector; var res:T_RNS);
var k:integer;
begin
   for k:=1 to n do res[k]:=rns_pow2_table[pow_idx,p_sv[k]];
end;

function rns_pow2_table_get(n,pow_idx:integer; p_sv:T_int_vector):T_RNS;
begin rns_pow2_table_get(n,pow_idx,p_sv,rns_pow2_table_get); end;

procedure rns_pow10_table_get(n,pow_idx:integer; p_sv:T_int_vector; var res:T_RNS);
var k:integer;
begin
   for k:=1 to n do res[k]:=rns_pow10_table[pow_idx,p_sv[k]];
end;

function rns_pow10_table_get(n,pow_idx:integer; p_sv:T_int_vector):T_RNS;
begin rns_pow10_table_get(n,pow_idx,p_sv,rns_pow10_table_get); end;

procedure RNS_add(n:integer; r1,r2:T_RNS; p_sv:T_int_vector; var res:T_RNS);
var k:integer;
begin
   for k:=1 to n do res[k]:=rns_add_table[r1[k],r2[k],p_sv[k]];
end;

function RNS_add(n:integer; r1,r2:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_add(n,r1,r2,p_sv,RNS_add); end;

procedure RNS_sub(n:integer; r1,r2:T_RNS; p_sv:T_int_vector; var res:T_RNS);
var k:integer;
begin
   for k:=1 to n do res[k]:=rns_add_table[r1[k],rns_a_neg_table[r2[k],p_sv[k]],p_sv[k]];
end;

function RNS_sub(n:integer; r1,r2:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_sub(n,r1,r2,p_sv,RNS_sub); end;

procedure RNS_mul(n:integer; r1,r2:T_RNS; p_sv:T_int_vector; var res:T_RNS);
var k:integer;
begin
   for k:=1 to n do res[k]:=rns_mul_table[r1[k],r2[k],p_sv[k]];
end;

function RNS_mul(n:integer; r1,r2:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_mul(n,r1,r2,p_sv,RNS_mul); end;

procedure RNS_formal_div(n:integer; r1,r2:T_RNS; p_sv:T_int_vector; var res:T_RNS);
var k:integer;
begin
   for k:=1 to n do res[k]:=rns_mul_table[r1[k],rns_a_inv_table[r2[k],p_sv[k]],p_sv[k]];
end;

function RNS_formal_div(n:integer; r1,r2:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_formal_div(n,r1,r2,p_sv,RNS_formal_div); end;

function RNS_cmp_equ(n:integer; r1,r2:T_RNS):boolean;
begin
   RNS_cmp_equ:=modulo_cmp_equ(n,r1,r2);
end;

procedure RNS_scale_trunc(n,p_idx:integer; r:T_RNS; p_sv:T_int_vector; var res:T_RNS);
var tmp_dig,tmp_sub,tmp_P:T_RNS;
begin
   rns_a_table_get(n,r[p_idx],p_sv,tmp_dig);
   RNS_sub(n,r,tmp_dig,p_sv,tmp_sub);
   rns_a_table_get(n,P[p_sv[p_idx]],p_sv,tmp_p);
   RNS_formal_div(n,tmp_sub,tmp_p,p_sv,res);
end;

function RNS_scale_trunc(n,p_idx:integer; r:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_scale_trunc(n,p_idx,r,p_sv,RNS_scale_trunc); end;

procedure RNS_scale(n,p_idx:integer; r:T_RNS; p_sv:T_int_vector; var res:T_RNS);
var tmp_res,p_sv_src:T_RNS; k:integer;
begin
   RNS_scale_trunc(n,p_idx,r,p_sv,res);
   for k:=1 to p_idx-1 do p_sv_src[k]:=p_sv[k];
   for k:=p_idx+1 to n do begin tmp_res[k-1]:=res[k]; p_sv_src[k-1]:=p_sv[k]; end;
   RNS_change_mod(n-1,tmp_res,p_sv_src,n,p_sv,res);
end;

function RNS_scale(n,p_idx:integer; r:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_scale(n,p_idx,r,p_sv,RNS_scale); end;

function MRS_to_int64(n:integer; mrs:T_RNS; p_sv:T_int_vector):int64;
var tmp:int64; k:integer;
begin
   tmp:=0;
   for k:=n downto 1 do tmp:=tmp*p[p_sv[k]]+mrs[k];
   MRS_to_int64:=tmp;
end;

procedure MRS_to_bin(n,n_bin:integer; mrs:T_RNS; p_sv:T_int_vector; var res:T_bin);
var k:integer; tmp,mrs_bin,p_bin:T_bin;
begin
   modulo_set(n_bin,0,tmp);
   for k:=n downto 1 do
   begin
      int64_to_bin(n_bin,mrs[k],mrs_bin);
      int64_to_bin(n_bin,p[p_sv[k]],p_bin);
      bin_mul(n_bin,tmp,p_bin,tmp);
      bin_add(n_bin,tmp,mrs_bin,tmp);
   end;
   modulo_copy(n_bin,tmp,res);
end;

function MRS_to_bin(n,n_bin:integer; mrs:T_RNS; p_sv:T_int_vector):T_bin;
begin MRS_to_bin(n,n_bin,mrs,p_sv,MRS_to_bin); end;

procedure MRS_to_dec(n,n_dec:integer; mrs:T_RNS; p_sv:T_int_vector; var res:T_dec);
var k:integer; tmp,mrs_dec,p_dec:T_dec;
begin
   modulo_set(n_dec,0,tmp);
   for k:=n downto 1 do
   begin
      int64_to_dec(n_dec,mrs[k],mrs_dec);
      int64_to_dec(n_dec,p[p_sv[k]],p_dec);
      dec_mul(n_dec,tmp,p_dec,tmp);
      dec_add(n_dec,tmp,mrs_dec,tmp);
   end;
   modulo_copy(n_dec,tmp,res);
end;

function MRS_to_dec(n,n_dec:integer; mrs:T_RNS; p_sv:T_int_vector):T_dec;
begin MRS_to_dec(n,n_dec,mrs,p_sv,MRS_to_dec); end;

procedure MRS_to_RNS(n:integer; mrs:T_RNS; p_sv:T_int_vector; var res:T_RNS);
var k,i:integer; tmp_rns1,tmp_rns2:T_RNS;
begin
   modulo_set(n,0,tmp_rns1);
   for i:=n downto 1 do
      for k:=1 to n do
      begin
         tmp_rns2[k]:=rns_mul_table[tmp_rns1[k],rns_a_table[p[p_sv[i]],p_sv[k]],p_sv[k]];
         tmp_rns1[k]:=rns_add_table[tmp_rns2[k],rns_a_table[mrs[i],p_sv[k]],p_sv[k]];
      end;
   modulo_copy(n,tmp_rns1,res);
end;

function MRS_to_RNS(n:integer; mrs:T_RNS; p_sv:T_int_vector):T_RNS;
begin MRS_to_RNS(n,mrs,p_sv,MRS_to_RNS); end;

procedure int64_to_RNS(n:integer; A:int64; p_sv:T_int_vector; var res:T_RNS);
var k:integer; tmp_pow2:T_RNS;
begin
   modulo_set(n,0,res);
   k:=0;
   while (A<>0) do
   begin
      if (A and 1)=1 then
      begin
         rns_pow2_table_get(n,k,p_sv,tmp_pow2);
         RNS_add(n,res,tmp_pow2,p_sv,res);
      end;
      A:=A shr 1;
      k:=k+1;
   end;
end;

function int64_to_RNS(n:integer; A:int64; p_sv:T_int_vector):T_RNS;
begin int64_to_RNS(n,A,p_sv,int64_to_RNS); end;

procedure bin_to_RNS(n,n_bin:integer; bin:T_bin; p_sv:T_int_vector; var res:T_RNS);
var k:integer; tmp_pow2:T_RNS;
begin
   modulo_set(n,0,res);
   for k:=1 to n_bin do
      if bin[k]=1 then
      begin
         rns_pow2_table_get(n,k-1,p_sv,tmp_pow2);
         RNS_add(n,res,tmp_pow2,p_sv,res);
      end;
end;

function bin_to_RNS(n,n_bin:integer; bin:T_bin; p_sv:T_int_vector):T_RNS;
begin bin_to_RNS(n,n_bin,bin,p_sv,bin_to_RNS); end;

procedure dec_to_RNS(n,n_dec:integer; dec:T_dec; p_sv:T_int_vector; var res:T_RNS);
var k:integer; tmp_mul,tmp_pow10,tmp_dig:T_RNS;
begin
   modulo_set(n,0,res);
   for k:=1 to n_dec do
   begin
      rns_pow10_table_get(n,k-1,p_sv,tmp_pow10);
      rns_a_table_get(n,dec[k],p_sv,tmp_dig);
      RNS_mul(n,tmp_dig,tmp_pow10,p_sv,tmp_mul);
      RNS_add(n,res,tmp_mul,p_sv,res);
   end;
end;

function dec_to_RNS(n,n_dec:integer; dec:T_dec; p_sv:T_int_vector):T_RNS;
begin dec_to_RNS(n,n_dec,dec,p_sv,dec_to_RNS); end;

procedure RNS_to_MRS(n:integer; r:T_RNS; p_sv:T_int_vector; var res:T_RNS);
var k:integer; tmp_rns1,tmp_rns2:T_RNS;
begin
   modulo_copy(n,r,tmp_rns1);
   for k:=1 to n do
   begin
      res[k]:=tmp_rns1[k];
      RNS_scale_trunc(n,k,tmp_rns1,p_sv,tmp_rns2);
      modulo_copy(n,tmp_rns2,tmp_rns1);
   end;
end;

function RNS_to_MRS(n:integer; r:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_to_MRS(n,r,p_sv,RNS_to_MRS); end;

procedure int64_to_MRS(n:integer; A:int64; p_sv:T_int_vector; var res:T_RNS);
var tmp:int64; k:integer;
begin
   tmp:=A;
   for k:=1 to n do
   begin
      res[k]:=tmp mod p[p_sv[k]];
      tmp:=(tmp-res[k]) div p[p_sv[k]];
   end;
end;

function int64_to_MRS(n:integer; A:int64; p_sv:T_int_vector):T_RNS;
begin int64_to_MRS(n,A,p_sv,int64_to_MRS); end;

procedure bin_to_MRS(n,n_bin:integer; A_bin:T_bin; p_sv:T_int_vector; var res:T_RNS);
var tmp:T_RNS;
begin
   bin_to_RNS(n,n_bin,A_bin,p_sv,tmp);
   RNS_to_MRS(n,tmp,p_sv,res);
end;

function bin_to_MRS(n,n_bin:integer; A_bin:T_bin; p_sv:T_int_vector):T_RNS;
begin bin_to_MRS(n,n_bin,A_bin,p_sv,bin_to_MRS); end;

procedure dec_to_MRS(n,n_dec:integer; A_dec:T_dec; p_sv:T_int_vector; var res:T_RNS);
var tmp:T_RNS;
begin
   dec_to_RNS(n,n_dec,A_dec,p_sv,tmp);
   RNS_to_MRS(n,tmp,p_sv,res);
end;

function dec_to_MRS(n,n_dec:integer; A_dec:T_dec; p_sv:T_int_vector):T_RNS;
begin dec_to_MRS(n,n_dec,A_dec,p_sv,dec_to_MRS); end;

procedure MRS_product(n:integer; a_mrs,b_mrs:T_RNS; p_sv:T_int_vector; var res:T_RNS);
var A_rns,B_rns,AB_rns:T_RNS;
begin
   MRS_to_RNS(n,a_mrs,p_sv,A_rns);
   MRS_to_RNS(n,b_mrs,p_sv,B_rns);
   RNS_mul(n,A_rns,B_rns,p_sv,AB_rns);
   RNS_to_MRS(n,AB_rns,p_sv,res);
end;

function MRS_product(n:integer; a_mrs,b_mrs:T_RNS; p_sv:T_int_vector):T_RNS;
begin MRS_product(n,a_mrs,b_mrs,p_sv,MRS_product); end;

function RNS_to_int64(n:integer; r:T_RNS; p_sv:T_int_vector):int64;
var mrs:T_RNS;
begin
   RNS_to_MRS(n,r,p_sv,mrs);
   RNS_to_int64:=MRS_to_int64(n,mrs,p_sv);
end;

procedure RNS_to_bin(n,n_bin:integer; r:T_RNS; p_sv:T_int_vector; var res:T_bin);
var mrs:T_RNS;
begin
   RNS_to_MRS(n,r,p_sv,mrs);
   MRS_to_bin(n,n_bin,mrs,p_sv,res);
end;

function RNS_to_bin(n,n_bin:integer; r:T_RNS; p_sv:T_int_vector):T_bin;
begin RNS_to_bin(n,n_bin,r,p_sv,RNS_to_bin); end;

procedure RNS_to_dec(n,n_dec:integer; r:T_RNS; p_sv:T_int_vector; var res:T_dec);
var mrs:T_RNS;
begin
   RNS_to_MRS(n,r,p_sv,mrs);
   MRS_to_dec(n,n_dec,mrs,p_sv,res);
end;

function RNS_to_dec(n,n_dec:integer; r:T_RNS; p_sv:T_int_vector):T_dec;
begin RNS_to_dec(n,n_dec,r,p_sv,RNS_to_dec); end;

function RNS_cmp(n:integer; r1,r2:T_RNS; p_sv:T_int_vector):integer;
var mrs1,mrs2:T_RNS;
begin
   RNS_to_MRS(n,r1,p_sv,mrs1);
   RNS_to_MRS(n,r2,p_sv,mrs2);
   RNS_cmp:=modulo_cmp(n,mrs1,mrs2);
end;

procedure RNS_change_mod(n_src:integer; r_src:T_RNS; p_sv_src:T_int_vector; n_dst:integer; p_sv_dst:T_int_vector; var r_dst:T_RNS);
var k,i:integer; mrs,tmp_rns1,tmp_rns2:T_RNS;
begin
   RNS_to_MRS(n_src,r_src,p_sv_src,mrs);
   modulo_set(n_dst,0,tmp_rns1);
   for i:=n_src downto 1 do
      for k:=1 to n_dst do
      begin
         tmp_rns2[k]:=rns_mul_table[tmp_rns1[k],rns_a_table[p[p_sv_src[i]],p_sv_dst[k]],p_sv_dst[k]];
         tmp_rns1[k]:=rns_add_table[tmp_rns2[k],rns_a_table[mrs[i],p_sv_dst[k]],p_sv_dst[k]];
      end;
   modulo_copy(n_dst,tmp_rns1,r_dst);
end;

function RNS_change_mod(n_src:integer; r_src:T_RNS; p_sv_src:T_int_vector; n_dst:integer; p_sv_dst:T_int_vector):T_RNS;
begin RNS_change_mod(n_src,r_src,p_sv_src,n_dst,p_sv_dst,RNS_change_mod); end;

procedure calc_RNS_basis_int64(n:integer; p_sv:T_int_vector; var basis:array of int64);
var k:integer; tmp:T_RNS;
begin
   modulo_set(n,0,tmp);
   for k:=1 to n do
   begin
      tmp[k-1]:=0; tmp[k]:=1;
      basis[k]:=RNS_to_int64(n,tmp,p_sv);
   end;
end;

procedure calc_RNS_basis_bin(n,n_bin,basis_idx:integer; p_sv:T_int_vector; var basis:T_bin);
var tmp:T_RNS;
begin
   modulo_set(n,0,tmp);
   tmp[basis_idx]:=1;
   RNS_to_bin(n,n_bin,tmp,p_sv,basis);
end;

function calc_RNS_basis_bin(n,n_bin,basis_idx:integer; p_sv:T_int_vector):T_bin;
begin calc_RNS_basis_bin(n,n_bin,basis_idx,p_sv,calc_RNS_basis_bin); end;

procedure calc_RNS_basis_dec(n,n_dec,basis_idx:integer; p_sv:T_int_vector; var basis:T_dec);
var tmp:T_RNS;
begin
   modulo_set(n,0,tmp);
   tmp[basis_idx]:=1;
   RNS_to_dec(n,n_dec,tmp,p_sv,basis);
end;

function calc_RNS_basis_dec(n,n_dec,basis_idx:integer; p_sv:T_int_vector):T_dec;
begin calc_RNS_basis_dec(n,n_dec,basis_idx,p_sv,calc_RNS_basis_dec); end;

function RNS_to_int64_CRT(n:integer; a:T_RNS; p_sv:T_int_vector;basis:array of int64):int64;
var k:integer; tmp:int64;
begin
   tmp:=0;
   for k:=1 to n do tmp:=tmp+a[k]*basis[p_sv[k]];
   RNS_to_int64_CRT:=tmp;
end;

procedure RNS_to_RNS_CRT(n,n_ext:integer; a:T_RNS; p_sv:T_int_vector; var res:T_RNS);
var k:integer; b,b_ext,dig_ext,mul_ext:T_RNS;
begin
   modulo_set(n,0,b);
   modulo_set(n_ext,0,res);
   for k:=1 to n do
   begin
      rns_a_table_get(n_ext,a[k],p_sv,dig_ext);
      b[k-1]:=0; b[k]:=1;
      RNS_change_mod(n,b,p_sv,n_ext,p_sv,b_ext);
      RNS_mul(n_ext,dig_ext,b_ext,p_sv,mul_ext);
      RNS_add(n_ext,res,mul_ext,p_sv,res);
   end;
end;

function RNS_to_RNS_CRT(n,n_ext:integer; a:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_to_RNS_CRT(n,n_ext,a,p_sv,RNS_to_RNS_CRT); end;

procedure RNS_to_bin_CRT(n,n_ext,n_bin:integer; a:T_RNS; p_sv:T_int_vector; var res:T_bin);
var tmp:T_RNS;
begin
   RNS_to_RNS_CRT(n,n_ext,a,p_sv,tmp);
   RNS_to_bin(n_ext,n_bin,tmp,p_sv,res);
end;

function RNS_to_bin_CRT(n,n_ext,n_bin:integer; a:T_RNS; p_sv:T_int_vector):T_bin;
begin RNS_to_bin_CRT(n,n_ext,n_bin,a,p_sv,RNS_to_bin_CRT); end;

procedure RNS_to_dec_CRT(n,n_ext,n_dec:integer; a:T_RNS; p_sv:T_int_vector; var res:T_dec);
var tmp:T_RNS;
begin
   RNS_to_RNS_CRT(n,n_ext,a,p_sv,tmp);
   RNS_to_dec(n_ext,n_dec,tmp,p_sv,res);
end;

function RNS_to_dec_CRT(n,n_ext,n_dec:integer; a:T_RNS; p_sv:T_int_vector):T_dec;
begin RNS_to_dec_CRT(n,n_ext,n_dec,a,p_sv,RNS_to_dec_CRT); end;

procedure RNS_rank(n,n_ext:integer; a:T_RNS; p_sv:T_int_vector; var rank:T_RNS);
var k:integer; sum_ext,scale_ext,tmp_ext,tmp_p_sv:T_RNS;
begin
   RNS_to_RNS_CRT(n,n_ext,a,p_sv,sum_ext);
   modulo_copy(n_ext,sum_ext,tmp_ext);
   for k:=1 to n do
   begin
      RNS_scale_trunc(n_ext,k,tmp_ext,p_sv,scale_ext);
      modulo_copy(n_ext,scale_ext,tmp_ext);
   end;
   
   for k:=n+1 to n_ext do 
   begin
      tmp_ext[k-n]:=scale_ext[k];
      tmp_p_sv[k-n]:=p_sv[k];
   end;
   
   RNS_change_mod(n_ext-n,tmp_ext,tmp_p_sv,n,p_sv,rank);
end;

function RNS_rank(n,n_ext:integer; a:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_rank(n,n_ext,a,p_sv,RNS_rank); end;

procedure RNS_mod(n:integer; A,B:T_RNS; p_sv:T_int_vector; var R:T_RNS);
var k:integer; B_mul_p,tmp:T_RNS;
begin
   modulo_set(n,0,tmp);
   if not(modulo_cmp_equ(n,tmp,B)) then
   begin
   modulo_copy(n,A,R);
   while RNS_cmp(n,R,B,p_sv)>=0 do
   begin
      k:=0;
      modulo_copy(n,B,tmp);
      repeat
         k:=k+1;
         modulo_copy(n,tmp,B_mul_P);
         RNS_mul(n,B_mul_P,rns_a_table_get(n,P[k],p_sv),p_sv,tmp);
      until RNS_cmp(n,tmp,R,p_sv)>=0;
      while RNS_cmp(n,R,B_mul_P,p_sv)>=0 do RNS_sub(n,R,B_mul_P,p_sv,R);
   end;
   end else modulo_set(n,0,R);
end;

function RNS_mod(n:integer; A,B:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_mod(n,A,B,p_sv,RNS_mod); end;

procedure RNS_divmod(n:integer; A,B:T_RNS; p_sv:T_int_vector; var Q,R:T_RNS);
var A_minus_R,tmp_Q:T_RNS; k,cnt:integer; p_sv_src:T_RNS;
begin
   RNS_mod(n,A,B,p_sv,R);
   RNS_sub(n,A,R,p_sv,A_minus_R);
   RNS_formal_div(n,A_minus_R,B,p_sv,Q);
   cnt:=0;
   for k:=1 to n do
      if B[k]<>0 then
      begin
         cnt:=cnt+1;
         p_sv_src[cnt]:=p_sv[k];
         tmp_Q[cnt]:=Q[k];
      end;
   RNS_change_mod(cnt,tmp_Q,p_sv_src,n,p_sv,Q);
end;

procedure RNS_div(n:integer; A,B:T_RNS; p_sv:T_int_vector; var Q:T_RNS);
var dummy:T_RNS;
begin
   RNS_divmod(n,A,B,p_sv,Q,dummy);
end;

function RNS_div(n:integer; A,B:T_RNS; p_sv:T_int_vector):T_RNS;
begin RNS_div(n,A,B,p_sv,RNS_div); end;

end.
