unit Uusuario;

interface

Type
  TUsuario =  class
    private
    FID: integer;
    FLogin: String;
    FSenha: String;
    FPessoaId: Integer;
    FCriadoEm: TDateTime;
    FCriadoPor: String;
    FAlteradoEm: TDateTime;
    FAlteradoPor: String;

    protected

    public
      property ID: integer read FID write FID;
      property Login: String read FLogin write FLogin;
      property Senha: String read FSenha write FSenha;
      property PessoaId: Integer read FPessoaId write FPessoaId;
      property CriadoEm: TDateTime read FCriadoEm write FCriadoEm;
      property CriadoPor: String read FCriadoPor write FCriadoPor;
      property AlteradoEm: TDateTime read FAlteradoEm write FAlteradoEm;
      property AlteradoPor: String read FAlteradoPor write FAlteradoPor;
  end;

implementation

end.
