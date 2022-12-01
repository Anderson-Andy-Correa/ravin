unit UfrmPainelGestao;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Imaging.pngimage,
  UfrmItemMenu;

type
  TfrmPainelGestao = class(TForm)
    pnlMenu: TPanel;
    lblPainelGestaoTitulo: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    shpQtdPedidosPorDia: TShape;
    Shape4: TShape;
    Shape5: TShape;
    imgLogomarca: TImage;
    lblNomeUsuario: TLabel;
    frmMenuItemMesas: TfrmMenuItem;
    frmMenuItemComandas: TfrmMenuItem;
    frmMenuItemPessoas: TfrmMenuItem;
    frmMenuItemProdutos: TfrmMenuItem;
    frmMenuItemConfiguracoes: TfrmMenuItem;
    frmMenuItemSobre: TfrmMenuItem;
    frmMenuItemSair: TfrmMenuItem;
    procedure FrameMenuItemMesasLabelTitleClick(Sender: TObject);
    procedure frmMenuItemSobrelblTituloClick(Sender: TObject);
    procedure frmMenuItemSairlblTituloClick(Sender: TObject);
    procedure frmMenuItemProdutoslblTituloClick(Sender: TObject);
    procedure frmMenuItemMesaslblTituloClick(Sender: TObject);
    procedure frmMenuItemComandaslblTituloClick(Sender: TObject);
    procedure frmMenuItemPessoaslblTituloClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPainelGestao: TfrmPainelGestao;

implementation

{$R *.dfm}

uses
  UfrmSobre,
  UfrmProdutos,
  UfrmMesas,
  UfrmComandas,
  UiniUtils,
  UfrmRegistrar,
  UfrmLogin,
  UFormUtils, UfrmListaClientes;

procedure TfrmPainelGestao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(frmPainelGestao);
end;

procedure TfrmPainelGestao.FrameMenuItemMesasLabelTitleClick(Sender: TObject);
  begin
    TFormUtils.ChangeOpenedForm(TfrmMesas, frmMesas);
  //  if (not Assigned(frmMesas)) then
  //  begin
  //    Application.CreateForm(TfrmMesas, frmMesas);
  //  end;
  //  frmMesas.show();
  end;

procedure TfrmPainelGestao.frmMenuItemComandaslblTituloClick(Sender: TObject);
  begin
    TFormUtils.ChangeOpenedForm(TfrmComandas, frmComandas);
  //  if(not Assigned(frmComandas)) then begin
  //    Application.CreateForm(TfrmComandas, frmComandas);
  //  end;
  //
  //  frmComandas.show();
  end;

procedure TfrmPainelGestao.frmMenuItemMesaslblTituloClick(Sender: TObject);
  begin
    TFormUtils.ChangeOpenedForm(TfrmMesas, frmMesas);
  //  if (not Assigned(frmMesas)) then
  //  begin
  //    Application.CreateForm(TfrmMesas, frmMesas);
  //  end;
  //  frmMesas.show();
  end;

procedure TfrmPainelGestao.frmMenuItemPessoaslblTituloClick(Sender: TObject);
begin
  if (not Assigned(frmListaClientes)) then
    begin
      Application.CreateForm(TfrmListaClientes, frmListaClientes);
    end;
    frmListaClientes.show();
end;

procedure TfrmPainelGestao.frmMenuItemProdutoslblTituloClick(Sender: TObject);
  begin
    TFormUtils.ChangeOpenedForm(TfrmProdutos, frmProdutos);
  //  if (not Assigned(frmProdutos)) then
  //  begin
  //    Application.CreateForm(TfrmProdutos, frmProdutos);
  //  end;
  //  frmProdutos.show();
  end;

procedure TfrmPainelGestao.frmMenuItemSairlblTituloClick(Sender: TObject);
  begin
    TIniUtils.gravarPropriedade(TSecao.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO, TIniUtils.VALOR_FALSO);
    TFormUtils.ChangeOpenedForm(TfrmLogin, frmLogin, frmPainelGestao);
  //  if not Assigned(frmLogin) then
  //    begin
  //      Application.CreateForm(TfrmLogin, frmLogin);
  //    end;
  //
  //    SetarFormPrincipal(frmLogin);
  //    frmLogin.Show();
  //
  //    Close();
  end;

procedure TfrmPainelGestao.frmMenuItemSobrelblTituloClick(Sender: TObject);
  begin
    TFormUtils.ChangeOpenedForm(TfrmSobre, frmSobre);
  //  if (not Assigned(frmSobre)) then
  //  begin
  //    Application.CreateForm(TfrmSobre, frmSobre)
  //  end;
  //  frmSobre.show();
  end;

end.
