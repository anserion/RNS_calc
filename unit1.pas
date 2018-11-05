unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, LCLintf, LCLtype, ExtCtrls, RNS_lib;

type

  { TForm1 }

  TForm1 = class(TForm)
    BTN_cmp: TButton;
    BTN_cmp1: TButton;
    BTN_R2_swap_mem1: TButton;
    BTN_R2_swap_mem: TButton;
    BTN_accum_to_mem: TButton;
    BTN_R1_to_mem: TButton;
    BTN_R2_to_mem: TButton;
    BTN_R1_to_R2: TButton;
    BTN_R1_swap_R2: TButton;
    BTN_R2_to_R1: TButton;
    BTN_accum_from_mem: TButton;
    BTN_accum_swap_mem: TButton;
    BTN_R1_from_mem: TButton;
    BTN_R2_from_mem: TButton;
    BTN_R1_from_R2: TButton;
    BTN_R2_from_R1: TButton;
    BTN_add: TButton;
    BTN_n: TButton;
    BTN_R2_swap_R1: TButton;
    BTN_sub: TButton;
    BTN_mul: TButton;
    BTN_div: TButton;
    BTN_rem: TButton;
    BTN_primes: TButton;
    BTN_n_ext: TButton;
    Edit_mem_CRT: TEdit;
    Edit_mem_dec: TEdit;
    Edit_mem_rank: TEdit;
    Edit_n: TEdit;
    Edit_n_ext: TEdit;
    Edit_R1_CRT: TEdit;
    Edit_R2_CRT: TEdit;
    Edit_R1_dec: TEdit;
    Edit_R2_dec: TEdit;
    Edit_R1_rank: TEdit;
    Edit_R2_rank: TEdit;
    Edit_PP: TEdit;
    Edit_Accum_dec: TEdit;
    Edit_Accum_rank: TEdit;
    Edit_Accum_CRT: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Panel1: TPanel;
    Panel_R2: TPanel;
    Panel_R1: TPanel;
    Panel_accum: TPanel;
    Panel_mem: TPanel;
    SG_Accum: TStringGrid;
    SG_mem: TStringGrid;
    SG_P_basis: TStringGrid;
    SG_R1: TStringGrid;
    SG_R2: TStringGrid;
    procedure BTN_accum_from_memClick(Sender: TObject);
    procedure BTN_accum_swap_memClick(Sender: TObject);
    procedure BTN_accum_to_memClick(Sender: TObject);
    procedure BTN_addClick(Sender: TObject);
    procedure BTN_cmpClick(Sender: TObject);
    procedure BTN_divClick(Sender: TObject);
    procedure BTN_mulClick(Sender: TObject);
    procedure BTN_R1_from_memClick(Sender: TObject);
    procedure BTN_R1_from_R2Click(Sender: TObject);
    procedure BTN_R1_to_memClick(Sender: TObject);
    procedure BTN_R1_to_R2Click(Sender: TObject);
    procedure BTN_R2_from_memClick(Sender: TObject);
    procedure BTN_R2_from_R1Click(Sender: TObject);
    procedure BTN_R2_swap_mem1Click(Sender: TObject);
    procedure BTN_R2_swap_memClick(Sender: TObject);
    procedure BTN_R1_swap_R2Click(Sender: TObject);
    procedure BTN_R2_to_memClick(Sender: TObject);
    procedure BTN_R2_to_R1Click(Sender: TObject);
    procedure BTN_nClick(Sender: TObject);
    procedure BTN_R2_swap_R1Click(Sender: TObject);
    procedure BTN_remClick(Sender: TObject);
    procedure BTN_subClick(Sender: TObject);
    procedure BTN_primesClick(Sender: TObject);
    procedure BTN_n_extClick(Sender: TObject);
    procedure Edit_Accum_decChange(Sender: TObject);
    procedure Edit_mem_decChange(Sender: TObject);
    procedure Edit_R1_decChange(Sender: TObject);
    procedure Edit_R2_decChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SG_AccumEditingDone(Sender: TObject);
    procedure SG_memEditingDone(Sender: TObject);
    procedure SG_P_basisEditingDone(Sender: TObject);
    procedure SG_R1EditingDone(Sender: TObject);
    procedure SG_R2EditingDone(Sender: TObject);
  private
    { private declarations }
    procedure refresh_visual;
    procedure init_sub;
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  n,n_ext,n_dec,n_dec_ext: integer;

  pp_dec: T_dec;
  P_sv: array[0..max_n] of integer;
  basis_dec: array[0..max_n] of T_dec;
  accum_int64: int64;
  accum_RNS: T_RNS;
  accum_MRS: T_RNS;
  accum_dec: T_dec;
  accum_rank_RNS: T_RNS;
  accum_rank_dec: T_dec;
  accum_CRT_dec: T_dec;

  R1_int64: int64;
  R1_RNS: T_RNS;
  R1_MRS: T_RNS;
  R1_dec: T_dec;
  R1_rank_RNS: T_RNS;
  R1_rank_dec: T_dec;
  R1_CRT_dec: T_dec;

  R2_int64: int64;
  R2_RNS: T_RNS;
  R2_MRS: T_RNS;
  R2_dec: T_dec;
  R2_rank_RNS: T_RNS;
  R2_rank_dec: T_dec;
  R2_CRT_dec: T_dec;

  mem_int64: int64;
  mem_RNS: T_RNS;
  mem_MRS: T_RNS;
  mem_dec: T_dec;
  mem_rank_RNS: T_RNS;
  mem_rank_dec: T_dec;
  mem_CRT_dec: T_dec;

