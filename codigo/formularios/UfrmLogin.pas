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
    procedure frmAutenticar1spdAutenticarClick(Sender: TObject);
    procedure lblSubTituloRegistrarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses
  UfrmPainelGestao, UusuarioDao, Uusuario, UfrmRegistrar, UiniUtils, UFormUtils;

{$R *.dfm}

procedure TfrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
    edtLogin.Text := '';
    edtSenha.text := '';
  end;

procedure TfrmLogin.frmAutenticar1spdAutenticarClick(Sender: TObject);
  var
    LDao: TUsuarioDAO;
    LUsuario: TUsuario;
    LLogin: String;
    LSenha: String;
  begin
    LLogin := edtLogin.Text;
    LSenha := edtSenha.Text;

    LDao := TUsuarioDAO.Create;

    LUsuario := LDao.BuscarUsuarioPorLoginSenha(LLogin, LSenha);

    if Assigned(LUsuario) then
      begin
        TIniUtils.gravarPropriedade(TSecao.INFORMACOES_GERAIS,
         TPROPRIEDADE.LOGADO, TIniUtils.VALOR_VERDADEIRO);
        TIniUtils.gravarPropriedade(TSecao.INFORMACOES_GERAIS,
         TPROPRIEDADE.LOGADOEM, DateToStr(NOW()));
        TIniUtils.gravarPropriedade(TSecao.INFORMACOES_GERAIS,
         TPROPRIEDADE.LOGADOPOR, LLogin);

        TFormUtils.ChangeOpenedForm(TfrmPainelGestao, frmPainelGestao, frmLogin);

//        if not assigned(frmPainelGestao) then
//          begin
//            application.CreateForm(TfrmPainelGestao, frmPainelGestao);
//          end;
//
//         SetarFormPrincipal(frmPainelGestao);
//         frmPainelGestao.Show;
//
//         edtLogin.Text := '';
//         edtSenha.text := '';
//         Close();
      end
    else
      begin
        ShowMessage('Login e/ou senha inválidos!');
      end;

    FreeAndNil(LUsuario);
    FreeAndNil(LDAo);
  end;

procedure TfrmLogin.lblSubTituloRegistrarClick(Sender: TObject);
  begin
    TFormUtils.ChangeOpenedForm(TfrmRegistrar, frmRegistrar, frmLogin);
//    if not Assigned(frmRegistrar) then
//    begin
//      Application.CreateForm(TfrmRegistrar, frmRegistrar);
//    end;
//
//    SetarFormPrincipal(frmRegistrar);
//    frmRegistrar.Show();
//
//    Close();
  end;

end.
