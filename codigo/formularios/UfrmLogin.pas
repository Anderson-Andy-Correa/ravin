unit UfrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage, Vcl.ExtCtrls,
  Vcl.StdCtrls, UfrmAutenticar;

type
  TfrmLogin = class(TForm)
    pnlAutentificacao: TPanel;
    edtLogin: TEdit;
    imgFundo: TImage;
    imgLogo: TImage;
    edtSenha: TEdit;
    lblTitulo: TLabel;
    lblSubTitulo: TLabel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    frmAutenticar1: TfrmAutenticar;
    Button1: TButton;
    procedure frmAutenticar1spdAutenticarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure SetarFormPrincipal(PNovoFormulario: TForm);
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UfrmPainelGestao, UusuarioDao, Uusuario;

{$R *.dfm}

procedure TfrmLogin.Button1Click(Sender: TObject);
  var
    LUsuario: TUsuario;
    LDao: TUsuarioDao;
  begin
    LUsuario := TUsuario.Create;
    with LUsuario do
      begin
        login := 'teste';
        senha := '123';
        pessoaID := 1;
        criadoEm := now();
        criadoPor := 'Andy';
        alteradoEm := now();
        alteradoPor := 'Andy';
      end;
    LDao := TUsuarioDao.Create;
    LDao.InserirUsuario(LUsuario);

    FreeAndNil(LDao);
    FreeAndNil(LUsuario);
  end;

procedure TfrmLogin.frmAutenticar1spdAutenticarClick(Sender: TObject);
  var
    LDao: TUsuarioDAO;
    LUsuario: TUsuario;
    LLogin: String;
    LSenha: String;
  begin
    LDao := TUsuarioDAO.Create;

    LLogin := edtLogin.Text;
    LSenha := edtSenha.Text;

    LUsuario := LDao.BuscarUsuarioPorLoginSenha(LLogin, LSenha);

    if Assigned(LUsuario) then
      begin
        if not assigned(frmPainelGestao) then
          begin
            application.CreateForm(TfrmPainelGestao, frmPainelGestao);
          end;

         SetarFormPrincipal(frmPainelGestao);
         frmPainelGestao.Show;

         Close();
      end
    else
      begin
        ShowMessage('Login e/ou senha inválidos!');
      end;

    FreeAndNil(LUsuario);
    FreeAndNil(LDAo);
  end;

procedure TfrmLogin.SetarFormPrincipal(PNovoFormulario: TForm);
  var
    tmpMain: ^TCustomForm;
  begin
    tmpMain := @Application.Mainform;
    tmpMain^ := PNovoFormulario;
  end;

end.