implementation

{$R *.lfm}

{ TForm1 }

function GCD(a,b:integer):integer;
var k,tmp_res:integer;
begin
     tmp_res:=1;
     for k:=1 to a do if (a mod k=0)and(b mod k=0) then tmp_res:=k;
     GCD:=tmp_res;
end;

function Common_primarity_check:boolean;
var flag:boolean; i,j:integer;
begin
     flag:=true;
     for i:=1 to n_ext do
     for j:=i+1 to n_ext do
         if GCD(P[i],P[j])<>1 then
         begin
            form1.SG_P_basis.Cells[0,i]:=IntToStr(GCD(P[i],P[j]));
            form1.SG_P_basis.Cells[0,j]:=IntToStr(GCD(P[i],P[j]));
            flag:=false;
         end;
     Common_primarity_check:=flag;
end;

procedure P_correction;
var i,k,tmp:integer; flag:boolean;
begin
     for k:=1 to n_ext do
        repeat
           flag:=true;
           for i:=1 to k-1 do if P[k]=P[i] then flag:=false;
           if not(flag) then
           begin
              tmp:=random(max_n)+1;
              P[k]:=primes[tmp];
           end;
        until flag;
end;

procedure TForm1.init_sub;
var k,tmp:integer;
begin
  for k:=1 to n_ext do
  begin
    tmp:=StrToInt(SG_P_basis.Cells[1,k]);
    if tmp<2 then tmp:=2;
    if tmp>max_p then tmp:=max_p;
    SG_P_basis.Cells[1,k]:=IntToStr(tmp);
  end;

  for k:=1 to n_ext do P[k]:=StrToInt(SG_P_basis.Cells[1,k]);

  P_correction;
     if Common_primarity_check then
        SG_P_basis.Cells[2,0]:='Ортогональные базисы (P взаимно простые)'
     else
        SG_P_basis.Cells[2,0]:='Ортогональные базисы (нет взаимной простоты P)';

     calc_rns_a_tables;
     calc_rns_math_tables;
     calc_rns_pow2_table;
     calc_rns_pow10_table;

     calc_PP_dec(n,n_dec,p_sv,pp_dec);
     Edit_PP.text:=modulo_to_str(n_dec,pp_dec);

     for k:=1 to n_ext do SG_P_basis.Cells[0,k]:=IntToStr(k);
     for k:=1 to n_ext do SG_P_basis.Cells[1,k]:=IntToStr(P[k]);

     for k:=1 to n do calc_RNS_basis_dec(n,n_dec,k,p_sv,basis_dec[k]);
     for k:=1 to n do SG_P_basis.Cells[2,k]:=modulo_to_str(n_dec,basis_dec[k]);
     for k:=1 to n do
         if SG_P_basis.Cells[2,k]='0' then
            SG_P_basis.Cells[2,k]:='не найдено (возможна ошибка расчета ранга и КТО)';
     for k:=n+1 to n_ext do SG_P_basis.Cells[2,k]:='техническое основание (расширенная СОК)';

     SG_P_basis.AutoSizeColumn(1);
     SG_P_basis.ColWidths[2]:=SG_P_basis.Width-SG_P_basis.ColWidths[0]-SG_P_basis.ColWidths[1]-40;

     for k:=1 to n do Accum_RNS[k]:=Accum_RNS[k] mod P[k];
     for k:=1 to n do R1_RNS[k]:=R1_RNS[k] mod P[k];
     for k:=1 to n do R2_RNS[k]:=R2_RNS[k] mod P[k];
     for k:=1 to n do mem_RNS[k]:=mem_RNS[k] mod P[k];
