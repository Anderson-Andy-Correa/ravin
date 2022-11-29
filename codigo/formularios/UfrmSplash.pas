unit UfrmSplash;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,
  System.DateUtils,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,

  UfrmLogomarca;

type
  TfrmSplash = class(TForm)
    pnlFundo: TPanel;
    tmrSplash: TTimer;
    frmLogo: TfrmLogo;
    procedure tmrSplashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    Inicialized: Boolean;
    procedure InicializeApplication();
    procedure ShowPainelGestao;
    procedure ShowLogin;
    procedure SetMainForm(NewMainForm: TForm);
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses UfrmPainelGestao, UfrmLogin, UiniUtils;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  Inicialized := false;
  tmrSplash.Enabled := false;
  tmrSplash.Interval := 1000;
end;

procedure TfrmSplash.FormPaint(Sender: TObject);
begin
  tmrSplash.Enabled := not Inicialized;
end;

procedure TfrmSplash.InicializeApplication;
var
  LLogado : String;
  LTesteData : TDateTime;
  LLerData: Boolean;
begin
  LLogado := TIniUtils.lerPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO);
  LLerData := TryStrToDate(TIniUtils.lerPropriedade
   (TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADOEM), LTesteData);
  if (LLogado = TIniUtils.VALOR_VERDADEIRO) and
     (LLerData) and
     (incDay(LTesteData, 5) >= today()) then // 5 Dias
    begin
      ShowPainelGestao;
    end
  else
    begin
      ShowLogin;
//      TIniUtils.GravarPropriedade
//      (TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADOEM, '');
//      TIniUtils.GravarPropriedade
//      (TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADOPOR, '');
    end;
end;

procedure TfrmSplash.tmrSplashTimer(Sender: TObject);
begin
  tmrSplash.Enabled := false;
  if not Inicialized then
  begin
    Inicialized := true;
    InicializeApplication();
  end;
end;

procedure TfrmSplash.SetMainForm(NewMainForm: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := NewMainForm;
end;

procedure TfrmSplash.ShowLogin;
begin
  if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  SetMainForm(frmLogin);
  frmLogin.Show();

  Close;
end;

procedure TfrmSplash.ShowPainelGestao;
begin
  if not Assigned(frmPainelGestao) then
  begin
    Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
  end;

  SetMainForm(frmPainelGestao);
  frmPainelGestao.Show();

  Close;
end;

end.


