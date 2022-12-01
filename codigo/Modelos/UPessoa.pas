unit UPessoa;

interface

Type
  TPessoa =  class
    private
    FID: integer;
    FNome: String;
    FTipoPessoa: String;
    FCPF: String;
    FTelefone: integer;
    FAtivo: Byte;
    FCriadoEm: TDateTime;
    FCriadoPor: String;
    FAlteradoEm: TDateTime;
    FAlteradoPor: String;

    protected

    public
      property ID: integer read FID write FID;
      property Nome: String read FNome write FNome;
      property TipoPessoa: String read FTipoPessoa write FTipoPessoa;
      property CPF: String read FCPF write FCPF;
      property Telefone: integer read FTelefone write FTelefone;
      property Ativo: Byte read FAtivo write FAtivo;
      property CriadoEm: TDateTime read FCriadoEm write FCriadoEm;
      property CriadoPor: String read FCriadoPor write FCriadoPor;
      property AlteradoEm: TDateTime read FAlteradoEm write FAlteradoEm;
      property AlteradoPor: String read FAlteradoPor write FAlteradoPor;
  end;

implementation

end.