end;

procedure TForm1.refresh_visual;
var k:integer;
begin
  Accum_MRS:=RNS_to_MRS(n,Accum_RNS,p_sv);
  R1_MRS:=RNS_to_MRS(n,R1_RNS,p_sv);
  R2_MRS:=RNS_to_MRS(n,R2_RNS,p_sv);
  mem_MRS:=RNS_to_MRS(n,mem_RNS,p_sv);
  for k:=1 to n do
  begin
    SG_accum.Cells[k,0]:=IntToStr(P[k]);
    SG_accum.Cells[k,1]:=IntToStr(accum_RNS[k]);
    SG_accum.Cells[k,2]:=IntToStr(accum_MRS[k]);

    SG_R1.Cells[k,0]:=IntToStr(P[k]);
    SG_R1.Cells[k,1]:=IntToStr(R1_RNS[k]);
    SG_R1.Cells[k,2]:=IntToStr(R1_MRS[k]);

    SG_R2.Cells[k,0]:=IntToStr(P[k]);
    SG_R2.Cells[k,1]:=IntToStr(R2_RNS[k]);
    SG_R2.Cells[k,2]:=IntToStr(R2_MRS[k]);

    SG_mem.Cells[k,0]:=IntToStr(P[k]);
    SG_mem.Cells[k,1]:=IntToStr(mem_RNS[k]);
    SG_mem.Cells[k,2]:=IntToStr(mem_MRS[k]);
  end;

  Accum_dec:=RNS_to_dec(n,n_dec,accum_RNS,p_sv);
  Edit_Accum_dec.text:=modulo_to_str(n_dec,Accum_dec);

  Accum_rank_RNS:=RNS_rank(n,n_ext,Accum_RNS,p_sv);
  Accum_rank_dec:=RNS_to_dec(n,n_dec,accum_rank_RNS,p_sv);
  Edit_accum_rank.text:=modulo_to_str(n_dec,Accum_rank_dec);

  Accum_CRT_dec:=RNS_to_dec_CRT(n,n_ext,n_dec_ext,accum_RNS,p_sv);
  Edit_accum_CRT.text:=modulo_to_str(n_dec_ext,Accum_CRT_dec);

  R1_dec:=RNS_to_dec(n,n_dec,R1_RNS,p_sv);
  Edit_R1_dec.text:=modulo_to_str(n_dec,R1_dec);

  R1_rank_RNS:=RNS_rank(n,n_ext,R1_RNS,p_sv);
  R1_rank_dec:=RNS_to_dec(n,n_dec,R1_rank_RNS,p_sv);
  Edit_R1_rank.text:=modulo_to_str(n_dec,R1_rank_dec);

  R1_CRT_dec:=RNS_to_dec_CRT(n,n_ext,n_dec_ext,R1_RNS,p_sv);
  Edit_R1_CRT.text:=modulo_to_str(n_dec_ext,R1_CRT_dec);

  R2_dec:=RNS_to_dec(n,n_dec,R2_RNS,p_sv);
  Edit_R2_dec.text:=modulo_to_str(n_dec,R2_dec);

  R2_rank_RNS:=RNS_rank(n,n_ext,R2_RNS,p_sv);
  R2_rank_dec:=RNS_to_dec(n,n_dec,R2_rank_RNS,p_sv);
  Edit_R2_rank.text:=modulo_to_str(n_dec,R2_rank_dec);

  R2_CRT_dec:=RNS_to_dec_CRT(n,n_ext,n_dec_ext,R2_RNS,p_sv);
  Edit_R2_CRT.text:=modulo_to_str(n_dec_ext,R2_CRT_dec);

  mem_dec:=RNS_to_dec(n,n_dec,mem_RNS,p_sv);
  Edit_mem_dec.text:=modulo_to_str(n_dec,mem_dec);

  mem_rank_RNS:=RNS_rank(n,n_ext,mem_RNS,p_sv);
  mem_rank_dec:=RNS_to_dec(n,n_dec,mem_rank_RNS,p_sv);
  Edit_mem_rank.text:=modulo_to_str(n_dec,mem_rank_dec);

  mem_CRT_dec:=RNS_to_dec_CRT(n,n_ext,n_dec_ext,mem_RNS,p_sv);
  Edit_mem_CRT.text:=modulo_to_str(n_dec_ext,mem_CRT_dec);
