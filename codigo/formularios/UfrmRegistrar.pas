unit UfrmRegistrar;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UfrmBotaoPrimario,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  UfrmAutenticar,
  System.Actions,
  Vcl.ActnList, 
  Vcl.ExtActns, 
  UfrmLogin, 
  ValidadorUsuario,
  
  FireDAC.Phys.MySQLWrapper;

type
  TfrmRegistrar = class(TForm)
    imgFundo: TImage;
    pnlRegistrar: TPanel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    lblTituloAutenticar: TLabel;
    lblSubTituloAutenticar: TLabel;
    edtNome: TEdit;
    edtCpf: TEdit;
    frmBotaoPrimarioRegistrar: TfrmBotaoPrimario;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtConfirmarSenha: TEdit;
    procedure lblSubTituloAutenticarClick(Sender: TObject);
    procedure frmBotaoPrimarioRegistrarspbBotaoPrimarioClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetMainForm(NovoMainForm: TForm);
  public
    { Public declarations }
  end;

var
  frmRegistrar: TfrmRegistrar;

implementation

uses
  Uusuario, UusuarioDao;

{$R *.dfm}

procedure TfrmRegistrar.frmBotaoPrimarioRegistrarspbBotaoPrimarioClick(
  Sender: TObject);
  var
    LUsuario: TUsuario;
    Ldao: TUsuariodao;
begin

  //Registrar
  //Ler os Valores dos campos
  //Creiar o objeto de usuário
  //Setar os valores
  //Criar um Dao
  //Chamar o método para salvar o usuário

  try
    try
      LUsuario := TUsuario.create;
      with LUsuario do
        begin
          login := edtLogin.Text;
          senha := edtSenha.Text;
          pessoaid := 1;
          criadoEm := now();
          criadoPor := 'admin';
          alteradoEM := now();
          AlteradoPor := 'admin';
        end;

      TValidadorUsuario.Validar(LUsuario, edtConfirmarSenha.text);

      LDao := TUsuarioDAO.Create;
      LDao.InserirUsuario(LUsuario);

    except
      on E: EMySQLNativeException do
        begin
          ShowMessage('Erro ao inserir o usuário no banco.');
        end;
      on E: Exception do
        begin
          ShowMessage(E.Message);
        end;
    end;
  finally
    if assigned(LDao) then
      begin
        FreeAndNil(LDao);
      end;
    FreeAndNil(LUsuario);
  end;
  
end;

procedure TfrmRegistrar.lblSubTituloAutenticarClick(Sender: TObject);
begin
  if not Assigned(frmLogin) then
  begin
    Application.CreateForm(TfrmLogin, frmLogin);
  end;

  SetMainForm(frmLogin);
  frmLogin.Show();

  Close();
end;

procedure TfrmRegistrar.SetMainForm(NovoMainForm: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := NovoMainForm;
end;

end.
