unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    btnOk: TButton;
    tEdit: TEdit;
    RESTClient1: TRESTClient;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Label1: TLabel;
    Button1: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RESTRequest1HTTPProtocolError(Sender: TCustomRESTRequest);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnOkClick(Sender: TObject);
begin
  if tEdit.Text = '' then
  raise Exception.Create('Campo para pesquisa vazio')
  else
    begin
        RESTRequest1.Params.AddUrlSegment('ORIGEM', tEdit.Text);
        RESTRequest1.Execute;
      
      
      

      Memo1.Lines.Clear;

      if (RESTResponse1.JSONValue.GetValue<string>('status') = 'ERROR') or
      (RESTResponse1.JSONValue.GetValue<string>('status') = '')  then
      begin
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('status'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('message'));
        btnOk.Enabled := false;
        tEdit.Enabled := false;
      end
      else
      begin
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('nome'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('fantasia'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('cnpj'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('tipo'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('situacao'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('abertura'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('logradouro'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('numero'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('complemento'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('cep'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('bairro'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('municipio'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('uf'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('email'));
        Memo1.Lines.Add(RESTResponse1.JSONValue.GetValue<string>('telefone'));
        btnOk.Enabled := false;
        tEdit.Enabled := false;
      end;
    
    end;
  
  

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Sleep(2000);
  btnOk.Enabled := True;
  tEdit.Text := '';
  tEdit.Enabled:= True;
  
end;

procedure TForm1.RESTRequest1HTTPProtocolError(Sender: TCustomRESTRequest);
begin
  tEdit.Text := '';
  raise Exception.Create('ERRO na pesquisa'+#13+
  'Verifique se existem pontos ou tra�os no campo de pesquisa!');
end;

end.