end;

procedure TForm1.FormCreate(Sender: TObject);
var k:integer;
begin
  for k:=1 to max_n do p_sv[k]:=k;
  for k:=1 to max_n do accum_RNS[k]:=0;
  for k:=1 to max_n do R1_RNS[k]:=0;
  for k:=1 to max_n do R2_RNS[k]:=0;
  for k:=1 to max_n do mem_RNS[k]:=0;

  Calc_Primes;
  n:=10; n_ext:=20; n_dec:=64; n_dec_ext:=75;
  Edit_n.text:=IntToStr(n);
  Edit_n_ext.text:=IntToStr(n_ext);

  for k:=1 to max_n do P[k]:=primes[k];
  SG_P_basis.RowCount:=n_ext+1;
  SG_Accum.ColCount:=n+1;
  SG_R1.ColCount:=n+1;
  SG_R2.ColCount:=n+1;
  SG_mem.ColCount:=n+1;

  SG_P_basis.Cells[1,0]:='P';
  SG_accum.Cells[0,0]:='P'; SG_accum.Cells[0,1]:='RNS'; SG_accum.Cells[0,2]:='MRS';
  SG_R1.Cells[0,0]:='P'; SG_R1.Cells[0,1]:='RNS'; SG_R1.Cells[0,2]:='MRS';
  SG_R2.Cells[0,0]:='P'; SG_R2.Cells[0,1]:='RNS'; SG_R2.Cells[0,2]:='MRS';
  SG_mem.Cells[0,0]:='P'; SG_mem.Cells[0,1]:='RNS'; SG_mem.Cells[0,2]:='MRS';

  for k:=1 to n_ext do SG_P_basis.Cells[1,k]:=IntToStr(P[k]);
  init_sub;
  refresh_visual;
end;

procedure TForm1.SG_AccumEditingDone(Sender: TObject);
var k:integer; tmp_rns,tmp_mrs:T_RNS; flag_rns,flag_mrs:boolean;
begin
  flag_rns:=false; flag_mrs:=false;
  for k:=1 to n do
  begin
     tmp_rns[k]:=StrToInt(SG_accum.Cells[k,1]) mod P[k];
     tmp_mrs[k]:=StrToInt(SG_accum.Cells[k,2]) mod P[k];
  end;
  if not(modulo_cmp_equ(n,Accum_RNS,tmp_rns)) then flag_rns:=true;
  if not(modulo_cmp_equ(n,Accum_MRS,tmp_mrs)) then flag_mrs:=true;
  if flag_rns then modulo_copy(n,tmp_rns,Accum_RNS);
  if flag_mrs then Accum_RNS:=MRS_to_RNS(n,tmp_mrs,p_sv);
  refresh_visual;
end;

procedure TForm1.SG_memEditingDone(Sender: TObject);
var k:integer; tmp_rns,tmp_mrs:T_RNS; flag_rns,flag_mrs:boolean;
begin
  flag_rns:=false; flag_mrs:=false;
  for k:=1 to n do
  begin
     tmp_rns[k]:=StrToInt(SG_mem.Cells[k,1]) mod P[k];
     tmp_mrs[k]:=StrToInt(SG_mem.Cells[k,2]) mod P[k];
  end;
  if not(modulo_cmp_equ(n,mem_RNS,tmp_rns)) then flag_rns:=true;
  if not(modulo_cmp_equ(n,mem_MRS,tmp_mrs)) then flag_mrs:=true;
  if flag_rns then modulo_copy(n,tmp_rns,mem_RNS);
  if flag_mrs then mem_RNS:=MRS_to_RNS(n,tmp_mrs,p_sv);
  refresh_visual;
end;

procedure TForm1.SG_P_basisEditingDone(Sender: TObject);
begin
  init_sub;
  refresh_visual;
end;

