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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Inicialized: Boolean;
    procedure InicializeApplication();
    procedure ShowPainelGestao;
    procedure ShowLogin;
    function VerificarValidadeLogin: Boolean;
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses UfrmPainelGestao, UfrmLogin, UiniUtils, UFormUtils;

procedure TfrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmSplash);
end;

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
  begin
    if VerificarValidadeLogin then
      begin
        ShowPainelGestao;
      end
    else
      begin
        ShowLogin;
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

function TfrmSplash.VerificarValidadeLogin: Boolean;
  const
    LDias : integer = 5; // 5 Dias;
  var
    LLogado : String;
    LTesteData : TDateTime;
    LLerData: Boolean;
  begin
    LLogado := TIniUtils.lerPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO);
    LLerData := TryStrToDate(TIniUtils.lerPropriedade
     (TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADOEM), LTesteData);
    Result := (LLogado = TIniUtils.VALOR_VERDADEIRO) and
              (LLerData) and
              (incDay(LTesteData, LDias) >= today());
  end;

procedure TfrmSplash.ShowLogin;
  begin
    //TFormUtils.ChangeOpenedForm(TfrmLogin, frmLogin, TfrmSplash);

    if not Assigned(frmLogin) then
    begin
      Application.CreateForm(TfrmLogin, frmLogin);
    end;

    TFormUtils.SetMainForm(frmLogin);
    frmLogin.Show();

    Close;

  //      TIniUtils.GravarPropriedade
  //      (TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADOEM, '');
  //      TIniUtils.GravarPropriedade
  //      (TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADOPOR, '');
  end;

procedure TfrmSplash.ShowPainelGestao;
  begin
  //  TFormUtils.ChangeOpenedForm(TfrmPainelGestao, frmPainelGestao, frmSplash);
    if not Assigned(frmPainelGestao) then
    begin
      Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
    end;

    TFormUtils.SetMainForm(frmPainelGestao);
    frmPainelGestao.Show();

    Close;
  end;

end.