procedure TForm1.SG_R1EditingDone(Sender: TObject);
var k:integer; tmp_rns,tmp_mrs:T_RNS; flag_rns,flag_mrs:boolean;
begin
  flag_rns:=false; flag_mrs:=false;
  for k:=1 to n do
  begin
     tmp_rns[k]:=StrToInt(SG_R1.Cells[k,1]) mod P[k];
     tmp_mrs[k]:=StrToInt(SG_R1.Cells[k,2]) mod P[k];
  end;
  if not(modulo_cmp_equ(n,R1_RNS,tmp_rns)) then flag_rns:=true;
  if not(modulo_cmp_equ(n,R1_MRS,tmp_mrs)) then flag_mrs:=true;
  if flag_rns then modulo_copy(n,tmp_rns,R1_RNS);
  if flag_mrs then R1_RNS:=MRS_to_RNS(n,tmp_mrs,p_sv);
  refresh_visual;
end;

procedure TForm1.SG_R2EditingDone(Sender: TObject);
var k:integer; tmp_rns,tmp_mrs:T_RNS; flag_rns,flag_mrs:boolean;
begin
  flag_rns:=false; flag_mrs:=false;
  for k:=1 to n do
  begin
     tmp_rns[k]:=StrToInt(SG_R2.Cells[k,1]) mod P[k];
     tmp_mrs[k]:=StrToInt(SG_R2.Cells[k,2]) mod P[k];
  end;
  if not(modulo_cmp_equ(n,R2_RNS,tmp_rns)) then flag_rns:=true;
  if not(modulo_cmp_equ(n,R2_MRS,tmp_mrs)) then flag_mrs:=true;
  if flag_rns then modulo_copy(n,tmp_rns,R2_RNS);
  if flag_mrs then R2_RNS:=MRS_to_RNS(n,tmp_mrs,p_sv);
  refresh_visual;
end;

procedure TForm1.BTN_addClick(Sender: TObject);
begin
     accum_RNS:=RNS_add(n,R1_RNS,R2_RNS,p_sv);
     refresh_visual;
end;

procedure TForm1.BTN_cmpClick(Sender: TObject);
var s:string; tmp:integer;
begin
     tmp:=RNS_cmp(n,R1_rns,R2_rns,p_sv);
     if tmp=0 then s:='регистры равны';
     if tmp<0 then s:='второй регистр больше';
     if tmp>0 then s:='первый регистр больше';
     MessageBox(0,PChar(s),'сравнение',MB_OK);
end;

procedure TForm1.BTN_accum_to_memClick(Sender: TObject);
begin
  modulo_copy(n,accum_RNS,mem_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_accum_from_memClick(Sender: TObject);
begin
  modulo_copy(n,mem_RNS,accum_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_accum_swap_memClick(Sender: TObject);
var tmp:T_RNS;
begin
  modulo_copy(n,mem_RNS,tmp);
  modulo_copy(n,accum_RNS,mem_RNS);
  modulo_copy(n,tmp,accum_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_divClick(Sender: TObject);
begin
  accum_RNS:=RNS_div(n,R1_RNS,R2_RNS,p_sv);
  refresh_visual;
end;

procedure TForm1.BTN_mulClick(Sender: TObject);
begin
  accum_RNS:=RNS_mul(n,R1_RNS,R2_RNS,p_sv);
  refresh_visual;
end;

procedure TForm1.BTN_R1_from_memClick(Sender: TObject);
begin
  modulo_copy(n,mem_RNS,R1_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_R1_from_R2Click(Sender: TObject);
begin
  modulo_copy(n,R2_RNS,R1_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_R1_to_memClick(Sender: TObject);
begin
  modulo_copy(n,R1_RNS,mem_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_R1_to_R2Click(Sender: TObject);
begin
  modulo_copy(n,R1_RNS,R2_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_R2_from_memClick(Sender: TObject);
begin
  modulo_copy(n,mem_RNS,R2_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_R2_from_R1Click(Sender: TObject);
begin
  modulo_copy(n,R1_RNS,R2_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_R2_swap_mem1Click(Sender: TObject);
var tmp:T_RNS;
begin
  modulo_copy(n,mem_RNS,tmp);
  modulo_copy(n,R1_RNS,mem_RNS);
  modulo_copy(n,tmp,R1_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_R2_swap_memClick(Sender: TObject);
var tmp:T_RNS;
begin
  modulo_copy(n,mem_RNS,tmp);
  modulo_copy(n,R2_RNS,mem_RNS);
  modulo_copy(n,tmp,R2_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_R1_swap_R2Click(Sender: TObject);
var tmp:T_RNS;
begin
  modulo_copy(n,R2_RNS,tmp);
  modulo_copy(n,R1_RNS,R2_RNS);
  modulo_copy(n,tmp,R1_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_R2_to_memClick(Sender: TObject);
begin
  modulo_copy(n,R2_RNS,mem_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_R2_to_R1Click(Sender: TObject);
begin
  modulo_copy(n,R2_RNS,R1_RNS);
  refresh_visual;
end;

procedure TForm1.BTN_nClick(Sender: TObject);
var k,tmp_n:integer;
begin
  for k:=1 to max_n do accum_RNS[k]:=0;
  for k:=1 to max_n do R1_RNS[k]:=0;
  for k:=1 to max_n do R2_RNS[k]:=0;
  for k:=1 to max_n do mem_RNS[k]:=0;

  tmp_n:=StrToInt(Edit_n.text);
  if tmp_n<1 then tmp_n:=1;
  if tmp_n>n_ext then tmp_n:=n_ext;
  edit_n.text:=IntToStr(tmp_n);
  for k:=n+1 to tmp_n do P[k]:=primes[k];
  n:=tmp_n;

  SG_Accum.ColCount:=n+1;
  SG_R1.ColCount:=n+1;
  SG_R2.ColCount:=n+1;
  SG_mem.ColCount:=n+1;

  for k:=1 to n_ext do SG_P_basis.Cells[1,k]:=IntToStr(P[k]);
  init_sub;
  refresh_visual;
end;

procedure TForm1.BTN_R2_swap_R1Click(Sender: TObject);
var tmp:T_RNS;
begin
     modulo_copy(n,R1_RNS,tmp);
     modulo_copy(n,R2_RNS,R1_RNS);
     modulo_copy(n,tmp,R2_RNS);
     refresh_visual;
end;

procedure TForm1.BTN_remClick(Sender: TObject);
begin
  accum_RNS:=RNS_mod(n,R1_RNS,R2_RNS,p_sv);
  refresh_visual;
end;

procedure TForm1.BTN_subClick(Sender: TObject);
begin
     accum_RNS:=RNS_sub(n,R1_RNS,R2_RNS,p_sv);
     refresh_visual;
end;

procedure TForm1.BTN_primesClick(Sender: TObject);
var k:integer;
begin
  for k:=1 to max_n do P[k]:=primes[k];
  for k:=1 to max_n do accum_RNS[k]:=0;
  for k:=1 to max_n do R1_RNS[k]:=0;
  for k:=1 to max_n do R2_RNS[k]:=0;
  for k:=1 to max_n do mem_RNS[k]:=0;
  for k:=1 to n_ext do SG_P_basis.cells[1,k]:=IntToStr(P[k]);
  init_sub;
  refresh_visual;
end;

procedure TForm1.BTN_n_extClick(Sender: TObject);
var k:integer;
begin
  n_ext:=StrToInt(edit_n_ext.text);
  if n_ext<n then n_ext:=n;
  if n_ext>max_n then n_ext:=max_n;
  edit_n_ext.text:=IntToStr(n_ext);
  SG_P_basis.RowCount:=n_ext+1;
  for k:=1 to n_ext do SG_P_basis.Cells[1,k]:=IntToStr(P[k]);
  init_sub;
  refresh_visual;
end;

procedure TForm1.Edit_Accum_decChange(Sender: TObject);
begin
  Str_to_modulo(n_dec,Edit_accum_dec.text,Accum_dec);
  accum_RNS:=dec_to_RNS(n,n_dec,accum_dec,p_sv);
  refresh_visual;
end;

procedure TForm1.Edit_mem_decChange(Sender: TObject);
begin
  Str_to_modulo(n_dec,Edit_mem_dec.text,mem_dec);
  mem_RNS:=dec_to_RNS(n,n_dec,mem_dec,p_sv);
  refresh_visual;
end;

procedure TForm1.Edit_R1_decChange(Sender: TObject);
begin
  Str_to_modulo(n_dec,Edit_R1_dec.text,R1_dec);
  R1_RNS:=dec_to_RNS(n,n_dec,R1_dec,p_sv);
  refresh_visual;
end;

procedure TForm1.Edit_R2_decChange(Sender: TObject);
begin
  Str_to_modulo(n_dec,Edit_R2_dec.text,R2_dec);
  R2_RNS:=dec_to_RNS(n,n_dec,R2_dec,p_sv);
  refresh_visual;
end;

end.

